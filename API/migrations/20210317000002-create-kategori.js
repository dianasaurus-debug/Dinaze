'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('kategori', {
      id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
      },
      nama: {
        type: Sequelize.STRING,
        allowNull: false,
        unique: true,
      },
      deskripsi: {
        type: Sequelize.TEXT,
        allowNull: false,        
      },
      gambar: {
        type: Sequelize.TEXT,
        allowNull: false
      },
      ikon_flutter: {
        type: Sequelize.TEXT,
        allowNull: true
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
    await queryInterface.dropTable('kategori');
  }
};