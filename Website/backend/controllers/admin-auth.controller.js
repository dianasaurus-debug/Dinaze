const Admin = require('../models').Admin;
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('../models/index');
const Op = db.Sequelize.Op;
const config = require('../config/secret_admin');
module.exports = {
    checkDuplicateUserNameOrEmail(req, res, next) {
        Admin.findOne({
            where: {
                email: req.body.email
            }
        }).then((admin) => {
            if (admin) {
                res.status(400).send({
                    error: true,
                    message: 'Email sudah digunakan',
                });
                return;
            } else {
                next();
            }
        });
    },
    register(req, res) {
        return Admin.create({
            nama: req.body.nama,
            email: req.body.email,
            password: bcrypt.hashSync(req.body.password, 8)
        }).then((admin) => res.status(201).send({
            error: false,
            message: 'Berhasil registrasi akun admin',
            data: admin
        }))
        .catch((error) => res.status(500).send({
            error: true,
            message: error.message,
        }));
    },
    login(req, res) {
        const data = req.body;
        return Admin.findOne({
            where: {
                email: data.email
            }
        })
        .then((admin) => {
            if (!admin) {
                return res.status(404).send({
                    error: true,
                    message: 'Akun admin tidak ditemukan',
                });
            } else {
                const passwordIsValid = bcrypt.compareSync(data.password, admin.password);
                if (!passwordIsValid) {
                    return res.status(401).send({
                        error: true,
                        message: "Kata sandi salah",
                    });
                } else {
                    const token = 'Bearer ' + jwt.sign({
                        id: admin.id
                    }, config.secret, {
                        expiresIn: 86400 //24h expired
                    });
    
                    res.status(200).send({
                        error: false,
                        message: 'Berhasil masuk akun admin',
                        user : admin,
                        accessToken: token,
                        errors: null
                    });                    
                }
            }
        })
        .catch((error) => {
            res.status(500).send({
                error: true,
                message: error.message,
            });
        });
    }
}

