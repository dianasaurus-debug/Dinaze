const riwayatWakafController = require('../controllers/riwayat-wakaf.controller');
const wakifValidator = require('../middlewares/wakif-validator.middleware');

module.exports = (app) => {
    // END POINT SEMUA JENIS WAKAF TERBARU
    app.get('/api/riwayat-wakaf/all', riwayatWakafController.displayAllWakaf);
    app.get('/api/riwayat-wakaf/', wakifValidator.verifyToken, wakifValidator.getWakifData, riwayatWakafController.getByUser);
    app.get('/api/riwayat-wakaf/:id', wakifValidator.verifyToken, riwayatWakafController.getByProgram);
}
