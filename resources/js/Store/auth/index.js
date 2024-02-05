import mutations from "./mutations"
import getters from "./getters";

export default {
    state(){
        return{
            token: null,
            user: null,
        }
    },
    mutations,
    getters,
}