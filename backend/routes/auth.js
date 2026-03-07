const express = require('express')
const db = require('../db')
const router = express.Router()
const bc = require('bcrypt')
const jwt = require('jsonwebtoken')
const JWT_SECRET = process.env.JWT_SECRET
const path = require('path')
const uploadDir = path.join(__dirname,'../uploads/pic_user')

// Login API
router.post('/login',async (req,res) => {
    try{
        const {username,password,role} = req.body
        const ip = req.ip
        const agent = req.headers['user-agent']
        const [rows] = await db.query(`select * from tb_member where username=? and role=?`,[username,role])
        const m = rows[0]
        if(!password || !(await bc.compare(password,m.password))){
            await db.query(`insert into tb_log (username,ip_address,status,user_agent) values (?,?,?,?)`,[username || 'unknown' ,ip,'failed',agent])
            return res.status(400).json({message:'Login Failed : Invalid Password'})
        }
        await db.query(
            `insert into tb_log (username, ip_address, status, user_agent) values (?, ?, ?, ?)`,
            [username, ip, 'success', agent]
        );
        const token = jwt.sign(
            {id_member:m.id_member,username:m.username,role:m.role} , JWT_SECRET , {expiresIn:'2h'}
        )
        res.json({token,role:m.role})
    }catch(err){
        console.error("Error Login",err)
        res.status(500).json({message:'Error Login'})
    }
})

// router.post('/login', async (req, res) => {
//     const { username, password, role } = req.body
//     const ip = req.ip, agent = req.headers['user-agent']
//     let status = 'failed' // ตั้งค่าเริ่มต้นเป็นล้มเหลว

//     try {
//         const [rows] = await db.query('SELECT * FROM tb_member WHERE username=? AND role=?', [username, role]);
//         const m = rows[0];

//         // เช็คความถูกต้อง (ถ้าผ่าน ให้เปลี่ยน status เป็น success)
//         if (m && await bc.compare(password, m.password)) {
//             status = 'success';
//             const token = jwt.sign({ id: m.id_member, username: m.username, role: m.role }, JWT_SECRET, { expiresIn: '2h' })
//             res.json({ token, role: m.role })
//         } else {
//             res.status(403).json({ message: 'Invalid Login' })
//         }
//     } catch (err) {
//         res.status(500).json({ message: 'Server Error' })
//     } finally {
//         // ไม่ว่า try หรือ catch จะทำงาน บรรทัดนี้จะบันทึก Log เสมอ
//         await db.query('INSERT INTO tb_log (username, ip_address, status, user_agent) VALUES (?, ?, ?, ?)', 
//         [username || 'unknown', ip, status, agent])
//     }
// });

// Register API
router.post('/regis',async (req,res) => {
    try{
        const pic_user = req.files?.pic_user
        const form = JSON.parse(req.body.form)
        const filename = Date.now() + path.extname(pic_user.name)
        await pic_user.mv(path.join(uploadDir,filename))
        const hash = await bc.hash(form.password,10)
        const [rows] = await db.query(`insert into tb_member (first_name,last_name,email,username,password,role,pic_user) values (?,?,?,?,?,?,?)`,[form.first_name,form.last_name,form.email,form.username,hash,form.role,filename])
        res.json({rows,message:'Resgister Success'})
    }catch(err){
        console.error("Error Regis",err)
        res.status(500).json({message:'Error Regis'})
    }
})

module.exports = router