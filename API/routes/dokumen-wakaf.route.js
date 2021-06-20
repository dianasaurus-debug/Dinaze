const dokumenWakafController = require('../controllers/dokumen-wakaf.controller');
const adminValidator = require('../middlewares/admin-validator.middleware');
const wakifValidator = require('../middlewares/wakif-validator.middleware');

module.exports = (app) => {
    // // END POINT WAKAF ABADI UNTUK WAKIF
    app.get('/api/dokumen/:jenis_wakaf/download/:jenis_file/:id', wakifValidator.verifyToken, dokumenWakafController.downloadDokumen);

    //END POINT WAKAF ABADI UNTUK ADMIN
    app.post('/api/admin/upload-dokumen/:jenis_wakaf/:id', adminValidator.verifyToken, dokumenWakafController.uploadAktadanSertifikat);
    app.put('/api/admin/update-dokumen/:jenis_wakaf/:id', adminValidator.verifyToken, dokumenWakafController.updateDokumen);
    app.delete('/api/admin/delete-dokumen/:jenis_wakaf/:id', adminValidator.verifyToken, dokumenWakafController.destroyDokumen);
    app.get('/api/admin/dokumen/:jenis_wakaf/download/:jenis_file/:id', adminValidator.verifyToken, dokumenWakafController.downloadDokumen);

}
