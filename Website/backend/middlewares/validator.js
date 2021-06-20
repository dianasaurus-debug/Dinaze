const { body, validationResult } = require('express-validator');

exports.validateUserRegistration = [
    body('email').isEmail(),
    body('nama').isString(),
    // body('nomor_ktp').isNumeric(),
    // body('nomor_ktp').isLength({min: 16, max: 16}),
    // body('nomor_telepon').isMobilePhone('id-ID'),
    // body('alamat').isAlphanumeric(),
    //body('password').isStrongPassword,
    (req, res, next) => {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).send({
                error: true,
                message: errors
            });
        } else {
            next();
        }
    }
]

exports.validateWaqfProgram = []

exports.validateUpdateProfile = [
    body('email').isEmail(),
    body('nama').isString(),
    body('nik').isNumeric(),
    body('nik').isLength({min: 16, max: 16}),
    body('nomor_ponsel').isMobilePhone('id-ID'),
    body('alamat').isString()
]
