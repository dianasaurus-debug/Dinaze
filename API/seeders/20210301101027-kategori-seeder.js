'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('kategori', [
      {
        nama: 'Pendidikan',
        deskripsi: 'Deskripsi program wakaf pendidikan',
        gambar: 'pendidikan.png',
        ikon_flutter: 'FontAwesomeIcons.graduationCap',
        created_at: new Date(),
        updated_at: new Date(),
      },
      {
        nama: 'Kesehatan',
        deskripsi: 'Deskripsi program wakaf kesehatan',
        gambar: 'kesehatan.png',
        ikon_flutter: 'FontAwesomeIcons.hospital',
        created_at: new Date(),
        updated_at: new Date(),
      },
      {
        nama: 'Tempat Ibadah',
        deskripsi: 'Deskripsi program wakaf tempat ibadah',
        gambar: 'tempat-ibadah.png',
        ikon_flutter: 'FontAwesomeIcons.mosque',
        created_at: new Date(),
        updated_at: new Date(),
      },
      {
        nama: 'Umum',
        deskripsi: 'Deskripsi program wakaf umum',
        gambar: 'umum.png',
        ikon_flutter: 'FontAwesomeIcons.handsHelping',
        created_at: new Date(),
        updated_at: new Date(),
      },
      {
        nama: 'Bencana',
        deskripsi: 'Deskripsi program wakaf donasi bencana',
        gambar: 'donasi-bencana.png',
        ikon_flutter: 'FontAwesomeIcons.houseDamage',
        created_at: new Date(),
        updated_at: new Date(),
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('kategori');
  }
};
