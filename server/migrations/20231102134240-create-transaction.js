"use strict";
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable("transactions", {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },
      userId: {
        type: Sequelize.INTEGER,
      },
      cartId: {
        type: Sequelize.STRING,
      },
      courierId: {
        type: Sequelize.INTEGER,
      },
      orderId: {
        type: Sequelize.STRING,
      },
      midtranstoken: {
        type: Sequelize.STRING,
      },
      status: {
        type: Sequelize.ENUM("pending", "reject", "approve"),
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE,
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE,
      },
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable("transactions");
  },
};
