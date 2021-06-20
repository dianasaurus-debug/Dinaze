const User = require('../models').Wakif;

const {
    sequelize
} = require('sequelize');
module.exports = {
    adminBoard(req, res){
        res.status(200).send("Admin Content.");
    },
    displayAllUser(req, res) {
        User.findAll({
            include: [
                'data_wakaf_abadi',
                'data_wakaf_berjangka',
            ],
        })
            .then(data => {
                res.send(data);
            })
            .catch(err => {
                res.status(500).send({
                    message:
                        err.message || "Some error occurred while retrieving programs."
                });
            });
    },


}
