'use strict';
const bcrypt = require('bcryptjs');

module.exports = {
  up: async (queryInterface, Sequelize) => {
   await queryInterface.bulkInsert('admin', [
     {
       nama: 'Admin',
       email: 'admin@gmail.com',
       password: bcrypt.hashSync('password'),
       created_at: new Date(),
       updated_at: new Date(),
     },
   ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('admin');
  }
};
