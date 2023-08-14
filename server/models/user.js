const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim:true,
        minlength:[2,"Name should be at least 3 characters long"],
        maxlength:[50,"Name cannot exceed more than 50 characters"],

    },
    email:{
        type:String,
        // unique:true,
        require: true,
        validate:{
            validator:(v) => {
                const re =/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return v.match(re);
            },
            message: "Please enter a valid email address"
        }
    },
    password:{
        required:true,
        type:String,
        validate:{
            validator:(v) => {
                return v.length > 6;
            },
            message: "Please enter a password with minimum legth of 6 characters."
        }
    },
    address: {
        type: String,
        default: "",
    },
    type:{
        type: String,
        default: 'user',
    },

});

const User = mongoose.model("User", userSchema);
module.exports = User;