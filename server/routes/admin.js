const express = require("express");
const adminRouter = express.Router();
const admin = require('../middleware/admin');
const {Product} = require("../models/product");

adminRouter.post('/admin/add-product',admin,async(req,res) => {
    try {
        const {name,description,images,quantity,price,category} = req.body;
        let product  = Product({
            name,
            description,
            images,
            price,
            category,
            quantity,
        });

        product = await product.save();
        res.json(product);
    } catch (error) {
        res.status(500).json({error:e.message});
    }
})

adminRouter.get('/admin/get-products',admin,async (req,res)=>{
    try {
        const products = await Product.find({});
        res.json(products);
    } catch (error) {
        res.status(500).json({error:e.message});
    }
});
adminRouter.post('/admin/delete-product',admin,async (req,res)=>{
    try {
        const {id} = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json("All went good");
    } catch (error) {
        res.status(500).json({error:e.message});
    }
});

module.exports = adminRouter;