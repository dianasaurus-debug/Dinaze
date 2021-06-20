const Admin = require('../models').Admin;
const jwt = require('jsonwebtoken');
const db = require('../models/index');
const Op = db.Sequelize.Op;
const config = require('../config/secret_admin');

module.exports = {
    verifyToken(req, res, next) {
        const tokenHeader = req.headers['x-access-token'];

        if (!tokenHeader) {
            return res.status(400).send({
                error: true,
                message: 'Token tidak ditemukan',
            });            
        } else {
            if (tokenHeader.split(' ')[0] !== 'Bearer') {
                return res.status(400).send({
                    error: true,
                    message: 'Format token salah',
                });               
            } else {
                const token = tokenHeader.split(' ')[1];
                jwt.verify(token, config.secret, (error, decoded) => {
                    if (error) {
                        res.status(401).send({
                            error: true,
                            message: error,
                        });
                    } else {
                        req.admin_id = decoded.id;
                        next();
                    }
                });
            }
        }
    },
    getAdminData(req, res, next) {
        return Admin.findOne({
            where: {
                id: req.admin_id
            }
        })
        .then((admin) => {
            req.data_admin = admin;
            next();
        })
        .catch((error) => console.log({
            error: true,
            message: error.message,
        }));
    },
};