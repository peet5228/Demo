<template>
    <v-container fluid class="py-10">
                <v-card>
                    <v-sheet class="pa-4 text-center" color="">
                        <h1 class="text-h5 font-weight-bold">ประวัติการจัดการข้อมูล(จัดการสมาชิก)</h1>
                        <!-- <p class="text-error">** เฉพาะการแก้ไขข้อมูลในส่วนของ ผู้รับการประเมินและกรรมการประเมิน **</p> -->
                    </v-sheet>
                    <v-card-text>
                        <v-table>
                            <thead>
                                <tr>
                                    <th class="text-center border">ลำดับ</th>
                                    <th class="text-center border">ผู้แก้ไข</th>
                                    <th class="text-center border">ผู้ถูกแก้ไข</th>
                                    <th class="text-center border">รายละเอียด</th>
                                    <th class="text-center border">วันที่แก้ไข</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(items,index) in result" :key="items.id_his">
                                    <td class="text-center border">{{ index + 1 }}</td>
                                    <td class="text-center border">{{ nameOf(items.id_edit) }}</td>
                                    <td class="text-center border">{{ memberOf(items.id_member) }}</td>
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
const resultMember = ref ([])

const fetch = async () => {
    try{
        const res = await axios.get(`${staff}/his`,{headers:{Authorization:`Bearer ${token}`}})
        result.value = res.data
        const resMember = await axios.get(`${staff}/his/member`,{headers:{Authorization:`Bearer ${token}`}})
        resultMember.value = resMember.data
    }catch(err){
        console.error("Error Fetching",err)
    }
}

const nameMap = computed( () => Object.fromEntries(result.value.map(p => [p.id_edit,p.fullname])) )
const nameOf = (id_edit:number) => nameMap.value[id_edit]
const memberMap = computed(() => {
    if (!resultMember.value.length) return {}
    return Object.fromEntries(
        resultMember.value.map(p => [p.id_member, p.fullnameMember])
    )
})

const memberOf = (id_member: number | string) => {
    // ถ้าหาชื่อไม่เจอใน Map ให้แสดงเป็น 'ไม่ระบุ' หรือ 'กำลังโหลด...'
    return memberMap.value[id_member] || 'ไม่พบข้อมูลผู้ถูกแก้ไข'
}

const Member_His = () => {
    navigateTo({path: '/Staff/Member_His'})
}

onMounted(fetch)
</script>

<style scoped>

</style>