'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class OneSignal extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      OneSignal.belongsTo(models.Wakif, {
        foreignKey: 'wakif_id',
        targetKey: 'id',
        as: 'wakif',
      })
    }
  };
  OneSignal.init({
    wakif_id: DataTypes.INTEGER,
    player_id: DataTypes.TEXT
  }, {
    sequelize,
    modelName: 'OneSignal',
    tableName: 'one_signal',
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    deletedAt: false,
    underscored: true,
  });
  return OneSignal;
};