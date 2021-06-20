'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
   await queryInterface.bulkInsert('program_wakaf', [
     {
       kategori_id: 4,
       judul: 'Gerakan Nasional Wakaf Uang (GNWU)',
       deskripsi: 'Gerakan nasional untuk menghimpun wakaf uang untuk kesejahteraan bangsa Indonesia di bidang kesehatan, pendidikan, dan ekonomi kemasyarakatan.',
       gambar: 'gerakan-nasional-wakaf-uang.webp',
       created_at: new Date(),
       updated_at: new Date(),
     },
     {
       kategori_id: 4,
       judul: 'ASN Kemenag Berwakaf',
       deskripsi: 'Program wakaf aparatur sipil negara (ASN) Kementerian Agama Republik Indonesia dengan penyaluran manfaat untuk pemberian beasiswa pendidikan dan aktivasi pemanfaatan aset wakaf produktif.',
       gambar: 'asn-kemenag-berwakaf.webp',
       created_at: new Date(),
       updated_at: new Date(),
     },
     {
       kategori_id: 1,
       judul: 'Beasiswa 1.000 Bidan dan Dokter Muslimah Spesialis Kandungan',
       deskripsi: 'Program beasiswa bidan dan dokter muslimah spesialis kandungan, agar kebutuhan dokter spesialis kebidanan dan kandungan perempuan terpenuhi dengan baik.',
       gambar: 'beasiswa-1.000-bidan-dan-dokter-muslimah-spesialis-kandungan.webp',
       created_at: new Date(),
       updated_at: new Date(),
     },
     {
       kategori_id: 2,
       judul: 'Pembangunan Klinik dan Rumah Sakit Mata',
       deskripsi: 'Dengan wakaf kita bangun klinik dan rumah sakit mata di seluruh Indonesia untuk menyelamatkan masyarakat Indonesia dari tsunami katarak dan kebutaan mata.',
       gambar: 'pembangunan-klinik-dan-rumah-sakit-mata.webp',
       created_at: new Date(),
       updated_at: new Date(),
     },
     {
       kategori_id: 1,
       judul: 'Kalisa - Institut Pertanian Bogor',
       deskripsi: 'Program penghimpunan dan distribusi Kalisa Untuk dana bantuan SPP mahasiswa IPB yang terdampak pandemi Covid-19.',
       gambar: 'kalisa-institut-pertanian-bogor.webp',
       created_at: new Date(),
       updated_at: new Date(),
     },
     {
       kategori_id: 2,
       judul: 'Pembangunan Retina Centre',
       deskripsi: 'Pembangunan retina center Rumah Sakit Mata Achmad Wardi di Kota Serang (Provinsi Banten).',
       gambar: 'pembangunan-retina-centre.webp',
       created_at: new Date(),
       updated_at: new Date(),
     }
   ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('program_wakaf');
  }
};
