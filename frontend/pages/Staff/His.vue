<template>
    <v-container fluid class="py-10">
                <v-card>
                    <v-sheet class="pa-4 text-center" color="">
                        <h1 class="text-h5 font-weight-bold">ประวัติการจัดการข้อมูล </h1>
                        <p class="text-error">** เฉพาะการแก้ไขข้อมูลในส่วนของ ผู้รับการประเมินและกรรมการประเมิน **</p>
                    </v-sheet>
                    <v-card-text>
                        <v-table>
                            <thead>
                                <tr>
                                    <th class="text-center border">ลำดับ</th>
                                    <th class="text-center border">รายชื่อที่แก้ไข</th>
                                    <th class="text-center border">รายละเอียด</th>
                                    <th class="text-center border">วันที่แก้ไข</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(items,index) in result" :key="items.id_his">
                                    <td class="text-center border">{{ index+1 }}</td>
                                    <td class="text-center border">{{ items.first_name }} {{ items.last_name }}</td>
                                    <td class="text-center border">{{ items.detail }}</td>
                                    <td class="text-center border">{{ items.date }}</td>
                                </tr>
                                <tr v-if="result.length === 0">
                                    <td class="text-center border" colspan="10">ไม่พบข้อมูล</td>
                                </tr>
                            </tbody>
                        </v-table>
                    </v-card-text>
                </v-card>
   </v-container>
</template>

<script setup lang="ts">
import axios from 'axios'
import {api,staff} from '../../API/base'

const token = process.client ? localStorage.getItem('token') : null

const result = ref ([])

const fetch = async () => {
    try{
        const res = await axios.get(`${staff}/his`,{headers:{Authorization:`Bearer ${token}`}})
        result.value = res.data
    }catch(err){
        console.error("Error Fetching",err)
    }
}

onMounted(fetch)
</script>

<style scoped>

</style>