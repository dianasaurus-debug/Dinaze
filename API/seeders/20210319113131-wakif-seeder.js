'use strict';
const bcrypt = require('bcryptjs');

module.exports = {
  up: async (queryInterface, Sequelize) => {
   await queryInterface.bulkInsert('wakif', [
     {
       nik: '320101070700004',
       nama: 'Praditya Nafiis Muhammad',
       email: 'pradityanafiis@gmail.com',
       password: bcrypt.hashSync('password', 8),
       nomor_ponsel: '82277771838',
       alamat: 'Bogor',
       created_at: new Date(),
       updated_at: new Date(),
     },
     {
      nama: 'Diana Fitri',
      email: 'diana@gmail.com',
      password: bcrypt.hashSync('password', 8),
      created_at: new Date(),
      updated_at: new Date(),
    },
    {
      nama: 'M. Udin Harun Al Rasyid',
      email: 'udinharun@pens.ac.id',
      password: bcrypt.hashSync('password', 8),
      created_at: new Date(),
      updated_at: new Date(),
    },
    {
      nama: 'Sritrusta Sukaridhoto',
      email: 'dhoto@pens.ac.id',
      password: bcrypt.hashSync('password', 8),
      created_at: new Date(),
      updated_at: new Date(),
    },
   ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('wakif');
  }
};
