'use strict';
const { v4:uuidv4 } = require('uuid');
let data = new Array();

module.exports = {
  up: async (queryInterface, Sequelize) => {
    for (let idWakif = 1; idWakif <= 4; idWakif++) {
      for (let idProgramWakaf = 1; idProgramWakaf <= 6; idProgramWakaf++) {
        for (let transaksi = 1; transaksi <= 25; transaksi++) {
          data.push({
            id: uuidv4(),
            program_wakaf_id: idProgramWakaf,
            wakif_id: idWakif,
            nominal: 1000000,
            nama_wakif: 'Nama Wakif' + idWakif + idProgramWakaf + transaksi,
            metode_pembayaran: 'bca',
            kode_pembayaran: '0123456789',
            status_pembayaran: 'success',
            nama_file_sertifikat: 'swu_example.pdf',
            nama_file_akta: 'aiw_example.pdf',
            created_at: new Date(),
            updated_at: new Date(),
          });          
        }    
      }  
    }
    await queryInterface.bulkInsert('wakaf_abadi', data);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('wakaf_abadi');
  }
};
