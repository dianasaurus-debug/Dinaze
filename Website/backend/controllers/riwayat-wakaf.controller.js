const WakafAbadi = require('../models').WakafAbadi;
const WakafBerjangka = require('../models').WakafBerjangka;
const _ = require('lodash');

module.exports = {
    displayAllWakaf(req, res) {
        const wakaf_abadi = WakafAbadi.findAll({include: ['wakif', 'program_wakaf'],});
        const wakaf_berjangka = WakafBerjangka.findAll({include: ['wakif', 'program_wakaf'],});
        Promise
            .all([wakaf_abadi, wakaf_berjangka])
            .then(responses => {
                const result = responses[0].concat(responses[1]);
                let data = _.orderBy(result, 'created_at', 'desc')
                res.send(data);
            })
            .catch(err => {
                res.send(err);
            });
    },
    getByUser(req, res) {
        const dataWakif = req.data_wakif;
        const wakafAbadi = WakafAbadi.findAll({
            where: {
                wakif_id: dataWakif.id,
            },
            include: ['program_wakaf'],
        });
        const wakafBerjangka = WakafBerjangka.findAll({
            where: {
                wakif_id: dataWakif.id,
            },
            include: ['program_wakaf'],
        });
        Promise
            .all([wakafAbadi, wakafBerjangka])
            .then((responses) => {
                const result = responses[0].concat(responses[1]);
                if (result.length > 0) {
                    const data = _.orderBy(result, 'created_at', 'desc');
                    res.send({
                        error: false,
                        message: 'Berhasil menampilkan seluruh riwayat wakaf!',
                        data: data,
                    });                    
                } else {
                    res.send({
                        error: true,
                        empty: true,
                        message: 'Riwayat wakaf kosong!',
                    });                    
                }
            })
            .catch((error) => {
                res.status(500).send({
                    error: true,
                    empty: false,
                    message: error.message,
                });
            });
    },
    getByProgram(req, res) {
        const wakafAbadi = WakafAbadi.findAll({
            where: {
                program_wakaf_id: req.params.id,
                status_pembayaran: 'success',
            },
        });
        const wakafBerjangka = WakafBerjangka.findAll({
            where: {
                program_wakaf_id: req.params.id,
                status_pembayaran: 'success',
            },
        });
        Promise
            .all([wakafAbadi, wakafBerjangka])
            .then((responses) => {
                const result = responses[0].concat(responses[1]);
                if (result.length > 0) {
                    const data = _.orderBy(result, 'created_at', 'desc');
                    res.send({
                        error: false,
                        message: 'Berhasil menampilkan seluruh riwayat wakaf!',
                        data: data,
                    });
                } else {
                    res.send({
                        error: true,
                        empty: true,
                        message: 'Riwayat wakaf kosong!',
                    });                    
                }
            })
            .catch((error) => {
                res.status(500).send({
                    error: true,
                    empty: false,
                    message: error.message,
                });
            });
    }
}
