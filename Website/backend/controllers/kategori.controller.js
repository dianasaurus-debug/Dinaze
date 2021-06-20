const multer = require('multer');
const Kategori = require('../models').Kategori;
const fileUpload= require('../middlewares/upload-image.middleware');
const fs = require('fs');

module.exports = {
    uploadFile:function(req,res){
        var upload = multer({
            storage: fileUpload.files.storage(),
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
                Kategori
                .create({
                    nama: req.body.nama,
                    deskripsi : req.body.deskripsi,
                    gambar: req.file.filename,
                    ikon_flutter: req.body.ikon_flutter,
                })
                .then((data) => res.send({
                    error: false,
                    message: "Berhasil menambahkan kategori",
                    data: data
                }))
                .catch((error) => res.status(500).send({
                    error: true,
                    message: error
                }));
            }

        })

    },
    displayAllCategories(req, res) {
        Kategori.findAll()
            .then((kategori) => {
                if (kategori.length > 0) {
                    res.send({
                        error: false,
                        message: 'Berhasil menampilan semua kategori',
                        data: kategori
                    });
                } else {
                    res.send({
                        error: true,
                        message: 'Data kategori kosong',
                        empty: true,
                    });
                }
            })
            .catch((error) => res.status(500).send({
                error: true,
                message: error
            }));
    },
    destroyCategory(req, res){
        return Kategori.findByPk(req.params.id)
            .then((data) => {
                if (!data) {
                    return res.status(404).send({
                        error: true,
                        message: 'Kategori tidak ditemukan',
                    });
                } else {
                    return data.destroy()
                    .then(() => {
                        fs.unlinkSync(`public/images/${data.gambar}`);
                        res.status(200).send({
                            error: false,
                            message: 'Berhasil menghapus kategori',
                        })
                    })
                    .catch((error) => res.status(500).send({
                        error: true,
                        message: error,
                    }));
                }
            })
            .catch((error) => res.status(400).send({
                error: true,
                message: error,
            }));
    },
    displayCategory(req, res){
        Kategori.findByPk(req.params.id)
            .then((data) => {
                if (data) {
                    res.send({
                        error: false,
                        message: 'Berhasil menampilkan kategori',
                        data: data
                    });
                } else {
                    res.status(404).send({
                        error: true,
                        message: 'Kategori tidak ditemukan'
                    });
                }
            })
            .catch((error) => res.status(500).send({
                error: true,
                message: error
            }));
    },
    updateKategori(req, res) {
        const id = req.params.id
        var upload = multer({
            storage: fileUpload.files.storage(),
            allowedFile: fileUpload.files.allowedFile
        })
            .single('file')
        upload(req, res, function (err) {
            if (err instanceof multer.MulterError) {
                res.send(err)
            } else if (err) {
                res.send(err)
            } else {
                let kategori
                if (req.file) {
                    kategori = {
                        nama: req.body.nama,
                        deskripsi: req.body.deskripsi,
                        gambar: req.file.filename
                    }
                } else {
                    kategori = {
                        nama: req.body.nama,
                        deskripsi: req.body.deskripsi
                    }
                }
                Kategori.findByPk(id)
                    .then((kategori_data) => {
                        let path = `public/images/${kategori_data.gambar}`
                        if (kategori_data) {
                            if (fs.existsSync(path)) {
                                fs.unlinkSync(path)
                            }
                            kategori_data.update(kategori)
                                .then(function () {
                                    res.status(200)
                                        .send({
                                            error: false,
                                            message: 'program wakaf sukses diupdate'
                                        })
                                })
                                .catch(function (err) {
                                    res.status(200)
                                        .send({
                                            error: true,
                                            message: err.message
                                        })
                                })
                        } else {
                            res.status(500)
                                .send({
                                    error: true,
                                    message: 'program not found'
                                })
                        }
                    })
                    .catch((err) => {
                        console.log('eror')
                        res.status(500)
                            .send({
                                error: true,
                                message: err.message
                            })
                    })
            }
        })
    },
}
