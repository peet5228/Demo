<template>
    <v-container fluid class="py-10">
        <v-card>
            <v-sheet class="pa-4 text-center" color="">
                <h1 class="text-h5 font-weight-bold">Dashboard - Staff</h1>
            </v-sheet>
            <v-card-text>
                <v-row>
                    <v-col cols="12" md="4" v-for="b in box" :key="b">
                        <v-card elevation="3" class="pa-4" rounded="lg">
                            <div class="text-h5 text-center">{{ b.title }}</div>
                            <div class="text-h5 text-center">{{ b.value }} &nbsp;คน</div>
                        </v-card>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12" md="4" v-for="b in box2" :key="b">
                        <v-card elevation="3" class="pa-4" rounded="lg">
                            <div class="text-h5 text-center">{{ b.title }}</div>
                            <div class="text-h5 text-center">{{ b.value }} &nbsp;</div>
                        </v-card>
                    </v-col>
                </v-row>
            </v-card-text>
            <br><br><br>
            <p class="text-center text-h5 font-weight-bold">ประวัติการเข้าสู่ระบบ</p>
            <br>
            <v-table class="pa-4">
                <thead>
                    <tr>
                        <th class="border text-center">ลำดับ</th>
                        <th class="border text-center">ชื้อผู้ใช้</th>
                        <th class="border text-center">IP Address</th>
                        <th class="border text-center">สถานะ</th>
                        <th class="border text-center">User Agent</th>
                        <th class="border text-center">วันที่</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(items,index) in result_ip" :key="items.id_log">
                        <td class="text-center border">{{ index+1 }}</td>
                        <td class="text-center border">{{ items.username }}</td>
                        <td class="text-center border">{{ items.ip_address }}</td>
                        <td class="text-center border">{{ items.status }}</td>
                        <td class="text-center border">{{ items.user_agent }}</td>
                        <td class="text-center border">{{ items.access_date }}</td>
                    </tr>
                </tbody>
            </v-table>
            
            <v-divider class="my-6"></v-divider>
            <p class="text-center text-h6 font-weight-bold">จัดการฐานข้อมูล</p>
            
            <div class="text-center py-4">
                <v-btn color="primary" size="large" elevation="3" @click="downloadBackup">
                    ดาวน์โหลดไฟล์ Database
                </v-btn>
            </div>

            <v-row justify="center" class="pb-6">
                <v-col cols="12" md="6">
                    <v-file-input
                        v-model="selectedFile"
                        label="เลือกไฟล์ .sql เพื่อกู้คืนข้อมูล"
                        accept=".sql"
                        variant="outlined"
                        density="compact"
                    ></v-file-input>
                    <div class="text-center mt-2">
                        <v-btn 
                            color="warning" 
                            size="large" 
                            elevation="3" 
                            @click="restoreDatabase"
                            :loading="isRestoring"
                        >
                            กู้คืนข้อมูล (Restore)
                        </v-btn>
                    </div>
                </v-col>
            </v-row>

        </v-card>
    </v-container>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue' // เพิ่ม import ref, onMounted เพื่อความชัวร์
import axios from 'axios'
import { api, staff } from '../../API/base'

const token = process.client ? localStorage.getItem('token') : null

const box = ref([])
const box2 = ref([])
const result_ip = ref([])

// ตัวแปรสำหรับ Restore
const selectedFile = ref(null)
const isRestoring = ref(false)

const fetch = async () => {
    try {
        const res = await axios.get(`${api}/dash/staff`, { headers: { Authorization: `Bearer ${token}` } })
        box.value = res.data.box
        box2.value = res.data.box2
    } catch (err) {
        console.error("Error Fetching", err)
    }
}

const fetch2 = async () => {
    try {
        const res2 = await axios.get(`${api}/dash/ip`, { headers: { Authorization: `Bearer ${token}` } })
        result_ip.value = res2.data
    } catch (err) {
        console.error("Error Fetching Log", err)
    }
}

const downloadBackup = () => {
    window.open(`${api}/Staff/backup`, '_blank')
}

// ฟังก์ชันสำหรับ Restore
const restoreDatabase = async () => {
    if (!selectedFile.value) {
        alert("กรุณาเลือกไฟล์ .sql ก่อนครับ")
        return
    }

    // จัดการกรณี v-model คืนค่ามาเป็น Array
    const file = Array.isArray(selectedFile.value) ? selectedFile.value[0] : selectedFile.value

    if (!confirm("คำเตือน: ข้อมูลปัจจุบันจะถูกแทนที่ด้วยไฟล์นี้ คุณแน่ใจหรือไม่?")) {
        return
    }

    const formData = new FormData()
    formData.append('backupFile', file)

    isRestoring.value = true
    try {
        const res = await axios.post(`${api}/Staff/restore`, formData, {
            headers: {
                'Content-Type': 'multipart/form-data',
                Authorization: `Bearer ${token}`
            }
        })
        alert(res.data.message || "กู้คืนข้อมูลสำเร็จ!")
        selectedFile.value = null // ล้างค่าไฟล์ที่เลือก
        
        // โหลดข้อมูลใหม่หลังจาก Restore เสร็จ
        fetch()
        fetch2()
    } catch (err) {
        console.error("Restore error:", err)
        alert("เกิดข้อผิดพลาดในการกู้คืนข้อมูล")
    } finally {
        isRestoring.value = false
    }
}

onMounted(() => {
    fetch()
    fetch2()
})

</script>

<style scoped>

</style>