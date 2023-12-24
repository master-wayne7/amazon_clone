const mongoose = require("mongoose");
const ratingSchema = require("./rating");

const productSchema = mongoose.Schema({
  name: { type: String, required: true, trim: true },
  sellerName: { type: String, required: true, trim: true },
  description: { type: String, required: true, trim: true },
  features: { type: String, required: true, trim: true },
  price: { type: Number, required: true },
  discountedPrice: { type: Number, required: true },
  category: { type: String, required: true },
  images: [{ type: String, required: true }],
  quantity: { type: Number, required: true },
  unitsSold: { type: Number, required: true },
  discount: { type: Number, required: true },
  ratings: [ratingSchema],
});

const Product = mongoose.model("Product", productSchema);
module.exports = { Product, productSchema };
