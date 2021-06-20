const multer = require('multer');

module.exports.files = {
    fileFilter: function(req, file, cb) {
        if (file.mimetype == "image/png" || file.mimetype == "image/jpg" || file.mimetype == "image/jpeg") {
            cb(null, true);
        } else {
            cb(null, false);
            return cb(new Error('Anda hanya diperkenankan mengunggah gambar!'));
        }
    },
    storage: function() {
        return multer.diskStorage({
            destination: function(req, file, cb) {
                cb(null, 'public/images/');
            },
            filename: function(req, file, cb) {
                cb(null, Date.now() + file.originalname);
            },
        });
    },
    storageProgramWakaf: function() {
        return multer.diskStorage({
            destination: function(req, file, cb) {
                cb(null, 'public/images/');
            },
            filename: function(req, file, cb) {
                cb(null, "ProgramWakaf_" + Date.now() + "_" + file.originalname);
            },
        });
    },
    storageLaporan: function() {
        return multer.diskStorage({
            destination: function(req, file, cb) {
                cb(null, 'public/images/');
            },
            filename: function(req, file, cb) {
                cb(null, "Laporan_" + Date.now() + "_" + file.originalname);
            },
        });
    },
    storageWakif: function() {
        return multer.diskStorage({
            destination: function(req, file, cb) {
                cb(null, 'public/images/');
            },
            filename: function(req, file, cb) {
                cb(null, "Wakif_" + Date.now() + "_" + file.originalname);
            },
        });
    },
}