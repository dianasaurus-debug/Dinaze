'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('wakif', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
      },
      googleId : {
        type : Sequelize.STRING,
        allowNull : true,
        unique : true
      },
      nik: {
        type: Sequelize.STRING(16),
        allowNull: true,
        unique: true,
      },
      nama: {
        type: Sequelize.STRING,
        allowNull: false,
      },
      email: {
        type: Sequelize.STRING,
        allowNull: false,
        unique: true,
      },
      password: {
        type: Sequelize.TEXT,
        allowNull: false,
      },
      nomor_ponsel: {
        type: Sequelize.STRING(14),
        allowNull: true,
        unique: true,
      },
      alamat: {
        type: Sequelize.TEXT,
        allowNull: true,
      },
      foto: {
        type: Sequelize.TEXT,
        allowNull: true
      },
      created_at: {
        type: Sequelize.DATE,
        allowNull: false
      },
      updated_at: {
        type: Sequelize.DATE,
        allowNull: false
      },
    });
  },
  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('wakif');
  }
};
