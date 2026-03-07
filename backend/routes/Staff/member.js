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
        res.json(rows)
        // res.json({row,message:'Insert Success!'})
    }catch(err){
        console.error("Error Get",err)
        res.status(500).json({message:'Error Get'})
    }
})

// API สำหรับ Get ข้อมูล
router.get(`/commit`,verifyToken,requireRole('ฝ่ายบุคลากร'),async (req,res) => {
    try{
        const [rows] = await db.query(`select id_member,first_name,last_name,email,username,role from tb_member where role='กรรมการประเมิน' order by id_member desc`)
        res.json(rows)
        // res.json({row,message:'Insert Success!'})
    }catch(err){
        console.error("Error Get",err)
        res.status(500).json({message:'Error Get'})
    }
})

// API สำหรับ Get ข้อมูล
router.get(`/all`,verifyToken,requireRole('ฝ่ายบุคลากร'),async (req,res) => {
    try{
        const [rows] = await db.query(`select id_member,first_name,last_name,email,username,role from tb_member order by id_member desc`)
        res.json(rows)
        // res.json({row,message:'Insert Success!'})
    }catch(err){
        console.error("Error Get",err)
        res.status(500).json({message:'Error Get'})
    }
})

// API สำหรับ Get ข้อมูล where Params
router.get(`/:id_member`,verifyToken,requireRole('ฝ่ายบุคลากร'),async (req,res) => {
    try{
        const {id_member} = req.params
        const [rows] = await db.query(`select id_member,first_name,last_name,email,username,role from tb_member where id_member='${id_member}' order by id_member desc`)
        if(rows.length === 0) return res.status(403).json({message:'Invalid Param'})
        res.json(rows)
        // res.json({row,message:'Insert Success!'})
    }catch(err){
        console.error("Error Get",err)
        res.status(500).json({message:'Error Get'})
    }
})

// API สำหรับ Update ข้อมูล
router.put('/:id_member',verifyToken,requireRole('ฝ่ายบุคลากร'),async (req,res) => {
    try{
        const id_admin = req.user.id_member
        const {id_member} = req.params
        const {first_name,last_name,email,username,password,role} = req.body
        if(password && password.trim()){
            const hash = await bc.hash(password,10)
            await db.query(`update tb_member set first_name=?,last_name=?,email=?,username=?,password=?,role=? where id_member='${id_member}'`,[first_name,last_name,email,username,hash,role])
        }else{
            await db.query(`update tb_member set first_name=?,last_name=?,email=?,username=?,role=? where id_member='${id_member}'`,[first_name,last_name,email,username,role])
        }
        await db.query(`insert into tb_his (id_edit,id_member,detail,date) values (?,?,?,CURDATE())`,[id_admin,id_member,'edit'])
        // res.json(rows)
        res.json({message:'Update Success!'})
    }catch(err){
        console.error("Error Update",err)
        res.status(500).json({message:'Error Update'})
    }
})

// API สำหรับ Delete ข้อมูล
router.delete(`/:id_member`,verifyToken,requireRole('ฝ่ายบุคลากร'),async (req,res) => {
    try{
        const id_admin = req.user.id_member
        const {id_member} = req.params
        const [rows] = await db.query(`delete from tb_member where id_member='${id_member}'`)
        await db.query(`insert into tb_his (id_edit,id_member,detail,date) values (?,?,?,CURDATE())`,[id_admin,id_member,'Delete'])
        // res.json(row)
        res.json({rows,message:'Delete Success!'})
    }catch(err){
        console.error("Error Delete",err)
        res.status(500).json({message:'Error Delete'})
    }
})

module.exports = router