const kategoriController = require('../controllers/kategori.controller');
const adminValidator = require('../middlewares/admin-validator.middleware');
const wakifValidator = require('../middlewares/wakif-validator.middleware');

module.exports = function (app) {
    // END POINT KATEGORI UNTUK WAKIF
    app.get('/api/kategori/view/:id', wakifValidator.verifyToken, kategoriController.displayCategory);
    app.get('/api/kategori/all', wakifValidator.verifyToken, kategoriController.displayAllCategories);

    // END POINT KATEGORI UNTUK ADMIN
    app.post('/api/admin/kategori', adminValidator.verifyToken, kategoriController.uploadFile);
    app.get('/api/admin/kategori/view/:id', adminValidator.verifyToken, kategoriController.displayCategory);
    app.put('/api/admin/kategori/:id', adminValidator.verifyToken, kategoriController.updateKategori);
    app.get('/api/admin/kategori/all', adminValidator.verifyToken, kategoriController.displayAllCategories);
    app.delete('/api/admin/kategori/:id', adminValidator.verifyToken, kategoriController.destroyCategory);
    
}
