const express = require("express");
const productRouter = express.Router();
const auth = require("../middleware/auth");
const { Product } = require("../models/product");
const User = require("../models/user");

// Get all products by the category
productRouter.get("/api/products", auth, async (req, res) => {
  try {
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get a product by its id
productRouter.get("/api/get-product", auth, async (req, res) => {
  try {
    const product = await Product.findById(req.query.id);
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get multiple products by an array of ids
productRouter.post("/api/get-products", auth, async (req, res) => {
  try {
    const { productIds } = req.body;
    const products = await Product.find({ _id: { $in: productIds } });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get product through search
// if submit true then add to the search history of the user
productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  try {
    var isSubmitted = req.query.submit;
    const products = await Product.find({
      name: { $regex: req.params.name, $options: "i" },
    });
    if (isSubmitted == "true") {
      var user = await User.findById(req.user);
      const maxSearchHistoryLength = 4;
      const existingIndex = user.searchHistory.findIndex(
        (query) => query.toLowerCase() === req.params.name.toLowerCase()
      );
      if (existingIndex !== -1) {
        user.searchHistory.unshift(
          user.searchHistory.splice(existingIndex, 1)[0]
        );
      } else {
        user.searchHistory.unshift(req.params.name);
      }
      user.searchHistory = user.searchHistory.slice(0, maxSearchHistoryLength);
      await user.save();
    }
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// rate a product with its id
productRouter.post("/api/rate-product", auth, async (req, res) => {
  try {
    const { id, rating, userName, review, reviewHeading } = req.body;
    let products = await Product.findById(id);

    for (let index = 0; index < products.ratings.length; index++) {
      const element = products.ratings[index];
      if (element.user == req.userId) {
        products.ratings.splice(index, 1);
        break;
      }
    }
    const ratingSchema = {
      userId: req.user,
      rating,
      review,
      reviewHeading,
      userName,
      reviewTime: new Date().getTime(),
    };
    products.ratings.push(ratingSchema);
    products = await products.save();
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get the deal of the day based on avg rating
productRouter.get("/api/deal-of-the-day", auth, async (req, res) => {
  try {
    let products = await Product.find({});
    products = products.sort((a, b) => {
      let aSum = Object.values(a.ratings).reduce((acc, curr) => acc + curr, 0);
      let bSum = Object.values(b.ratings).reduce((acc, curr) => acc + curr, 0);
      return bSum - aSum; // Sorting in descending order based on ratings sum
    });

    res.json(products[0]);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
