'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class ProgramWakaf extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      ProgramWakaf.belongsTo(models.Kategori, {
        foreignKey: 'kategori_id',
        targetKey: 'id',
        as: 'kategori',
      });
      ProgramWakaf.hasMany(models.WakafAbadi, {
        foreignKey: 'program_wakaf_id',
        sourceKey: 'id',
        as: 'data_wakaf_abadi',
      });
      ProgramWakaf.hasMany(models.WakafBerjangka, {
        foreignKey: 'program_wakaf_id',
        sourceKey: 'id',
        as: 'data_wakaf_berjangka',
      });
      ProgramWakaf.hasMany(models.Laporan, {
        foreignKey: 'program_wakaf_id',
        sourceKey: 'id',
        as: 'data_laporan',
      });
    }
  };
  ProgramWakaf.init({
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true,
    },
    kategori_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'kategori',
        key: 'id',
      },
    },
    judul: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
    },
    deskripsi: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    gambar: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    created_at: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    updated_at: {
      type: DataTypes.DATE,
      allowNull: false,
    }
  }, {
    sequelize,
    modelName: 'ProgramWakaf',
    tableName: 'program_wakaf',
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    deletedAt: false,
    underscored: true,
  });
  return ProgramWakaf;
};
