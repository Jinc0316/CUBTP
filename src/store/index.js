import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);

import user from './modules/user';
import order from './modules/order';
import book from './modules/book'

const store = new Vuex.Store({
	modules:{
        user,
        order,
        book
    }
});
export default store;
