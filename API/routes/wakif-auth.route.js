const wakifAuthController = require('../controllers/wakif-auth.controller');
const wakifValidator = require('../middlewares/wakif-validator.middleware');
const validator = require('../middlewares/validator');
const adminController = require('../controllers/admin.controller');
const adminValidator = require('../middlewares/admin-validator.middleware');

module.exports = (app) => {
    app.post('/api/wakif-auth/register', validator.validateUserRegistration, wakifAuthController.checkDuplicateEmail, wakifAuthController.register);
    app.post('/api/wakif-auth/login', wakifAuthController.login);
    app.post('/api/wakif-auth/logout', wakifValidator.verifyToken, wakifValidator.getWakifData, wakifAuthController.logout);
    app.put('/api/wakif-auth/update', validator.validateUpdateProfile, wakifValidator.verifyToken, wakifValidator.getWakifData, wakifAuthController.update);
    app.put('/api/wakif-auth/upload-photo', wakifValidator.verifyToken, wakifValidator.getWakifData, wakifAuthController.uploadPhoto);
    app.get('/api/wakif-auth/get-wakif-data', wakifValidator.verifyToken, wakifAuthController.getWakifData);
    app.put('/api/wakif-auth/change-password', wakifValidator.verifyToken, wakifValidator.getWakifData, wakifAuthController.changePassword);
    app.post('/api/wakif-auth/reset-password/request', wakifAuthController.requestResetPasswordToken);
    app.post('/api/wakif-auth/reset-password/verify', wakifAuthController.verifyResetPasswordToken);
    app.post('/api/wakif-auth/reset-password', wakifAuthController.resetPassword);
    app.post('/api/wakif-auth/google', wakifAuthController.googleAuth);
    //END-POINT UNTUK ADMIN
    app.get('/api/admin/users/all', adminValidator.verifyToken, adminController.displayAllUser);

}
