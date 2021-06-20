'use strict';
let data = new Array();

module.exports = {
  up: async (queryInterface, Sequelize) => {
    for (let programWakafId = 1; programWakafId <= 6; programWakafId++) {
      for (let laporan = 1; laporan <= 50; laporan++) {
        data.push({
          program_wakaf_id: programWakafId,
          deskripsi: 'Deskripsi' + programWakafId + laporan,
          created_at: new Date(),
          updated_at: new Date(),
        });
      }      
    }
    await queryInterface.bulkInsert('laporan', data);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('laporan');
  }
};
