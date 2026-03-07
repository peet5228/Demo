const express = require('express')
const db = require('../../db')
const router = express.Router()
const bc = require('bcrypt')
const {verifyToken , requireRole} = require('../../middleware/authMiddleware')

// ========= DEMO ====
// API สำหรับ Get ข้อมูล
// router.get('/',verifyToken,requireRole('ฝ่ายบุคลากร'),async (req,res) => {
//     try{
//         const [rows] = await db.query(``)
//         res.json(rows)
//         // res.json({rows,message:'Insert Success!'})
//     }catch(err){
//         console.error("Error Get",err)
//         res.status(500).json({message:'Error Get'})
//     }
// })
// =============== DEMO =====

// API สำหรับ Get ข้อมูล
router.get('/',verifyToken,requireRole('ฝ่ายบุคลากร'),async (req,res) => {
    try{
        const id_admin = req.user.id_member
        const [rows] = await db.query(`select id_edit,tb_his.id_member,detail,date,concat(first_name,' ',last_name)as fullname from tb_his,tb_member where tb_member.id_member=tb_his.id_edit order by id_his desc`)
        res.json(rows)
        // res.json({rows,message:'Insert Success!'})
    }catch(err){
        console.error("Error Get",err)
        res.status(500).json({message:'Error Get'})
    }
})

// API สำหรับ Get ข้อมูล
router.get('/member',verifyToken,requireRole('ฝ่ายบุคลากร'),async (req,res) => {
    try{
        const id_admin = req.user.id_member
        const [rows] = await db.query(`select tb_his.id_member,concat(first_name,' ',last_name)as fullnameMember from tb_his,tb_member where tb_member.id_member=tb_his.id_member order by id_his desc`)
        res.json(rows)
        // res.json({rows,message:'Insert Success!'})
    }catch(err){
        console.error("Error Get",err)
        res.status(500).json({message:'Error Get'})
    }
})

module.exports = router