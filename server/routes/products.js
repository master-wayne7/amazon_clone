const express = require("express");
const productRouter = express.Router();
const auth = require("../middleware/auth")
const {Product} = require("../models/product");


productRouter.get('/api/products',auth,async (req,res)=>{
    try {
        const products = await Product.find({category:req.query.category});
        res.json(products);
    } catch (error) {
        res.status(500).json({error:e.message});
    }
});

productRouter.get('/api/products/search/:name',auth,async (req,res)=>{
    try {
        const products = await Product.find({name:{$regex: req.params.name, $options:"i"}});
        res.json(products);
    } catch (error) {
        res.status(500).json({error:e.message});
    }
});
productRouter.post('/api/rate-product',auth,async (req,res)=>{
    try {
        const {id,rating} = req.body;
        let products = await Product.findById(id);

        for (let index = 0; index < products.ratings.length; index++) {
            const element = products.ratings[index];
            if(element.user == req.userId){
                products.ratings.splice(index,1);
                break;
            }   
        }
        const ratingSchema = {
            userId:req.user,
            rating
        };
        products.ratings.push(ratingSchema);
        products = await products.save();
        res.json(products);
    } catch (error) {
        res.status(500).json({error:e.message});
    }
});
productRouter.get('/api/deal-of-the-day',auth,async (req,res)=>{
    try {

        let products = await Product.find({});
        products = products.sort((a,b)=>{
            let aSum = 0;
            let bSum = 0;
            for (const key in a.ratings) {
                aSum += key.rating;
            }
            for (const key in b.ratings) {
                bSum += key.rating;
            }
            return aSum<bSum?1:-1;
        });

        res.json(products[0]);
    } catch (error) {
        res.status(500).json({error:e.message});
    }
});


module.exports = productRouter;