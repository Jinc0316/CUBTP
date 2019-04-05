import Vue from 'vue';
import Router from 'vue-router';
// import HelloWorld from '@/components/HelloWorld'
import LoginAndRegister from '@/components/LoginAndRegister.vue';
import Login from '@/components/LoginAndRegister/Login.vue';
import Register from '@/components/LoginAndRegister/Register.vue';
import Home from '@/components/Home.vue';
import BookInfo from '@/components/BookInfo.vue';
import UserInfo from '@/components/UserInfo.vue';
import BookUpload from '@/components/BookUpload.vue';

Vue.use(Router);

const router =  new Router({
	routes: [
        {
			path: '/',
			name: '/',
			redirect: '/home'
        },
        {
			path: '/home',
			name: 'Home',
			component: Home
        },
        {
			path: '/bookInfo',
			name: 'BookInfo',
			component: BookInfo
        },
        {
			path: '/userInfo',
			name: 'UserInfo',
			component: UserInfo
        },
        {
			path: '/bookUpload',
			name: 'BookUpload',
			component: BookUpload
		},
		// {
		// 	path: '/',
		// 	name: 'LoginAndRegister1',
		// 	redirect: '/LoginAndRegister/login'
		// },
		{
			path: '/LoginAndRegister',
			name: 'LoginAndRegister',
            component: LoginAndRegister,
            children: [
                {
                    path:'login',
                    name: 'Login',
                    component: Login
                },
                {
                    path:'register',
                    name: 'Register',
                    component: Register
                }
            ]
        }
        
    ],
    linkActiveClass:'active'
});

// router.beforeEach((to, from, next) => {
//     localStorage.setItem('userinfo',{name:'Login'});


//     //用你的方式获取登录的用户信息
//     const userinfo = localStorage.userinfo
//     if(userInfo || to.name === 'Login'){
//         //如果存在用户信息，或者进入的页面是登录页面，则直接进入
//         next({
//             name: 'Home',
//             query: {
//               redirect: to.path
//             }
//           })
//     }else {
//         //不存在用户信息则说明用户未登录，跳转到登录页面，带上当前的页面地址，登录完成后做回跳，
//         //如未登录用户进入用户中心的页面地址，检测到未登录，
//         //自动跳转到登录页面，并且带上用户中心的页面地址，登录完成后重新跳到个人中心页面。
//         next({
//           name: 'Login',
//           query: {
//             redirect: to.path
//           }
//         })
//     }
// })
export default router