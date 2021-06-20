const Wakif = require('../models').Wakif;
const Token = require('../models').Token;
const OneSignal = require('../models').OneSignal;
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('../models/index');
const Op = db.Sequelize.Op;
const config = require('../config/secret_wakif');
const emailService = require("../utils/email/sendEmail");
const crypto = require("crypto");
const multer = require('multer');
const fileUpload = require('../middlewares/upload-image.middleware');
const fs = require('fs');

function comparePassword(password, hashPassword) {
    return bcrypt.compareSync(password, hashPassword);
}

module.exports = {
    checkDuplicateEmail(req, res, next) {
        const data = req.body;
        Wakif.findOne({
            where: {
                email: data.email
            }
        })
        .then((wakif) => {
            if (wakif) {
                res.status(400).send({
                    error: true,
                    message: 'Alamat email sudah pernah digunakan',
                });
            } else {
                next();
            }
        });
    },
    register(req, res) {
        const data = req.body;
        Wakif.create({
            nama: data.nama,
            email: data.email,
            password: bcrypt.hashSync(data.password, 8)
        })
        .then((wakif) => res.status(201).send({
            error: false,
            data: wakif,
            message: 'Berhasil registrasi akun wakif',
        }))
        .catch((error) => res.status(500).send({
            error: true,
            message: error.message,
        }));
    },
    async login(req, res) {        
        try {
            const data = req.body;
            const wakif = await Wakif.findOne({
                where: {
                    email: data.email
                }
            });
            
            if (!wakif) {
                res.status(400).send({
                    error: true,
                    message: 'Akun wakif tidak ditemukan',
                });                                
            } else {
                if (!comparePassword(data.password, wakif.password)) {
                    res.status(401).send({
                        error: true,
                        message: 'Kata sandi salah',
                    });
                } else {
                    const token = 'Bearer ' + jwt.sign({
                        id: wakif.id
                    }, config.secret, {
                        expiresIn: 604800 //7 days expired
                    });

                    if (data.player_id) {
                        OneSignal.create({
                            wakif_id: wakif.id,
                            player_id: data.player_id,
                        });
                    }

                    res.status(200).send({
                        error: false,
                        message: 'Berhasil masuk akun wakif',
                        data: wakif,
                        accessToken: token,
                    });
                }
            }
        } catch (error) {
            res.status(500).send({
                error: true,
                message: error.message,
            });  
        }
        
    },
    logout(req, res) {
        OneSignal.destroy({
            where: {
                [Op.and]: [
                    {wakif_id: req.data_wakif.id},
                    {player_id: req.body.player_id},
                ],
            }            
        })
        .then((_) => res.send({
            error: false,
            message: 'Berhasil logout',
        }))
        .catch((error) => res.status(500).send({
            error: false,
            message: error.message,
        }));
    },
    update(req, res) {
        const data = req.body;
        req.data_wakif
        .update({
            nama: data.nama,
            email : data.email,
            nik : data.nik,
            nomor_ponsel: data.nomor_ponsel,
            alamat : data.alamat
        })
        .then(() => res.status(200).send({
            error: false,
            message: "Berhasil mengubah data wakif",
        }))
        .catch((error) => res.status(500).send({
            error: true,
            message: error.message,
        }));
    },
    uploadPhoto(req, res) {
        const data = req.data_wakif;
        const upload = multer({
            storage: fileUpload.files.storageWakif(),
            fileFilter: fileUpload.files.fileFilter,
        })
        .single('foto');

        upload(req, res, function (error) {
            if (error) {
                res.status(400).send({
                    error: true,
                    message: error.message,
                });
            } else {
                if (data.foto != null) fs.unlinkSync(`public/images/${data.foto}`);
                
                data
                .update({
                    foto: req.file.filename
                })
                .then(() => res.status(200).send({
                    error: false,
                    message: "Berhasil mengunggah foto",
                }))
                .catch((error) => res.status(500).send({
                    error: true,
                    message: error.message,
                }));
            }
        })
    },
    getWakifData(req, res) {
        Wakif
        .findByPk(req.wakif_id)
        .then((wakif) => {
            if (wakif) {
                res.send({
                    error: false,
                    message: 'Berhasil menampilkan data wakif',
                    data: wakif,
                });
            } else {
                res.status(500).send({
                    error: true,
                    message: 'Wakif tidak ditemukan'
                });
            }
        })
        .catch((error) => res.status(500).send({
            error: true,
            message: error.message,
        }));
    },
    changePassword(req, res) {
        const data = req.body;
        if (!comparePassword(data.old_password, req.data_wakif.password)) {
            res.status(400).send({
                error: true,
                message: 'Kata sandi lama salah',
            });
        } else {
            req.data_wakif
            .update({
                password: bcrypt.hashSync(data.new_password, 8),
            })
            .then(() => res.send({
                error: false,
                message: 'Berhasil mengubah kata sandi',
            }))
            .catch((error) => res.status(500).send({
                error: true,
                message: error.message,
            }));
        }
    },
    requestResetPasswordToken(req, res) {
        Wakif
        .findOne({
            where: {
                email: req.body.email
            }
        })
        .then((user) => {
            if (user) {
                Token
                .findOne({
                    where: {
                        email: user.email
                    }
                })
                .then((token) => {
                    if (token) token.destroy();
                    
                    const code = crypto.randomBytes(3).toString('hex');
                    const resetToken = parseInt(code.toString('hex'), 16).toString().substr(0, 6);
                    const hash = bcrypt.hashSync(resetToken, 8);
                    
                    Token.create({
                        email : user.email,
                        token : hash,
                    })
                    .then((result) => {
                        const code = resetToken;
                        
                        emailService.sendMail({
                            from : 'Badan Wakaf Indonesia',
                            to: user.email,
                            subject: "Kode Lupa Kata Sandi",
                            text: `Gunakan kode ini untuk mengatur ulang kata sandi akun Anda: ${code}. Kode hanya berlaku 10 menit.`,
                            html: `<p>Gunakan kode ini untuk mengatur ulang kata sandi akun Anda: <strong>${code}</strong>. Kode hanya berlaku 10 menit.</p>`,
                        });

                        res.send({ 
                            error: false,
                            message: 'Silakan cek email anda',
                            data: result,
                        });
                    })
                    .catch((error) => res.status(500).send({
                        error: true,
                        message: "eror buat token" + error.message
                    }));
                })
                .catch((error) => res.status(500).send({
                    error: true,
                    message: error.message
                }));
            } else {
                res.status(400).send({
                    error: true,
                    message: 'Akun wakif tidak ditemukan',
                });
            }
        })
        .catch((error) => res.status(500).send({
            error: true,
            message: error.message
        }));
    },
    verifyResetPasswordToken(req, res) {
        Token
        .findOne({
            where: {
                email: req.body.email
            }
        })
        .then((token) => {
            if (!token) {
                res.status(400).send({
                    error: true,
                    message: 'Token tidak ditemukan'
                });
            } else {
                if (!comparePassword(req.body.token, token.token)) {
                    res.status(400).send({
                        error: true,
                        message: 'Token salah atau kedaluwarsa',
                    });
                } else {
                    res.send({
                        error: false,
                        message: 'Verifikasi token berhasil',
                    });
                }    
            }
        })
        .catch((error) => res.status(500).send({
            error: true,
            message: error.message,
        }));
    },
    resetPassword(req, res) {
        Token
        .findOne({
            where: {
                email: req.body.email
            }
        })
        .then((token) => {
            if (token) {
                if (!comparePassword(req.body.token, token.token)) {
                    res.status(400).send({
                        error: true,
                        message: 'Token salah atau kedaluwarsa',
                    });
                } else {
                    Wakif
                    .findOne({
                        where: {
                            email: token.email
                        }
                    })
                    .then((wakif) => {
                        wakif.update({
                            password: bcrypt.hashSync(req.body.password, 8),
                        })
                        .then((user) => {
                            emailService.sendMail({
                                from : 'Badan Wakaf Indonesia - Wakaf Uang',
                                to: user.email,
                                subject: "Pemberitahuan - Atur Ulang Kata Sandi",
                                text: `Kata sandi berhasil diatur ulang.`,
                                html: `<p>Kata sandi berhasil diatur ulang.</p>`,
                            });
                            
                            token
                            .destroy()
                            .then((result) => res.send({
                                error: false,
                                message: 'Kata sandi berhasil diubah',
                            }))
                            .catch((error) => res.status(500).send({
                                error: true,
                                message: error.message
                            }));

                        })
                        .catch((error) => res.status(500).send({
                            error: true,
                            message: error.message
                        }));
                    })
                    .catch((error) => res.status(500).send({
                        error: true,
                        message: error.message
                    }));
                }
            } else {
                res.status(400).send({
                    error: true,
                    message: 'Token tidak ditemukan',
                });
            }
        })
        .catch((error) => res.status(500).send({
            error: true,
            message: error.message,
        }));
    }

}

