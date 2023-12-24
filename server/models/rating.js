const mongoose = require("mongoose");
const ratingSchema = mongoose.Schema({
  userId: {
    type: String,
    required: true,
  },
  userName: {
    type: String,
    required: true,
  },
  rating: {
    type: Number,
    required: true,
  },
  review: {
    type: String,
    required: true,
  },
  reviewHeading: {
    type: String,
    required: true,
  },
  reviewTime: {
    type: String,
    required: true,
  },
});
module.exports = ratingSchema;
