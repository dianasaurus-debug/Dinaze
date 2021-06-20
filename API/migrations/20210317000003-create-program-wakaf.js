'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('program_wakaf', {
      id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
      },
      kategori_id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: 'kategori',
          key: 'id',
        },
      },
      judul: {
        type: Sequelize.STRING,
        allowNull: false,
        unique: true,
      },
      deskripsi: {
        type: Sequelize.TEXT,
        allowNull: false,
      },
      gambar: {
        type: Sequelize.STRING,
        allowNull: false,
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
    await queryInterface.sequelize.query('CREATE FUNCTION `wakaf_abadi_terkumpul` (`id` int(11)) RETURNS int(11) RETURN (SELECT COALESCE(SUM(`nominal`), 0) FROM `wakaf_abadi` WHERE `program_wakaf_id` = `id` AND `status_pembayaran` = "success");');
    await queryInterface.sequelize.query('CREATE FUNCTION `wakaf_berjangka_terkumpul` (`id` int(11)) RETURNS int(11) RETURN (SELECT COALESCE(SUM(`nominal`), 0) FROM `wakaf_berjangka` WHERE `program_wakaf_id` = `id` AND `status_pembayaran` = "success");');
  },
  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('program_wakaf');
    await queryInterface.sequelize.query('DROP FUNCTION `wakaf_abadi_terkumpul`');
    await queryInterface.sequelize.query('DROP FUNCTION `wakaf_berjangka_terkumpul`');
  }
};