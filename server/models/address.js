const mongoose = require("mongoose");
const addressSchema = mongoose.Schema({
  houseNo: {
    type: Number,
    required: true,
  },
  street: {
    type: String,
    required: true,
  },
  locality: {
    type: String,
    required: true,
  },
  city: {
    type: String,
    required: true,
  },
  state: {
    type: String,
    required: true,
  },
  pincode: {
    type: Number,
    required: true,
    validate: {
      validator: (v) => {
        return v.length != 6;
      },
      message: "Please enter a correct Pincode of 6 digits",
    },
  },
});
module.exports = addressSchema;
