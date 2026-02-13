const express = require('express')
const db = require('../db')
const router = express.Router()
const bc = require('bcrypt')
const {verifyToken , requireRole} = require('../middleware/authMiddleware')

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
router.get('/staff',verifyToken,requireRole('ฝ่ายบุคลากร'),async (req,res) => {
    try{
        const [[eva]] = await db.query(`select count(*)as total from tb_member where role='ผู้รับการประเมินผล'`)
        const [[commit]] = await db.query(`select count(*)as total from tb_member where role='กรรมการประเมิน'`)
        const [[staff]] = await db.query(`select count(*)as total from tb_member where role='ฝ่ายบุคลากร'`)
        const [[evaCount]] = await db.query(`select count(*) as total from tb_eva`)
        const [[y]] = await db.query(`select count(*) as total from tb_eva where status_eva=3`)
        const [[n]] = await db.query(`select count(*) as total from tb_eva where status_eva!=3`)
        res.json({
            box : [
                {title:'ผู้รับการประเมิน',value: eva.total || 0},
                {title:'คณะกรรมการประเมิน',value: commit.total || 0},
                {title:'เจ้าหน้าที่งานบุคลากร',value: staff.total || 0},
            ],
            box2 : [
                {title:'แบบประเมินทั้งหมด',value: evaCount.total || 0},
                {title:'แบบประเมินที่สำเร็จ',value: evaCount.total > 0 ? `${ (y.total*100/evaCount.total).toFixed(2) }%` : '00.00%'},
                {title:'แบบประเมินที่ไม่สำเร็จ',value: evaCount.total > 0 ? `${ (n.total*100/evaCount.total).toFixed(2) }%` : '00.00%'},
            ]
        })
        // res.json({rows,message:'Insert Success!'})
    }catch(err){
        console.error("Error Get",err)
        res.status(500).json({message:'Error Get'})
    }
})

// API สำหรับ Get ข้อมูล
router.get('/eva',verifyToken,requireRole('ผู้รับการประเมินผล'),async (req,res) => {
    try{
        const id_member = req.user.id_member
        const [[evaCount]] = await db.query(`select count(*)as total from tb_member,tb_eva where tb_member.id_member='${id_member}' and tb_eva.id_member=tb_member.id_member`)
        const [[y]] = await db.query(`select count(*)as total from tb_member,tb_eva where tb_member.id_member='${id_member}' and tb_eva.id_member=tb_member.id_member and status_eva!=1`)
        const [[n]] = await db.query(`select count(*)as total from tb_member,tb_eva where tb_member.id_member='${id_member}' and tb_eva.id_member=tb_member.id_member and status_eva=1`)
        res.json({
            box : [
                {title:'แบบประเมินทั้งหมด',value: evaCount.total || 0},
                {title:'แบบประเมินที่ประเมินแล้ว',value: evaCount.total > 0 ? `${ (y.total*100/evaCount.total).toFixed(2) }%` : '00.00%' },
                {title:'แบบประเมินที่ไม่ได้ประเมิน',value: evaCount.total > 0 ? `${ (n.total*100/evaCount.total).toFixed(2) }%` : '00.00%' },
            ]
        })
        // res.json({rows,message:'Insert Success!'})
    }catch(err){
        console.error("Error Get",err)
        res.status(500).json({message:'Error Get'})
    }
})

module.exports = router