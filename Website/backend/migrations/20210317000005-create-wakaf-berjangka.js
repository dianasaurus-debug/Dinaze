'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('wakaf_berjangka', {
      id: {
        type: Sequelize.UUID,
        allowNull: false,
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
      wakif_id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: 'wakif',
          key: 'id',
        },
      },
      nominal: {
        type: Sequelize.INTEGER,
        allowNull: false,
      },
      nama_wakif: {
        type: Sequelize.STRING,
        allowNull: false,
      },
      metode_pembayaran: {
        type: Sequelize.STRING,
        allowNull: false,
      },
      kode_pembayaran: {
        type: Sequelize.TEXT,
        allowNull: true,
      },
      status_pembayaran: {
        type: Sequelize.ENUM('challenge', 'success', 'failure', 'pending', 'refund'),
        allowNull: false,
        defaultValue: 'pending',
      },
      jangka_waktu: {
        type: Sequelize.INTEGER,
        allowNull: false,
      },
      jatuh_tempo: {
        type: Sequelize.DATEONLY,
        allowNull: true,
      },
      nama_bank: {
        type: Sequelize.STRING,
        allowNull: false,
      },
      nomor_rekening: {
        type: Sequelize.TEXT,
        allowNull: false,
      },
      nama_pemilik_rekening: {
        type: Sequelize.STRING,
        allowNull: false,
      },
      status_pengembalian: {
        type: Sequelize.ENUM('pending', 'finish'),
        allowNull: false,
        defaultValue: 'pending',
      },
      nama_file_sertifikat: {
        type: Sequelize.STRING,
        allowNull: true,
      },
      nama_file_akta: {
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
    await queryInterface.dropTable('wakaf_berjangka');
  }
};
