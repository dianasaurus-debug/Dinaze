const multer = require('multer');

module.exports.files = {
    fileFilter: function(req, file, cb) {
        if (file.mimetype == "application/pdf") {
            cb(null, true);
        } else {
            cb(null, false);
            return cb(new Error('Anda hanya diperkenankan mengunggah file pdf!'));
        }
    },
    storageDokumen: function() {
        return multer.diskStorage({
            destination: function(req, file, cb) {
                if(file.fieldname=='akta'){
                    cb(null, 'public/dokumen/akta/');
                } else if(file.fieldname=='sertifikat') {
                    cb(null, 'public/dokumen/sertifikat/');
                }
            },
            filename: function(req, file, cb) {
                if(file.fieldname=='akta'){
                    cb(null, "Akta_" + Date.now() + file.originalname);
                } else if(file.fieldname=='sertifikat') {
                    cb(null, "Sertifikat_" + Date.now() + file.originalname);
                }
            },
        });
    },
}
