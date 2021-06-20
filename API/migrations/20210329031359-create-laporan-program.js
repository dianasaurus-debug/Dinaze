'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('laporan', {
      id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
      },
      program_wakaf_id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: 'program_wakaf',
          key: 'id',
        },
      },
      deskripsi: {
        type: Sequelize.STRING,
        allowNull: false,
      },
      gambar: {
        type: Sequelize.STRING,
        allowNull: true,
      },
      created_at: {
        type: Sequelize.DATE,
        allowNull: false,
      },
      updated_at: {
        type: Sequelize.DATE,
        allowNull: false,
      }
    });
  },
  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('laporan');
  }
};
