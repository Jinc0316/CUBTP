// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue';
import App from './App';
import router from './router';
import store from './store';//引入store

//引入element-ui
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
//引入第三方icon
import './assets/icon/css/font-awesome.min.css';
Vue.use(ElementUI);


//使用axios获取后台数据
import axios from 'axios';
Vue.prototype.$axios = axios;
axios.defaults.baseURL = 'http://localhost:8080/cubtp';
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
axios.defaults.crossDomain = true;
axios.defaults.withCredentials = true; // 允许携带cookie信息

import { setCookie, getCookie, delCookie } from './utils/util';
Vue.prototype.$cookieStore = {
	setCookie,
	getCookie,
	delCookie
};

// console.log(axios.defaults.headers);

Vue.config.productionTip = false;

/* eslint-disable no-new */
new Vue({
	el: '#app',
    router,
    store,
	components: { App },
	template: '<App/>'
});
