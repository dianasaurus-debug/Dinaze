const laporanController = require('../controllers/laporan.controller');
const adminValidator = require('../middlewares/admin-validator.middleware');
const wakifValidator = require('../middlewares/wakif-validator.middleware');

module.exports = function (app) {
    app.post('/api/laporan',adminValidator.verifyToken, laporanController.uploadFile);
    app.get('/api/laporan/all', laporanController.displayAllLaporan);
    app.delete('/api/laporan/:id', adminValidator.verifyToken, laporanController.destroyLaporan);
    app.get('/api/laporan/view/:id', laporanController.displayLaporan);
    app.get('/api/laporan/view/byprogram/:id', laporanController.displayLaporanBasedProgram);

    //END POINT UNTUK WAKIF
    app.get('/api/laporan/:id', wakifValidator.verifyToken, laporanController.displayLaporanBasedProgram);
}
