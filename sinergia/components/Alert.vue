<template>
    <div style="position: absolute; width: 24em;right: 0px; z-index:2000;">
        <v-alert v-for="row in alerts" :key="row.id" dense elevation="6" border="left" :type="row.type">
            <v-row align="center">
                <v-col class="alert">
                    {{row.mensaje}}
                </v-col>
                <v-col class="shrink">
                <v-btn elevation="2" :id="row.id" dark small icon @click="removeTodo(row)"><v-icon dark>mdi-window-close</v-icon></v-btn>
                </v-col>
            </v-row>
        </v-alert>
    </div>    
</template>
<script>
export default {
    props:{
        msj:{
            type:String,
            default:"..."
        },
        dismissible:{
            type:Boolean,
            default:true
        }

    },
    computed:{
        alerts() {
            return this.$store.state.alert.alert.sort(function(a, b) {
            var textA = a.id;
            var textB = b.id;
            return (textA > textB) ? -1 : ((textA < textB) ? 1 : 0);
        });
        }
    },
    methods:{
        removeTodo (todo){
            this.$store.commit('alert/remove', todo)
        }
    }
}
</script>