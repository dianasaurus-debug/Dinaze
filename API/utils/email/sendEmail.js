const nodemailer = require("nodemailer");
const smtpTransport = require('nodemailer-smtp-transport')

const fs = require("fs");
const path = require("path");

const emailService = nodemailer.createTransport(smtpTransport({
    service: 'gmail',
    auth: {
        user: 'wakafbwi@gmail.com',
        pass: 'WAKAFBWI123'
    },
    tls: {
        rejectUnauthorized: false
    }
}));

module.exports = emailService;