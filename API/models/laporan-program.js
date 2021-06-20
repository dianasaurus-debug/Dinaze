'use strict';
const moment = require('moment-timezone');
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Laporan extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      Laporan.belongsTo(models.ProgramWakaf, {
        foreignKey: 'program_wakaf_id',
        targetKey: 'id',
        as: 'program_wakaf',
      });
    }
  };
  Laporan.init({
    deskripsi: DataTypes.TEXT,
    program_wakaf_id: DataTypes.INTEGER,
    gambar: DataTypes.STRING,
    created_at: DataTypes.DATE,
    updated_at: DataTypes.DATE,
    tanggal: {
      type: DataTypes.VIRTUAL,
      get() {
        return moment(this.getDataValue('created_at')).locale('id').tz('Asia/Jakarta').format('dddd, LL');
      },
      set(value) {
        throw new Error('Do not try to set the value!');
      }
    },
    waktu: {
      type: DataTypes.VIRTUAL,
      get() {
        return moment(this.getDataValue('created_at')).locale('id').tz('Asia/Jakarta').format('HH:mm');
      },
      set(value) {
        throw new Error('Do not try to set the value!');
      }
    },
  }, {
    sequelize,
    tableName: 'laporan',
    modelName: 'Laporan',
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    deletedAt: false,
    underscored: true,
  });
  return Laporan;
};
