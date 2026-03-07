const express = require('express')
const db = require('../../db')
const router = express.Router()
const {requireRole,verifyToken} = require('../../middleware/authMiddleware')
const bc = require('bcrypt')
const fs = require('fs')
const path = require('path')
const uploadDir = path.join(__dirname,'../../uploads/pic_user')
// Register API
router.get('/',verifyToken,requireRole('ผู้รับการประเมินผล'),async (req,res) => {
    try{
        const id_member = req.user.id_member
        const [rows] = await db.query(`select first_name,last_name,email,username,role,pic_user from tb_member where id_member=?`,[id_member])
        res.json(rows[0])
    }catch(err){
        console.error("Error GET Profile",err)
        res.status(500).json({message:'Error GET Profile'})
    }
})

router.put('/',verifyToken,requireRole('ผู้รับการประเมินผล'),async (req,res) => {
    try{
        const id_member = req.user.id_member
        const pic_user = req.files?.pic_user
        const form = JSON.parse(req.body.form)
        //การส่งรูปใหม่มามั้ย
        if(pic_user){
            //ถ้ามีให้ลบรูปเก่าออกและเพิ่มรูปใหม่เข้าไป
            if(form.pic_user){
                const del = path.join(uploadDir,form.pic_user)
                if(fs.existsSync(del)){
                    fs.unlinkSync(del)
                }
            }
            const filename = Date.now() + path.extname(pic_user.name)
            await pic_user.mv(path.join(uploadDir,filename))
            await db.query(`update tb_member set pic_user=? where id_member='${id_member}'`,
                [filename])
        }
        if(form.password && form.password.trim()){
            const hash = await bc.hash(form.password,10)
            await db.query(`update tb_member set first_name=?,last_name=?,email=?,username=?,password=?,role=? where id_member='${id_member}'`,
                [form.first_name,form.last_name,form.email,form.username,hash,form.role])
        }else{
            await db.query(`update tb_member set first_name=?,last_name=?,email=?,username=?,role=? where id_member='${id_member}'`,
                [form.first_name,form.last_name,form.email,form.username,form.role])
        }
        res.json({message:'Update Success!'})
    }catch(err){
        console.error("Error Update",err)
        res.status(500).json({message:'Error Update'})
    }
})

module.exports = router