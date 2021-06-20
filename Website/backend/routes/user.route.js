const wakifValidator = require('../middlewares/wakif-validator.middleware');
const userController = require('../controllers/user.controller');

module.exports = (app) => { 
  app.get('/api/user/index', wakifValidator.verifyToken, userController.userBoard);
}