const express = require("express");
const userRouter = express.Router();
const auth = require('../middleware/auth');
const {Product} = require("../models/product");
const User = require("../models/user");

userRouter.post('/user/add-to-cart',auth,async(req,res) => {
    try {
        const {id}= req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        if (user.cart.length == 0) {
            user.cart.push({product, quantity:1});
        }else{
            let isProductFound=false;
            for (let i=0;i<user.cart.length;i++){
                if (user.cart[i].product._id.equals(product._id)){
                    isProductFound = true;
                }
            }
            if (isProductFound) {
                let product2 = user.cart.find((product2) => product2.product._id.equals(product._id));
                product2.quantity+=1;
            }
            else{
                user.cart.push({product, quantity:1})
            }   
        }

        user = await user.save();
        res.json(user);
    } catch (error) {
        res.status(500).json({error:e.message});
    }
})
userRouter.delete('/user/remove-from-cart/:id',auth,async(req,res) => {
    try {
        const {id}= req.params;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

       
            for (let i=0;i<user.cart.length;i++){
                if (user.cart[i].product._id.equals(product._id)){
                    if (user.cart[i].quantity ==1) {
                        user.cart.splice(i,1);
                    }else{
                        user.cart[i].quantity -=1;
                    }
                    break;
                }
            }
        user = await user.save();
        res.json(user);
    } catch (error) {
        res.status(500).json({error:e.message});
    }
})

module.exports = userRouter;