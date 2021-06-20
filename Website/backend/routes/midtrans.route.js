const midtransController = require('../controllers/midtrans.controller');
const transactionValidator = require('../middlewares/transaction-validator.middleware');

module.exports = (app) => {
    app.post('/api/midtrans/notification-handler/', transactionValidator.getTransaksiWakafData, midtransController.handleNotification);
    app.post('/api/midtrans/check-status/', transactionValidator.getTransaksiWakafData, midtransController.checkTransactionStatus);
};