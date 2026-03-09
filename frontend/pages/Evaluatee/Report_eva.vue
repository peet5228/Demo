<template>
    <v-container>
        <v-row>
            <v-col cols="12">
                <v-form v-if="user.status_eva === 3">
                    
                    <div ref="pdfContent" class="pdf-container pa-4 bg-white">
                        <h1 class="text-h5 font-weight-bold text-center">รายงานผลการประเมิน</h1>
                        <v-card class="pa-2 mt-2" elevation="0" border>
                            <p>ชื่อ - นามสกุล : {{ user.first_name }} {{ user.last_name }}</p>
                            <p>รอบประเมินที่ : {{ user.round_sys }} ปี {{ user.year_sys }}</p>
                        </v-card>
                        
                        <v-row class="mt-2" v-for="(topic,t) in topics" :key="topic.id_topic">
                            <v-col cols="12">
                                <h1 class="text-h6">{{ t+1 }}.{{ topic.name_topic }}</h1>
                                <v-table class="table">
                                    <thead>
                                        <tr>
                                            <th class="bg-grey border pa-1" style="width: 10%;">ตัวชี้วัด</th>
                                            <th class="bg-grey border pa-1" style="width: 10%;">รายละเอียดตัวชี้วัด</th>
                                            <th class="bg-grey border pa-1" style="width: 10%;">น้ำหนักคะแนน</th>
                                            <th class="bg-grey border pa-1" style="width: 10%;">คะแนนเต็ม</th>
                                            <th class="bg-grey border pa-1" style="width: 10%;">คะแนนที่ได้</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="indicate in topic.indicates" :key="indicate.id_indicate">
                                            <td class="border pa-1 text-center">{{ indicate.name_indicate }}</td>
                                            <td class="border pa-1 text-center">{{ indicate.detail_indicate }}</td>
                                            <td class="border pa-1 text-center">{{ indicate.point_indicate }}</td>
                                            <td class="border pa-1 text-center">{{ indicate.point_indicate*4 }}</td>
                                            <td class="border pa-1 text-center">
                                                {{ (((scores[indicate.id_indicate]?.a ?? 0)+(scores[indicate.id_indicate]?.b ?? 0)+(scores[indicate.id_indicate]?.c ?? 0))/3).toFixed(2) }}
                                            </td>
                                        </tr>
                                    </tbody>
                                </v-table>
                            </v-col>
                        </v-row>
                        
                        <div class="mt-4">
                            <v-card color="success" class="pa-2 text-end" elevation="0">
                                คะแนนนรวมสุทธิ : {{ ((user.total_commit)/3).toFixed(2) }} คะแนน
                            </v-card>
                        </div>
                        
                        <div class="mt-4">
                            <v-card class="pa-2" elevation="0" border>
                                <v-row>
                                    <v-col cols="4" class="text-center" v-for="commit in commits" :key="commit.id_commit">
                                        <img :src="`http://localhost:3001/uploads/signature/${commit.signature}`" :alt="`รอ${commit.level_commit}ประเมิน`" width="20%"> <br>
                                        ( {{ commit.first_name }} {{ commit.last_name }} ) <br>
                                        {{ commit.level_commit }}
                                    </v-col>
                                </v-row>
                            </v-card>
                        </div>
                    </div>
                    <div class="text-center mt-4 d-flex justify-center gap-4">
                        <v-btn color="secondary" class="mr-2" @click="printDoc">พิมพ์ (Print)</v-btn>
                        <v-btn color="error" @click="exportPDF">ดาวน์โหลด PDF</v-btn>
                    </div>

                </v-form>

                <v-alert type="info" v-else-if="user.status_eva === 2">รอกรรมดำเนินการประเมิน</v-alert>
                <v-alert type="info" v-else-if="user.status_eva === 1">ยังไม่ได้ประเมิน</v-alert>
                <v-alert type="warning" v-else>ยังไม่มีแบบประเมิน</v-alert>
            </v-col>
        </v-row>
    </v-container>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import axios from 'axios'
import html2pdf from 'html2pdf.js' // นำเข้าไลบรารี
import { eva } from '../../API/base'

const user = ref<any>({})
const topics = ref<any>([])
const scores = ref<any>([])
const commits = ref<any>([])

// อ้างอิง DOM element ที่จะปริ้นเป็น PDF
const pdfContent = ref<HTMLElement | null>(null)

// ฟังก์ชันสำหรับพิมพ์ปกติ
const printDoc = () => {
    window.print()
}

// ฟังก์ชันสำหรับดาวน์โหลด PDF ด้วย html2pdf
const exportPDF = () => {
    if (!pdfContent.value) return;

    // ตั้งค่า option สำหรับ pdf
    const opt = {
        margin:       10, // ขอบหน้ากระดาษ
        filename:     `รายงานผลประเมิน_${user.value.first_name || 'user'}.pdf`,
        image:        { type: 'jpeg', quality: 0.98 },
        html2canvas:  { 
            scale: 2, // เพิ่มความคมชัด
            useCORS: true // **สำคัญมาก** เพื่อให้ดึงรูปภาพลายเซ็นข้ามโดเมนมาวาดได้
        },
        jsPDF:        { unit: 'mm', format: 'a4', orientation: 'portrait' }
    };

    // สั่งสร้าง PDF
    html2pdf().set(opt).from(pdfContent.value).save();
}

const fetchUser = async () =>{
    const token = localStorage.getItem('token')
    try{
        const res = await axios.get(`${eva}/score_commit/user`,{headers:{Authorization:`Bearer ${token}`}})
        user.value = res.data
    }catch(err){
        console.error('Error Get Profile!',err)
    }
}
const fetchTopics = async () =>{
    const token = localStorage.getItem('token')
    try{
        const res = await axios.get(`${eva}/score_commit/topic`,{headers:{Authorization:`Bearer ${token}`}})
        topics.value = res.data
    }catch(err){
        console.error('Error Get Profile!',err)
    }
}
const fetchScores = async () =>{
    const token = localStorage.getItem('token')
    try{
        const res = await axios.get(`${eva}/score_commit/scores`,{headers:{Authorization:`Bearer ${token}`}})
        scores.value = res.data.scores
    }catch(err){
        console.error('Error Get Profile!',err)
    }
}
const fetchCommits = async () =>{
    const token = localStorage.getItem('token')
    try{
        const res = await axios.get(`${eva}/score_commit/commits`,{headers:{Authorization:`Bearer ${token}`}})
        commits.value = res.data
    }catch(err){
        console.error('Error Get Profile!',err)
    }
}

onMounted(async () =>{
    await Promise.all([fetchUser(),fetchTopics(),fetchScores(),fetchCommits()])
})
</script>

<style scoped>
/* เผื่อเอาไว้สำหรับฟังก์ชันพิมพ์ (Print) แบบเดิม */
@media print{
    .v-app-bar, .v-btn {
        display: none !important;
    }
}

/* บังคับพื้นหลังสีขาวตอนวาดเป็น PDF จะได้ไม่โปร่งใส */
.pdf-container {
    background-color: white;
}
</style>