const express = require('express')
const db = require('../../db')
const router = express.Router()
const bc = require('bcrypt')
const {verifyToken , requireRole} = require('../../middleware/authMiddleware')

// ========= DEMO ====
// API สำหรับ Get ข้อมูล
// router.get(`/`,verifyToken,requireRole('ฝ่ายบุคลากร'),async (req,res) => {
//     try{
//         const [rows] = await db.query(``)
//         res.json(row)
//         // res.json({row,message:'Insert Success!'})
//     }catch(err){
//         console.error("Error Get",err)
//         res.status(500).json({message:'Error Get'})
//     }
// })
// =============== DEMO =====

// API สำหรับ Get ข้อมูล
router.get(`/eva`,verifyToken,requireRole('ฝ่ายบุคลากร'),async (req,res) => {
    try{
        const [rows] = await db.query(`select id_member,first_name,last_name,email,username,role from tb_member where role='ผู้รับการประเมินผล' order by id_member desc`)
        res.json(row)
        // res.json({row,message:'Insert Success!'})
    }catch(err){
        console.error("Error Get",err)
        res.status(500).json({message:'Error Get'})
    }
})

module.exports = router