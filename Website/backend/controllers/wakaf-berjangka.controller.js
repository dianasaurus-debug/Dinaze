const WakafBerjangka = require('../models').WakafBerjangka;
const Program = require('../models').Program;
const midtransClient = require('midtrans-client');
const midtransController = require('./midtrans.controller');
const { v4: uuidv4 } = require('uuid');
const elasticsearch = require('elasticsearch');
const client = new elasticsearch.Client({
    hosts: [ 'https://elastic:ghqLGTi1IA731kSVZBbkiZ32@wakafku-es.es.eastus2.azure.elastic-cloud.com:9243']
});
const moment = require('moment')
function getJatuhTempo(jangkaWaktu) {
  const jatuhTempo = new Date();
  jatuhTempo.setFullYear(jatuhTempo.getFullYear() + parseInt(jangkaWaktu));
  return jatuhTempo;
}

module.exports = {
    displayAllWakaf(req, res) {
        WakafBerjangka.findAll({
            include: [
                'wakif',
                'program_wakaf',
            ],
        })
            .then(data => {
                res.send(data);
            })
            .catch(err => {
                res.status(500).send({
                    message:
                        err.message || "Some error occurred while retrieving wakaf."
                });
            });
    },
    displayAllWakafUser(req, res) {
        WakafBerjangka.findAll({
            where : {
                UserId : req.params.user
            },
            include: [
                'wakif',
                'program_wakaf',
            ],
        })
            .then(data => {
                res.send(data);
            })
            .catch(err => {
                res.status(500).send({
                    message:
                        err.message || "Some error occurred while retrieving wakaf Berjangka list."
                });
            });
    },
    displayWakaf(req, res){
        WakafBerjangka.findByPk(req.params.id, {
            include: [
                'wakif',
                'program_wakaf',
            ]})
            .then(data => {
                res.send(data);
            })
            .catch(err => {
                res.status(500).send({
                    message: "Error retrieving Wakaf Berjangka with id=" + id
                });
            });
    },
    createNewWakafBerjangka(req, res) {
        const data = req.body;
        WakafBerjangka.create({
            id: uuidv4(),
            program_wakaf_id: data.program_wakaf_id,
            wakif_id: req.data_wakif.id,
            nominal: data.nominal,
            nama_wakif: data.nama_wakif,
            metode_pembayaran: data.metode_pembayaran,
            jangka_waktu: data.jangka_waktu,
            jatuh_tempo: getJatuhTempo(data.jangka_waktu),
            nama_bank: data.nama_bank,
            nomor_rekening: data.nomor_rekening,
            nama_pemilik_rekening: data.nama_pemilik_rekening,
        })
        .then((result) => {
            console.log(result);
            req.data_wakaf = result;
            req.data_wakaf.jenis_wakaf = 'B';
            if (data.jenis_pembayaran === 'cstore') {
                midtransController.createCStorePayment(req, res);
            } else if (data.jenis_pembayaran === 'bank') {
                midtransController.createBankTransferPayment(req, res);
            } else if (data.jenis_pembayaran === 'qris') {
                midtransController.createQrisPayment(req, res);
            }
        })
        .catch((error) => res.status(500).send({
            error: true,
            message: error.message,
        }));
    },
    getAllByUser(req, res) {
        WakafBerjangka.findAll({
            where: {
                wakif_id: req.data_wakif.id,
            },
            include: [
                'wakif',
                'program_wakaf',
            ],
            order: [
                ['created_at', 'DESC']
            ]
        })
        .then((data) => {
            if (data.length > 0) {
                res.send({
                    error: false,
                    message: 'Berhasil menampilkan seluruh data wakaf berjangka',
                    data: data,
                });
            } else {
                res.send({
                    error: true,
                    message: 'Data wakaf berjangka kosong',
                });
            }
        })
        .catch((error) => res.status(500).send({
            error: true,
            message: error.message,
        }));
    },
    getById(req, res) {
        WakafBerjangka.findByPk(req.params.id, {
            include: [
                'wakif',
                'program_wakaf',
            ],
        })
        .then((data) => {
            if (!data) {
                res.send({
                    error: true,
                    message: 'Data wakaf berjangka tidak ditemukan',
                });
            } else {
                res.send({
                    error: false,
                    message: 'Berhasil menampilkan data wakaf berjangka',
                    data: data,
                });
            }
        })
        .catch((error) => res.status(500).send({
            error: true,
            message: error.message,
        }));
    },
    wakafBerjangkaGrafik(req, res) {
        if (req.params.startdate != 'none' && req.params.enddate != 'none') {
            client.search({
                index: 'wakaf_berjangka',
                body: {
                    aggs: {
                        "data": {
                            date_histogram: {
                                field: "created_at",
                                fixed_interval: "12h",
                                time_zone: "Asia/Bangkok"
                            },
                            aggs: {
                                "terkumpul": {
                                    sum: {
                                        field: "nominal",
                                    }
                                }
                            }
                        }
                    },
                    size: 0,
                    fields: [
                        {
                            field: "@timestamp",
                            format: "date_time"
                        },
                        {
                            field: "created_at",
                            format: "date_time"
                        },
                        {
                            field: "updated_at",
                            format: "date_time"
                        }
                    ],
                    script_fields: {},
                    stored_fields: ["*"],
                    runtime_mappings: {},
                    _source: {
                        excludes: []
                    },
                    query: {
                        bool: {
                            must: [],
                            filter: [
                                {
                                    match_all: {}
                                },
                                {
                                    match_all: {}
                                },
                                {
                                    range: {
                                        created_at: {
                                            gte: req.params.startdate,
                                            lte: req.params.enddate,
                                            format: "strict_date_optional_time"
                                        }
                                    }
                                }
                            ],
                            should: [],
                            must_not: []
                        }
                    }
                }
            })
                .then(function (resp) {
                    var resData = resp.aggregations.data.buckets;
                    var dataArray = [];
                    resData.forEach(data => {
                        if (data.terkumpul.value != 0)
                            dataArray.push({
                                "tanggal": moment(data.key_as_string)
                                    .format("DD/MM/YYYY"),
                                "count": data.terkumpul.value
                            });
                    })
                    res.status(200)
                        .send(dataArray)
                }, function (err) {
                    res.status(500)
                        .send({
                            error: true,
                            message: err.message,
                        })
                })
        } else if(req.params.startdate == 'none' && req.params.enddate == 'none'){
            client.search({
                index: 'wakaf_berjangka',
                body: {
                    aggs: {
                        "data": {
                            date_histogram: {
                                field: "created_at",
                                fixed_interval: "12h",
                                time_zone: "Asia/Bangkok"
                            },
                            aggs: {
                                "terkumpul": {
                                    sum: {
                                        field: "nominal",
                                    }
                                }
                            }
                        }
                    },
                    size: 0,
                    fields: [
                        {
                            field: "@timestamp",
                            format: "date_time"
                        },
                        {
                            field: "created_at",
                            format: "date_time"
                        },
                        {
                            field: "updated_at",
                            format: "date_time"
                        }
                    ],
                    script_fields: {},
                    stored_fields: ["*"],
                    runtime_mappings: {},
                    _source: {
                        excludes: []
                    },
                    query: {
                        bool: {
                            must: [],
                            filter: [
                                {
                                    match_all: {}
                                },
                                {
                                    match_all: {}
                                },
                            ],
                            should: [],
                            must_not: []
                        }
                    }
                }
            })
                .then(function (resp) {
                    var resData = resp.aggregations.data.buckets;
                    var dataArray = [];
                    resData.forEach(data => {
                        if (data.terkumpul.value != 0)
                            dataArray.push({
                                "tanggal": moment(data.key_as_string)
                                    .format("DD/MM/YYYY"),
                                "count": data.terkumpul.value
                            });
                    })
                    res.status(200)
                        .send(dataArray)
                }, function (err) {
                    res.status(500)
                        .send({
                            error: true,
                            message: err.message,
                        })
                })
        }
    }
}
