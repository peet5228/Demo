require('dotenv').config()
const express = require('express')
const fileupload = require('express-fileupload')
const path = require('path')
const cors = require('cors')
const app = express()

app.use(cors ({
    origin: 'http://localhost:3000',
    credentials: true
}))

app.use(express.json())

app.use((req,res) => res.status(404).json({message:'404 : Invalid Route'}))
app.listen(3001 , () => console.log("Server Running On Port 3001"))