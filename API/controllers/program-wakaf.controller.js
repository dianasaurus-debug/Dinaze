const multer = require('multer');
const ProgramWakaf = require('../models').ProgramWakaf;
const fileUpload = require('../middlewares/upload-image.middleware');
const sequelize = require('sequelize');
const fs = require('fs');
const elasticsearch = require('elasticsearch');
const client = new elasticsearch.Client({
    hosts: [ 'http://localhost:9200']
});
module.exports = {
    uploadFile: function(req, res) {
        const upload = multer({
            storage: fileUpload.files.storageProgramWakaf(),
            fileFilter: fileUpload.files.fileFilter,
        })
        .single('file');

        upload(req, res, function (error) {
            if (error) {
                res.status(400).send({
                    error: true,
                    message: error.message,
                });
            } else {
                ProgramWakaf
                .create({
                    kategori_id: req.body.kategori_id,
                    judul: req.body.judul,
                    deskripsi: req.body.deskripsi,
                    gambar: req.file.filename,
                })
                .then((data) => res.status(201).send({
                    error: false,
                    message: 'Berhasil menambahkan program wakaf',
                    data: data
                }))
                .catch((error) => res.status(500).send({
                    error: true,
                    message: error,
                }));
            }
        })
    },
    destroyProgram(req, res) {
        ProgramWakaf
        .findByPk(req.params.id)
        .then(data => {
            if (!data) {
                res.status(400).send({
                    error: true,
                    message: 'Program wakaf tidak ditemukan',
                });
            } else {
                data
                .destroy()
                .then(() => {
                    fs.unlinkSync(`public/images/${data.gambar}`);
                    res.send({
                        error: false,
                        message: 'Berhasil menghapus program wakaf'
                    });
                })
                .catch((error) => res.status(400).send({
                    error: true,
                    message: error.message,
                }));
            }
        })
        .catch((error) => res.status(500).send({
            error: true,
            message: error.message,
        }));
    },
    displayAllPrograms(req, res) {
        ProgramWakaf
        .findAll({
            include: [
                'kategori',
            ],
            attributes: {
                include: [
                    [sequelize.literal('wakaf_abadi_terkumpul(`ProgramWakaf`.`id`)'), 'wakaf_abadi_terkumpul'],
                    [sequelize.literal('wakaf_berjangka_terkumpul(`ProgramWakaf`.`id`)'), 'wakaf_berjangka_terkumpul']
                ]
            },
            order: [
                ['id', 'ASC']
            ],
        })
        .then((data) => {
            if (data.length > 0) {
                res.send({
                    error: false,
                    message: 'Berhasil menampilkan semua program wakaf',
                    data: data
                });
            } else {
                res.status(400).send({
                    error: true,
                    empty: true,
                    message: 'Data program wakaf kosong',
                })
            }
        })
        .catch((error) => res.status(500).send({
            error: true,
            empty: false,
            message: error.message,
        }));
    },
    displayProgram(req, res) {
        ProgramWakaf
        .findByPk(req.params.id, {
            include: [
                'kategori',
            ],
            attributes: {
                include: [
                    [sequelize.literal('wakaf_abadi_terkumpul(`ProgramWakaf`.`id`)'), 'wakaf_abadi_terkumpul'],
                    [sequelize.literal('wakaf_berjangka_terkumpul(`ProgramWakaf`.`id`)'), 'wakaf_berjangka_terkumpul']
                ]
            },
        })
        .then((data) => {
            if (data) {
                res.send({
                    error: false,
                    message: 'Berhasil menampilkan program wakaf',
                    data: data,
                });
            } else {
                res.status(400).send({
                    error: true,
                    message: 'Program wakaf tidak ditemukan',
                });
            }
        })
        .catch((error) => res.status(500).send({
            error: true,
            message: error.message,
        }));
    },
    displayProgramByCategory(req, res) {
        ProgramWakaf
        .findAll({
            where: {
                kategori_id: req.params.id,
            },
            include: [
                'kategori',
            ],
            attributes: {
                include: [
                    [sequelize.literal('wakaf_abadi_terkumpul(`ProgramWakaf`.`id`)'), 'wakaf_abadi_terkumpul'],
                    [sequelize.literal('wakaf_berjangka_terkumpul(`ProgramWakaf`.`id`)'), 'wakaf_berjangka_terkumpul']
                ]
            },
            order: [
                ['id', 'ASC']
            ],
        })
        .then((data) => {
            if (data.length > 0) {
                res.send({
                    error: false,
                    message: 'Berhasil menampilkan program wakaf',
                    data: data,
                });
            } else {
                res.status(400).send({
                    error: true,
                    empty: true,
                    message: 'Program wakaf tidak ditemukan',
                });
            }
        })
        .catch((error) => res.status(500).send({
            error: true,
            empty: false,
            message: error.message,
        }));
    },

    updateProgram(req, res) {
        const id = req.params.id;
        var upload = multer({
            storage: fileUpload.files.storage(),
            allowedFile:fileUpload.files.allowedFile
        }).single('file');
        upload(req, res, function (err) {
            if (err instanceof multer.MulterError) {
                res.send(err);
            } else if (err) {
                res.send(err);
            } else {
                let programWakaf;
                if(req.file){
                    programWakaf = {
                        kategori_id: req.body.kategori_id,
                        judul: req.body.judul,
                        deskripsi: req.body.deskripsi,
                        gambar: req.file.filename,
                    };
                } else {
                    programWakaf = {
                        kategori_id: req.body.kategori_id,
                        judul: req.body.judul,
                        deskripsi: req.body.deskripsi,
                    };
                }
                ProgramWakaf.findByPk(id)
                    .then((program) => {
                        if(program){
                            let path = `public/images/${program.gambar}`
                            if (fs.existsSync(path)) {
                                fs.unlinkSync(path)
                            }
                            program.update(programWakaf).then(function() {
                                res.status(200).send({
                                    error: false,
                                    message: 'program wakaf sukses diupdate',
                                })
                            }).catch(function(err) {
                                res.status(200).send({
                                    error: true,
                                    message: err.message,
                                })
                            });
                        } else {
                            res.status(500).send({
                                error: true,
                                message: 'program not found',
                            })
                        }
                    })
                    .catch((err) => {
                        console.log('eror');
                        res.status(500).send({
                            error: true,
                            message: err.message,
                        })
                    })
            }
        })
    },
    search(req, res) {
        ProgramWakaf
        .findAll({
            where: {
                judul: {
                    [sequelize.Op.like]: '%' + req.params.query + '%',
                }
            },
            include: [
                'kategori',
            ],
            attributes: {
                include: [
                    [sequelize.literal('wakaf_abadi_terkumpul(`ProgramWakaf`.`id`)'), 'wakaf_abadi_terkumpul'],
                    [sequelize.literal('wakaf_berjangka_terkumpul(`ProgramWakaf`.`id`)'), 'wakaf_berjangka_terkumpul']
                ]
            },
            order: [
                ['id', 'ASC']
            ],
        })
        .then((data) => {
            if (data.length > 0) {
                res.send({
                    error: false,
                    message: 'Berhasil menampilkan program wakaf',
                    data: data,
                });
            } else {
                res.send({
                    error: true,
                    empty: true,
                    message: 'Program wakaf tidak ditemukan',
                });
            }
        })
        .catch((error) => res.status(500).send({
            error: true,
            empty: false,
            message: error.message,
        }));
    },
    cariProgramES(req, res){
        // declare the query object to search elastic search and return only 200 results from the first result found.
        // also match any data where the name is like the query string sent in
        let body = {
            size: 200,
            from: 0,
            query: {
                match: {
                    judul: req.query['q']
                }
            }
        }
        // perform the actual search passing in the index, the search query and the type
        client.search({index:'wakafku',  body:
                {query:
                        {
                            bool:
                                {
                                    must:
                                        [
                                            {bool:
                                                    {
                                                        must:
                                                            {
                                                                bool:{
                                                                    should:[
                                                                        {
                                                                            multi_match:
                                                                                {
                                                                                    query:req.query['q'],
                                                                                    fields:['judul','judul.raw','judul.search'],
                                                                                    type:"best_fields",
                                                                                    operator:"and",fuzziness:0

                                                                                }

                                                                        },
                                                                        {
                                                                            multi_match:
                                                                                {
                                                                                    query:req.query['q'],
                                                                                    fields:['judul','judul.raw','judul.search'],
                                                                                    type:"phrase",
                                                                                    operator:"and"

                                                                                }

                                                                        },
                                                                        {
                                                                            multi_match:
                                                                                {
                                                                                    query:req.query['q'],
                                                                                    fields:['judul','judul.raw'],
                                                                                    type:"phrase_prefix",
                                                                                    operator:"and"

                                                                                }

                                                                        }
                                                                    ],
                                                                    minimum_should_match:1

                                                                }

                                                            }

                                                    }

                                            }
                                        ]

                                }
                        },
                    size:10,
                    _source:{
                        includes:["*"],
                        excludes:[]}

                }
        })
            .then(results => {
                res.send(results.hits.hits);
            })
            .catch(err=>{
                console.log(err)
                res.send([]);
            });
    }
}
