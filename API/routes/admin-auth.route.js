const adminAuthController = require('../controllers/admin-auth.controller');

module.exports = (app) => {
    app.post('/api/admin-auth/register', adminAuthController.checkDuplicateUserNameOrEmail, adminAuthController.register);
    app.post('/api/admin-auth/login', adminAuthController.login);
}