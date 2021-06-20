const programController = require('../controllers/program-wakaf.controller');
const adminValidator = require('../middlewares/admin-validator.middleware');
const wakifValidator = require('../middlewares/wakif-validator.middleware');

module.exports = function (app) {
    // END POINT PROGRAM WAKAF UNTUK WAKIF
    app.get('/api/program-wakaf/all', wakifValidator.verifyToken, programController.displayAllPrograms);
    app.get('/api/program-wakaf/view/:id', wakifValidator.verifyToken, programController.displayProgram);
    app.get('/api/program-wakaf/category/:id', wakifValidator.verifyToken, programController.displayProgramByCategory);
    app.get('/api/program-wakaf/search/:query', wakifValidator.verifyToken, programController.search);
    app.get('/api/program-wakaf/es/cari', wakifValidator.verifyToken, programController.cariProgramES); //example : http://localhost:4000/api/program-wakaf/es/cari?q=kalisa
    // END POINT PROGRAM WAKAF UNTUK ADMIN
    app.post('/api/admin/program-wakaf', adminValidator.verifyToken, programController.uploadFile);
    app.get('/api/admin/program-wakaf/all', adminValidator.verifyToken, programController.displayAllPrograms);
    app.delete('/api/admin/program-wakaf/:id', adminValidator.verifyToken, programController.destroyProgram);
    app.get('/api/admin/program-wakaf/view/:id', adminValidator.verifyToken, programController.displayProgram);
    app.put('/api/admin/program-wakaf/:id', adminValidator.verifyToken, programController.updateProgram);

}
