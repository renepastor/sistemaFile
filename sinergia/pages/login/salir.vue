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
        const REDIRECT_URI =  this.$route.query.redirect || process.env.URL_DEFAULT;
        this.$router.push(REDIRECT_URI)
    }
}
</script>