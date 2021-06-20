const WakafAbadi = require('../models').WakafAbadi;
const WakafBerjangka = require('../models').WakafBerjangka;
const midtransClient = require('midtrans-client');
const axios = require('axios');
let coreApi = new midtransClient.CoreApi();
coreApi.apiConfig.isProduction = false;
coreApi.apiConfig.serverKey = 'SB-Mid-server-e4XJJ3-QK_WKD9R-XAmvU1cS';
coreApi.apiConfig.clientKey = 'SB-Mid-client-1ldNQUjGzVJ7Dc-R';

async function updatePaymentCode(req, res) {
    const dataWakaf = req.data_wakaf;
    const waqfType = dataWakaf.jenis_wakaf;
    const id = dataWakaf.id;
    const paymentCode = dataWakaf.kode_pembayaran;

    if (waqfType === 'A') {
        let wakafAbadi = await WakafAbadi.findByPk(id, { 
            include: ['program_wakaf'] 
        });
        wakafAbadi = await wakafAbadi.update({
            kode_pembayaran: paymentCode
        });
        res.status(201).send({
            error: false,
            message: 'Berhasil membuat transaksi wakaf abadi',
            data: wakafAbadi,
        });
    } else {
        let wakafBerjangka = await WakafBerjangka.findByPk(id, { 
            include: ['program_wakaf'] 
        });
        wakafBerjangka = await wakafBerjangka.update({
            kode_pembayaran: paymentCode
        });
        res.status(201).send({
            error: false,
            message: 'Berhasil membuat transaksi wakaf berjangka',
            data: wakafBerjangka,
        });
    }
}

function updateStatus(transaksiWakaf, status) {
    if (transaksiWakaf['jenis'] === "Abadi") {
        WakafAbadi.update({
            status_pembayaran: status,
        },
        {
            where: {
                id: transaksiWakaf['id'],
            }
        });        
    } else if (transaksiWakaf['jenis'] === "Berjangka") {
        WakafBerjangka.update({
            status_pembayaran: status,
        },
        {
            where: {
                id: transaksiWakaf['id'],
            }
        });          
    }
}

function sendNotifications(transaksiWakaf, playerIds, status) {
    axios
    .post("https://onesignal.com/api/v1/notifications", {
        "app_id": "2a6c197f-8089-421f-ba09-9c7b8af9c215",
        "contents": {
            "en": `Pembayaran wakaf uang ${transaksiWakaf['jenis'].toLowerCase()} dengan ID ${transaksiWakaf['id']} telah kami terima`
        },
        "headings": {
            "en": "Status Pembayaran"
        },
        "data": {
            "jenis_wakaf": transaksiWakaf['jenis'],
            "id": transaksiWakaf['id'],
        },
        "include_player_ids": playerIds
    })
    .then((response) => console.log(response))
    .catch((error) => console.log(error));
};

function getPlayerIdList(playerIds) {
    let result = [];
    playerIds.forEach((data) => result.push(data['player_id']));
    return result;
}

module.exports = {
    createBankTransferPayment(req, res) {
        const dataWakif = req.data_wakif;
        const dataWakaf = req.data_wakaf;
        coreApi.charge({
            "payment_type": "bank_transfer",
            "transaction_details": {
                "gross_amount": req.body.nominal,
                "order_id": dataWakaf.jenis_wakaf + "-" + dataWakaf.id,
            },
            "customer_details": {
                "first_name": dataWakif.nama,
                "email": dataWakif.email,
                "phone": dataWakif.nomor_telepon,
            },
            "bank_transfer": {
                "bank": dataWakaf.metode_pembayaran,
            }
        })
        .then((response) => {
            const payment_code = response.va_numbers[0].va_number;
            dataWakaf.kode_pembayaran = payment_code;
            updatePaymentCode(req, res);
        })
        .catch((error) => res.status(500).send({
            error: true,
            message: error,
        }));
    },
    createCStorePayment(req, res) {
        const dataWakif = req.data_wakif;
        const dataWakaf = req.data_wakaf;
        coreApi.charge({
            "payment_type": "cstore",
            "transaction_details": {
                "gross_amount": req.body.nominal,
                "order_id": dataWakaf.jenis_wakaf + "-" + dataWakaf.id,
            },
            "customer_details": {
                "first_name": dataWakif.nama,
                "email": dataWakif.email,
                "phone": dataWakif.nomor_telepon,
            },
            "cstore": {
                "store": dataWakaf.metode_pembayaran,
            }
        })
        .then((response) => {
            const payment_code = response.payment_code;
            dataWakaf.kode_pembayaran = payment_code;
            updatePaymentCode(req, res);
        })
        .catch((error) => res.status(500).send({
            error: true,
            message: error.apiResponse,
        }));
    },
    createQrisPayment(req, res) {
        const dataWakif = req.data_wakif;
        const dataWakaf = req.data_wakaf;
        coreApi.charge({
            "payment_type": "gopay",
            "transaction_details": {
                "gross_amount": req.body.nominal,
                "order_id": dataWakaf.jenis_wakaf + "-" + dataWakaf.id,
            },
            "customer_details": {
                "first_name": dataWakif.nama,
                "email": dataWakif.email,
                "phone": dataWakif.nomor_telepon,
            },
        })
        .then((response) => {
            const payment_code = response.actions[0].url;
            dataWakaf.kode_pembayaran = payment_code;
            updatePaymentCode(req, res);
        })
        .catch((error) => res.status(500).send({
            error: true,
            message: error.apiResponse,
        }));
    },
    handleNotification(req, res) {
        const data = req.body;
        coreApi
        .transaction
        .notification(data)
        .then((transaction) => {
            const transactionStatus = transaction.transaction_status;
            const transaksiWakaf = req.transaksi_wakaf;
            const playerIds = getPlayerIdList(transaksiWakaf['wakif']['data_one_signal']);
            let status;

            if (transactionStatus == 'capture'){
                if (fraudStatus == 'challenge'){
                    status = 'challenge';
                } else if (fraudStatus == 'accept'){
                    status = 'success';
                }
            } else if (transactionStatus == 'settlement'){
                status = 'success';
            } else if (transactionStatus == 'cancel' || transactionStatus == 'deny' || transactionStatus == 'expire'){
                status = 'failure';
            } else if (transactionStatus == 'pending'){
                status = 'pending';
            } else if (transactionStatus == 'refund'){
                status = 'refund';
            }

            updateStatus(transaksiWakaf, status);
            if ((status == 'success') && (playerIds.length > 0)) sendNotifications(transaksiWakaf, playerIds, status);
            res.send(`Transaction notification received. Order ID: ${transaction.order_id}. Transaction status: ${transactionStatus}. Fraud status: ${transaction.fraud_status}.`);
        })
        .catch((error) => res.status(500).send({
            error: true,
            message: error.message,
        }));
    },
    checkTransactionStatus(req, res) {
        coreApi
        .transaction
        .status(req.body.order_id)
        .then((transaction) => {
            const transactionStatus = transaction.transaction_status;
            const transaksiWakaf = req.transaksi_wakaf;
            const playerIds = getPlayerIdList(transaksiWakaf['wakif']['data_one_signal']);
            let status;

            if (transactionStatus == 'capture'){
                if (fraudStatus == 'challenge'){
                    status = 'challenge';
                } else if (fraudStatus == 'accept'){
                    status = 'success';
                }
            } else if (transactionStatus == 'settlement'){
                status = 'success';
            } else if (transactionStatus == 'cancel' || transactionStatus == 'deny' || transactionStatus == 'expire'){
                status = 'failure';
            } else if (transactionStatus == 'pending'){
                status = 'pending';
            } else if (transactionStatus == 'refund'){
                status = 'refund';
            }

            updateStatus(transaksiWakaf, status);
            if ((status == 'success') && (playerIds.length > 0)) sendNotifications(transaksiWakaf, playerIds, status);
            res.send(`Transaction notification received. Order ID: ${transaction.order_id}. Transaction status: ${transactionStatus}. Fraud status: ${transaction.fraud_status}.`);
        })
        .catch((error) => res.status(500).send({
            error: true,
            message: error.message,
        }));
    }
};