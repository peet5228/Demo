<template>
    v-conrt
</template>

<script setup lang="ts">
import axios from 'axios'
import {eva} from '../../API/base'

const user = ref<any>({})
const topics = ref<any>([])

const fetchUser = async () =>{
    const token = localStorage.getItem('token')
    try{
        const res = await axios.get(`${eva}/selfeva/user`,{headers:{Authorization:`Bearer ${token}`}})
        user.value = res.data
    }catch(err){
        console.error('Error Get Profile!',err)
    }
}
const fetchTopics = async () =>{
    const token = localStorage.getItem('token')
    try{
        const res = await axios.get(`${eva}/selfeva/topic`,{headers:{Authorization:`Bearer ${token}`}})
        topics.value = res.data
    }catch(err){
        console.error('Error Get Profile!',err)
    }
}
onMounted(async () =>{
    await Promise.all([fetchUser(),fetchTopics()])
})
</script>

<style scoped>

</style>