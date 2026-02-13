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
router.get('/:id_eva',verifyToken,requireRole('ฝ่ายบุคลากร'),async (req,res) => {
    try{
        const {id_eva} = req.params
        const [rows] = await db.query(`select * from tb_eva, tb_member , tb_commit where tb_commit.id_eva='${id_eva}' and tb_commit.id_eva=tb_eva.id_eva and tb_commit.id_member=tb_member.id_member`)
        res.json(rows)
        // res.json({rows,message:'Insert Success!'})
    }catch(err){
        console.error("Error Get",err)
        res.status(500).json({message:'Error Get'})
    }
})

module.exports = router