const express = require('express');
const router = express.Router();
const { spawn } = require('child_process');

router.get('/', (req, res) => {
    // 1. บอกเบราว์เซอร์ให้ดาวน์โหลดไฟล์
    const fileName = `NTC_Backup_${Date.now()}.sql`;
    res.setHeader('Content-Disposition', `attachment; filename=${fileName}`);
    res.setHeader('Content-Type', 'application/sql');

    // 2. ตั้งค่าให้ตรงกับที่คุณตั้งไว้ใน db.js
    const host = 'mysql';
    const user = 'root';
    const password = '1234';
    const database = 'NTC';

    // 3. รัน mysqldump ยิงข้อมูลตรงเข้าเบราว์เซอร์
    const dumpProcess = spawn('mysqldump', ['-h', host, '-u', user, `-p${password}`, database]);
    
    dumpProcess.stdout.pipe(res); 

    dumpProcess.stderr.on('data', (data) => {
        console.error(`mysqldump error: ${data}`);
    });
});

module.exports = router;