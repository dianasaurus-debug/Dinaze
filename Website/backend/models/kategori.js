'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Kategori extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      Kategori.hasMany(models.ProgramWakaf, {
        foreignKey: 'kategori_id',
        as: 'daftar_program_wakaf',
      });      
    }
  };
  Kategori.init({
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      autoIncrement: true,
      primaryKey: true,
    },
    nama: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
    },
    deskripsi: {
      type: DataTypes.TEXT,
      allowNull: false,        
    },
    gambar: {
      type: DataTypes.TEXT,
      allowNull: false
    },
    ikon_flutter: {
      type: DataTypes.TEXT,
      allowNull: true
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
    modelName: 'Kategori',
    tableName: 'kategori',
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    deletedAt: false,
    underscored: true,
  });
  return Kategori;
};