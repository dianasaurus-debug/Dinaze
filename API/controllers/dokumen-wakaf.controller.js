const multer = require('multer');
const WakafAbadi = require('../models').WakafAbadi;
const WakafBerjangka = require('../models').WakafBerjangka;
const fileUpload = require('../middlewares/upload-dokumen.middleware');
const http = require('http');
const fs = require('fs');
const uploadDokumen = multer({
    storage: fileUpload.files.storageDokumen(),
    fileFilter: fileUpload.files.fileFilter,
}).fields([{name: 'akta', maxCount: 1}, {name: 'sertifikat', maxCount: 1}]);

module.exports = {
    uploadAktadanSertifikat: function (req, res) {
        uploadDokumen(req, res, async function (error) {
            if (error) {
                res.status(400).send({
                    error: true,
                    message: error.message,
                });
            } else {
                var modelWakaf;
                if(req.params.jenis_wakaf=='abadi'){
                    modelWakaf = WakafAbadi;
                } else if(req.params.jenis_wakaf=='berjangka') {
                    modelWakaf = WakafBerjangka;
                }
                const dataDokumen = {
                    nama_file_akta: req.files.akta[0].filename,
                    nama_file_sertifikat: req.files.sertifikat[0].filename,
                }
                const dataWakaf = await modelWakaf.findOne({where: {id: req.params.id}});
                if (dataWakaf.status_pembayaran == 'success') {
                    dataWakaf.update(dataDokumen)
                        .then((data) => res.status(201).send({
                            error: false,
                            message: 'Berhasil menambahkan akta dan sertifikat',
                            data: data
                        }))
                        .catch((error) => res.status(500).send({
                            error: true,
                            message: error,
                        }));
                } else {
                    res.status(500).send({
                        error: true,
                        message: 'Wakaf belum berstatus sukses',
                    })
                }
            }
        })
    },
    updateDokumen(req, res) {
        var modelWakaf;
        if(req.params.jenis_wakaf=='abadi'){
            modelWakaf = WakafAbadi;
        } else if(req.params.jenis_wakaf=='berjangka') {
            modelWakaf = WakafBerjangka;
        }
        modelWakaf.findByPk(req.params.id).then(result=>{
          if(result){
              uploadDokumen(req, res, async function (error) {
                  if(error){
                      res.status(400).send({
                          error: true,
                          message: error.message,
                      });
                  } else {
                      if(req.files){
                          var fileToUpdate = {};
                          if(req.files.sertifikat && req.files.akta){
                              if (result.nama_file_sertifikat != null) fs.unlinkSync(`public/dokumen/sertifikat/${result.nama_file_sertifikat}`);
                              if (result.nama_file_akta != null) fs.unlinkSync(`public/dokumen/akta/${result.nama_file_akta}`);
                              fileToUpdate = {
                                    nama_file_akta: req.files.akta[0].filename,
                                    nama_file_sertifikat: req.files.sertifikat[0].filename,
                              }
                          } else if (req.files.sertifikat!=undefined&&req.files.akta==undefined){
                              if (result.nama_file_sertifikat != null) fs.unlinkSync(`public/dokumen/sertifikat/${result.nama_file_sertifikat}`);
                              fileToUpdate = {
                                  nama_file_sertifikat: req.files.sertifikat[0].filename,
                              }
                          } else if (req.files.sertifikat==undefined&&req.files.akta!=undefined){
                              if (result.nama_file_akta != null) fs.unlinkSync(`public/dokumen/akta/${result.nama_file_akta}`);
                              fileToUpdate = {
                                  nama_file_akta: req.files.akta[0].filename,
                              }
                          }
                          result.update(
                              fileToUpdate
                          ).then((data) => res.status(201).send({
                              error: false,
                              message: 'Berhasil update akta dan sertifikat',
                              data: data
                          })).catch((error) => res.status(500).send({
                              error: true,
                              message: error,
                          }));
                      }
                  }
              });
          }
      })
    },
    downloadDokumen(req, res) {
        var modelWakaf;
        if(req.params.jenis_wakaf=='abadi'){
            modelWakaf = WakafAbadi;
        } else if(req.params.jenis_wakaf=='berjangka') {
            modelWakaf = WakafBerjangka;
        }
        modelWakaf.findByPk(req.params.id).then(dataDokumen => {
            var fileName = '';
            if (req.params.jenis_file == 'sertifikat') {
                fileName = dataDokumen.nama_file_sertifikat
                res.redirect(req.protocol + '://' + req.get('host') + '/dokumen/sertifikat/' + fileName)
            } else if (req.params.jenis_file == 'akta') {
                fileName = dataDokumen.nama_file_akta
                res.redirect(req.protocol + '://' + req.get('host') + '/dokumen/akta/' + fileName)
            }
        })
    },
    destroyDokumen(req, res){
        var modelWakaf;
        if(req.params.jenis_wakaf=='abadi'){
            modelWakaf = WakafAbadi;
        } else if(req.params.jenis_wakaf=='berjangka') {
            modelWakaf = WakafBerjangka;
        }
        modelWakaf.findByPk(req.params.id).then(result=>{
            if (result.nama_file_sertifikat != null) fs.unlinkSync(`public/dokumen/sertifikat/${result.nama_file_sertifikat}`);
            if (result.nama_file_akta != null) fs.unlinkSync(`public/dokumen/akta/${result.nama_file_akta}`);
            result.update({
                nama_file_sertifikat : null,
                nama_file_akta : null
            }).then(response=>{
                res.status(201).send({
                    error: false,
                    message: 'Berhasil menghapus akta dan sertifikat',
                    data: response
                });
            }).catch(err=>{
                res.status(500).send({
                    error: true,
                    message: 'Data dokumen tidak bisa dihapus!',
                    detail : err
                })
            })
        }).catch(err=>{
            res.status(500).send({
                error: true,
                message: 'Data dokumen tidak ditemukan',
                detail : err
            })
        })
    }
}
