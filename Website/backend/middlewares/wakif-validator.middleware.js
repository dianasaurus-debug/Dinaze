const Wakif = require('../models').Wakif;
const jwt = require('jsonwebtoken');
const db = require('../models/index');
const Op = db.Sequelize.Op;
const config = require('../config/secret_wakif');

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
                            message: error.message,
                        });
                    } else {
                        req.wakif_id = decoded.id;
                        next();
                    }
                });
            }
        }
    },
    getWakifData(req, res, next) {
        Wakif
        .findByPk(req.wakif_id)
        .then((wakif) => {
            req.data_wakif = wakif;
            next();
        })
        .catch((error) => res.status(500).send({
            error: true,
            message: error.message,
        }));
    },
};