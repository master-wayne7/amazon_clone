//Import from packages
const express = require("express");
const mongoose = require("mongoose");

//Import from files
const authRouter = require("./routes/auth");

// Initializations
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://ronitrameja:amazonclone@cluster0.mfhykti.mongodb.net/?retryWrites=true&w=majority"

// middleware
app.use(express.json());
app.use(authRouter);

// Connections
mongoose
  .connect(DB)
  .then(()=>{
    console.log("Connection Successful");
  })
  .catch((e)=>{
    console.log(e);
  });

app.listen(PORT, "192.168.0.111", ()=>{
    console.log(`Server running on port ${PORT}`);
});