const express = require("express");
const userRouter = express.Router();
const auth = require("../middleware/auth");
const { Product } = require("../models/product");
const User = require("../models/user");
const Order = require("../models/order");

userRouter.post("/user/add-to-cart", auth, async (req, res) => {
  try {
    const { id } = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      let isProductFound = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          isProductFound = true;
        }
      }
      if (isProductFound) {
        let product2 = user.cart.find((product2) =>
          product2.product._id.equals(product._id)
        );
        product2.quantity += 1;
      } else {
        user.cart.push({ product, quantity: 1 });
      }
    }

    user = await user.save();
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
userRouter.post("/api/save-user-address", auth, async (req, res) => {
  try {
    const { address } = req.body;
    let user = await User.findById(req.user);

    user.address = address;

    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
userRouter.post("/api/order", auth, async (req, res) => {
  try {
    const { cart, totalPrice, address } = req.body;
    let products = [];
    let outOfStockProducts = [];

    for (let index = 0; index < cart.length; index++) {
      let product = await Product.findById(cart[index].product._id);
      if (product.quantity >= cart[index].quantity) {
        product.quantity -= cart[index].quantity;
        product.unitsSold += cart[index].quantity;
        products.push({ product, quantity: cart[index].quantity });
        await product.save();
      } else {
        outOfStockProducts.push(product.name);
      }
    }

    if (outOfStockProducts.length > 0) {
      res
        .status(400)
        .json({ msg: `${outOfStockProducts.join(", ")} is/are out of stock!` });
    } else {
      let user = await User.findById(req.user);
      user.cart = [];
      user = await user.save();
      let order = new Order({
        products,
        totalPrice,
        address,
        status: 1,
        userId: req.user,
        orderedAt: new Date().getTime(),
      });
      order = await order.save();
      res.json(order);
    }
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.delete("/user/remove-from-cart/:id", auth, async (req, res) => {
  try {
    const { id } = req.params;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product._id.equals(product._id)) {
        if (user.cart[i].quantity == 1) {
          user.cart.splice(i, 1);
        } else {
          user.cart[i].quantity -= 1;
        }
        break;
      }
    }
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
userRouter.delete(
  "/user/remove-from-history/:prompt",
  auth,
  async (req, res) => {
    try {
      const { prompt } = req.params;
      let user = await User.findById(req.user);

      for (let i = 0; i < user.searchHistory.length; i++) {
        if (user.searchHistory[i] == prompt) {
          user.searchHistory.splice(i, 1);
          break;
        }
      }
      user = await user.save();
      res.json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

userRouter.get("/api/orders/me", auth, async (req, res) => {
  try {
    const orders = await Order.find({ userId: req.user });
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
userRouter.post("/user/update-wishlist", auth, async (req, res) => {
  try {
    const { userId, productId } = req.body;
    var user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    const wishlistIndex = user.wishlist.indexOf(productId);
    if (wishlistIndex === -1) {
      user.wishlist.push(productId);
    } else {
      user.wishlist.splice(wishlistIndex, 1);
    }
    user = await user.save();
    res.status(200).json({
      message: "Wishlist updated successfully",
      wishlist: user.wishlist,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = userRouter;
