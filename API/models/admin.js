'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Admin extends Model {
    static associate(models) {
      // define association here
    }
  };
  Admin.init({
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      autoIncrement: true,
      primaryKey: true,
    },
    nama: {
      type: DataTypes.STRING,
      allowNull : false,
    },
    email: {
      type: DataTypes.STRING,
      allowNull : false
    },
    password: {
      type: DataTypes.STRING,
      allowNull : false,
    },
    created_at: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    updated_at: {
      type: DataTypes.DATE,
      allowNull: false,
    }    
  }, 
  {
    sequelize,
    modelName: 'Admin',
    tableName: 'admin',
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    deletedAt: false,
    underscored: true,
  });
  return Admin;
};