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
                </v-card>
   </v-container>
</template>

<script setup lang="ts">
import axios from 'axios'
import {api,staff} from '../../API/base'

const token = process.client ? localStorage.getItem('token') : null

const box = ref ([])
const box2 = ref ([])
const result_ip = ref ([])

const fetch = async () => {
    try{
        const res = await axios.get(`${api}/dash/staff`,{headers:{Authorization:`Bearer ${token}`}})
        box.value = res.data.box
        box2.value = res.data.box2
    }catch(err){
        console.error("Error Fetching",err)
    }
}

const fetch2 = async () => {
    try{
        const res2 = await axios.get(`${api}/dash/ip`,{headers:{Authorization:`Bearer ${token}`}})
        result_ip.value = res2.data
    }catch(err){
        console.error("Error Fetching Log",err)
    }
}

onMounted(() => {
    fetch(),
    fetch2()
})

</script>

<style scoped>

</style>