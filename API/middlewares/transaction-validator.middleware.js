const WakafAbadi = require('../models').WakafAbadi;
const WakafBerjangka = require('../models').WakafBerjangka;

function getStatusWakaf(code) {
    if (code === 'A') {
        return "abadi";
    } else if (code === 'B') {
        return "berjangka";
    }
}

module.exports = {
    async getTransaksiWakafData(req, res, next) {
        const data = req.body;
        const jenisWakaf = getStatusWakaf(data.order_id.charAt(0));
        const idTransaksi = data.order_id.substring(2);
        let transaksiWakaf;

        if (jenisWakaf === "abadi") {
            transaksiWakaf = await WakafAbadi.findOne({
                where: {
                    id: idTransaksi,
                },
                include: {
                    association: 'wakif',
                    include: {
                        association: 'data_one_signal',
                    }
                },
            });
        } else if (jenisWakaf === "berjangka") {
            transaksiWakaf = await WakafBerjangka.findOne({
                where: {
                    id: idTransaksi,
                },
                include: {
                    association: 'wakif',
                    include: {
                        association: 'data_one_signal',
                    }
                },
            });
        }

        req.transaksi_wakaf = transaksiWakaf;
        next();
    }
}