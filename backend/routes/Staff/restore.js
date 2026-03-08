const express = require('express');
const router = express.Router();
const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');

router.post('/', (req, res) => {
    // 1. ตรวจสอบว่ามีการส่งไฟล์มาหรือไม่
    if (!req.files || Object.keys(req.files).length === 0) {
        return res.status(400).json({ message: 'กรุณาอัปโหลดไฟล์ .sql' });
    }

    // 'backupFile' คือชื่อตัวแปรที่ Frontend จะส่งมา
    const sqlFile = req.files.backupFile; 
    const uploadPath = path.join(__dirname, '../../uploads/', sqlFile.name);

    // 2. บันทึกไฟล์ลงในโฟลเดอร์ uploads ชั่วคราว
    sqlFile.mv(uploadPath, (err) => {
        if (err) {
            console.error("Upload error:", err);
            return res.status(500).json({ message: 'อัปโหลดไฟล์ไม่สำเร็จ' });
        }

        // 3. ตั้งค่า Database ให้ตรงกับระบบ
        const host = process.env.DB_HOST || 'mysql';
        const user = process.env.DB_USER || 'root';
        const password = process.env.DB_PASSWORD || '1234';
        const database = process.env.DB_DATABASE || 'NTC';

        // 4. สร้างคำสั่งนำเข้าข้อมูล (ใช้ mysql แทน mysqldump และใช้เครื่องหมาย < แทน >)
        const command = `mysql -h ${host} -u ${user} -p${password} ${database} < ${uploadPath}`;

        // 5. สั่งรันคำสั่งเพื่อ Restore
        exec(command, (error, stdout, stderr) => {
            // รันเสร็จแล้ว ลบไฟล์ชั่วคราวทิ้งทันทีเพื่อไม่ให้รก Server
            if (fs.existsSync(uploadPath)) {
                fs.unlinkSync(uploadPath);
            }

            if (error) {
                console.error(`Restore error: ${error}`);
                return res.status(500).json({ message: 'กู้คืนฐานข้อมูลล้มเหลว' });
            }

            res.status(200).json({ message: 'กู้คืนฐานข้อมูลสำเร็จ!' });
        });
    });
});

module.exports = router;