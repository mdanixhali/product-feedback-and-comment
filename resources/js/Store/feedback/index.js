import mutations from "./mutations"
import getters from "./getters";

export default {
    state(){
        return{
            feedback: null,
        }
    },
    mutations,
    getters,
}