'use strict';
const { v4:uuidv4 } = require('uuid');
let data = new Array();

function getJatuhTempo(jangkaWaktu) {
  const jatuhTempo = new Date();
  jatuhTempo.setFullYear(jatuhTempo.getFullYear() + jangkaWaktu);
  return jatuhTempo;
}

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
            jangka_waktu: idWakif,
            jatuh_tempo: getJatuhTempo(idWakif),
            metode_pembayaran: 'bca',
            kode_pembayaran: '0123456789',
            status_pembayaran: 'success',
            nama_bank: 'Bank Mandiri',
            nomor_rekening: '9000021957544',
            nama_pemilik_rekening: 'Nama Pemilik Rekening' + idWakif + idProgramWakaf + transaksi,
            nama_file_sertifikat: 'swu_example.pdf',
            nama_file_akta: 'aiw_example.pdf',
            created_at: new Date(),
            updated_at: new Date(),
          });          
        }       
      }  
    }
    await queryInterface.bulkInsert('wakaf_berjangka', data);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('wakaf_abadi');
  }
};
