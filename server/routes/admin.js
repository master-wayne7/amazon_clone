const express = require("express");
const adminRouter = express.Router();
const admin = require("../middleware/admin");
const { Product } = require("../models/product");
const Order = require("../models/order");

adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const {
      name,
      description,
      images,
      quantity,
      price,
      category,
      sellerName,
      discount,
      features,
    } = req.body;
    var discountedPrice = price - price * (discount / 100);
    let product = Product({
      name,
      description,
      images,
      price,
      category,
      quantity,
      sellerName,
      unitsSold: 0,
      discount,
      discountedPrice,
      features,
    });

    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
adminRouter.post("/admin/update-status", admin, async (req, res) => {
  try {
    const { id, status } = req.body;
    let order = await Order.findById(id);
    order.status = status;
    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/admin/get-products", admin, async (req, res) => {
  try {
    const products = await Product.find({});
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
adminRouter.get("/admin/get-orders", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    res.json(orders);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
adminRouter.get("/admin/analytics", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    let totalEarnings = 0;
    for (let i = 0; i < orders.length; i++) {
      totalEarnings += orders[i].totalPrice;
    }
    const categoryTotalPrices = {
      Mobiles: 0,
      Books: 0,
      Essentials: 0,
      Fashion: 0,
      Appliances: 0,
    };
    orders.forEach((order) => {
      order.products.forEach((product) => {
        const category = product.product.category;
        const price = product.product.price * product.quantity;
        categoryTotalPrices[category] += price;
      });
    });
    let earning = {
      totalEarnings,
      ...categoryTotalPrices,
    };
    res.json(earning);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
adminRouter.post("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);
    res.json("All went good");
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = adminRouter;
