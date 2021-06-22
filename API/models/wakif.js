'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Wakif extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      Wakif.hasMany(models.OneSignal, {
        foreignKey: 'wakif_id',
        sourceKey: 'id',
        as: 'data_one_signal',
      });
      Wakif.hasMany(models.WakafAbadi, {
        foreignKey: 'wakif_id',
        sourceKey: 'id',
        as: 'data_wakaf_abadi',
      });
      Wakif.hasMany(models.WakafBerjangka, {
        foreignKey: 'wakif_id',
        sourceKey: 'id',
        as: 'data_wakaf_berjangka',
      });
    }
  };

  Wakif.init({
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    google_id : {
      type : DataTypes.STRING,
      allowNull : true,
      unique : true
    },
    nik: {
      type: DataTypes.STRING(16),
      allowNull: true,
      unique: true,
    },
    nama: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    email: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
    },
    password: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    nomor_ponsel: {
      type: DataTypes.STRING(14),
      allowNull: true,
      unique: true,
    },
    alamat: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    foto: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    created_at: {
      type: DataTypes.DATE,
      allowNull: false
    },
    updated_at: {
      type: DataTypes.DATE,
      allowNull: false
    },
  }, {
    sequelize,
    modelName: 'Wakif',
    tableName: 'wakif',
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    deletedAt: false,
    underscored: true,
  });
  return Wakif;
};
