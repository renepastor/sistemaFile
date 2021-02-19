<template>
</template>
<script type="text/javascript">
export default {
    methods:{

    },
    data(){
        return {
            loading:false
        }
    },
    async created(){
        await this.$auth.logout();
    }
}
</script>