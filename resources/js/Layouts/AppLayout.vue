<template>
    <Menu />
    <div>
        <router-view></router-view>
    </div>
</template>
<script>
import Menu from './Menu.vue';
export default {
    components:{
        Menu,
    },
    data(){
        return{

        }
    }
}
</script>
