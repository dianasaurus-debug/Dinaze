const wakafBerjangkaController = require('../controllers/wakaf-berjangka.controller');
const adminValidator = require('../middlewares/admin-validator.middleware');
const wakifValidator = require('../middlewares/wakif-validator.middleware');

module.exports = (app) => {
    // END POINT WAKAF BERJANGKA UNTUK WAKIF
    app.post('/api/wakaf-berjangka/', wakifValidator.verifyToken, wakifValidator.getWakifData, wakafBerjangkaController.createNewWakafBerjangka);
    app.get('/api/wakaf-berjangka/', wakifValidator.verifyToken, wakifValidator.getWakifData, wakafBerjangkaController.getAllByUser);
    app.get('/api/wakaf-berjangka/:id', wakifValidator.verifyToken, wakafBerjangkaController.getById);

    // END POINT WAKAF BERJANGKA UNTUK ADMIN
    app.get('/api/admin/wakaf-berjangka/grafik/startdate/:startdate/enddate/:enddate',  adminValidator.verifyToken,wakafBerjangkaController.wakafBerjangkaGrafik);
    app.get('/api/admin/wakaf-berjangka/all', adminValidator.verifyToken, wakafBerjangkaController.displayAllWakaf);
    app.get('/api/admin/wakaf-berjangka/all/:user', adminValidator.verifyToken, wakafBerjangkaController.displayAllWakafUser);
    app.get('/api/admin/wakaf-berjangka/:id', adminValidator.verifyToken, wakafBerjangkaController.displayWakaf);
}
