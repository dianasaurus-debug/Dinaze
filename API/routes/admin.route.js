const adminValidator = require('../middlewares/admin-validator.middleware');
const adminController = require('../controllers/admin.controller');

module.exports = (app) => {
  app.get('/api/admin/index', adminValidator.verifyToken, adminController.adminBoard);
}