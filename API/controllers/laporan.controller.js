const multer = require('multer');
const Laporan = require('../models').Laporan;
const fileUpload= require('../middlewares/upload-image.middleware');
const fs = require('fs');

module.exports = {
    uploadFile:function(req,res){
        const upload = multer({
            storage: fileUpload.files.storageLaporan(),
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
                Laporan
                .create({
                    deskripsi: req.body.deskripsi,
                    gambar: req.file.filename,
                    program_wakaf_id : req.body.program_wakaf_id,
                })
                .then(data => {
                    res.send(data);
                })
                .catch((error) => res.status(500).send({
                    error: true,
                    message: error.message
                }));
            }
        })
    },
    displayAllLaporan(req, res) {
        Laporan.findAll()
            .then(data => {
                res.send(data);
            })
            .catch(err => {
                res.status(500).send({
                    message:
                        err.message || "Some error occurred while retrieving laporan."
                });
            });
    },
    destroyLaporan(req, res){
        return Laporan
            .findByPk(req.params.id)
            .then(laporan => {
                fs.unlinkSync(`public/images/${laporan.gambar}`);
                if (!laporan) {
                    return res.status(400).send({
                        message: 'Laporan Not Found',
                    });
                }
                return laporan
                    .destroy()
                    .then(() => res.status(204).send())
                    .catch((error) => res.status(400).send(error));
            })
            .catch((error) => res.status(400).send(error));
    },
    displayLaporan(req, res){
        Laporan.findByPk(req.params.id)
            .then(data => {
                res.send(data);
            })
            .catch(err => {
                res.status(500).send({
                    message: "Error retrieving Laporan with id=" + req.params.id
                });
            });
    },
    displayLaporanBasedProgram(req, res) {
        Laporan
        .findAll({
            where: {
                program_wakaf_id: req.params.id
            },
            order: [
                ['created_at', 'DESC']
            ]
        })
        .then((data) => {
            if (data.length > 0) {
                res.send({
                    error: false,
                    message: 'Berhasil menampilkan laporan',
                    data: data,
                });
            } else {
                res.send({
                    error:true,
                    empty: true,
                    message: 'Laporan tidak ditemukan',
                });
            }
        })
        .catch((error) => res.status(500).send({
            error: true,
            empty: false,
            message: error.message
        }));
    }
}
