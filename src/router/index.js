import Vue from 'vue';
import Router from 'vue-router';
//引入element-ui
import { Message } from 'element-ui';


// import HelloWorld from '@/components/HelloWorld'
import LoginAndRegister from '@/components/LoginAndRegister.vue';
import Login from '@/components/LoginAndRegister/Login.vue';
import Register from '@/components/LoginAndRegister/Register.vue';
import Home from '@/components/Home.vue';
import Index from "@/components/subComponents/index.vue"
import BookInfo from '@/components/subComponents/BookInfo.vue';
import UserInfo from '@/components/subComponents/UserInfo.vue';
import BookUpload from '@/components/subComponents/BookUpload.vue';
import ConfirmOrder from '@/components/subComponents/ConfirmOrder.vue';
import MyStore from '@/components/subComponents/MyStore.vue';
import OrderCenter from '@/components/subComponents/OrderCenter.vue';

import BoughtBooks from '@/components/OrderCenterComponents/BoughtBooks.vue'
import SoldBooks from '@/components/OrderCenterComponents/SoldBooks.vue'

import AdminCenter from '@/components/subComponents/AdminCenter.vue';

import BookManage from '@/components/AdminSubComponents/BookManage.vue';
import UserManage from '@/components/AdminSubComponents/UserManage.vue';

import NotCheckedBook from '../components/AdminSubComponents/NotCheckedBook.vue';
import CheckedBook from '../components/AdminSubComponents/CheckedBook.vue';

import { setCookie, getCookie, delCookie } from '../utils/util';

Vue.use(Router);

const router = new Router({
	routes: [
		{
			path: '/',
			name: '/',
			redirect: '/home/index'
		},
		{
			path: '/home',
			name: 'Home',
            component: Home,
            children:[
                {
                    path: 'index',
                    name: 'Index',
                    component: Index
                },
                {
                    path: 'bookInfo',
                    name: 'BookInfo',
                    component: BookInfo
                },
                {
                    path: 'userInfo',
                    name: 'UserInfo',
                    component: UserInfo
                },
                {
                    path: 'bookUpload',
                    name: 'BookUpload',
                    component: BookUpload
                },
                {
                    path: 'confirmOrder',
                    name: 'ConfirmOrder',
                    component: ConfirmOrder
                },
                {
                    path: 'myStore',
                    name: 'MyStore',
                    component: MyStore
                },
                {
                    path: 'orderCenter',
                    name: 'OrderCenter',
                    redirect: '/home/orderCenter/boughtBooks',
                    component: OrderCenter,
                    children:[
                        {
                            path: 'boughtBooks',
                            name: 'BoughtBooks',
                            component: BoughtBooks
                        },
                        {
                            path: 'soldBooks',
                            name: 'SoldBooks',
                            component: SoldBooks
                        }
                    ]
                },
                {
                    path: 'adminCenter',
                    name: 'AdminCenter',
                    redirect: '/adminCenter/bookManage',
                    component: AdminCenter,
                    children:[
                        {
                            path: 'bookManage',
                            name: 'BookManage',
                            redirect: '/home/adminCenter/bookManage/notCheckedBook',
                            component: BookManage,
                            children:[
                                {
                                    path: 'notCheckedBook',
                                    name: 'NotCheckedBook',
                                    component: NotCheckedBook
                                },
                                {
                                    path: 'checkedBook',
                                    name: 'CheckedBook',
                                    component: CheckedBook
                                }

                            ]
                        },
                        {
                            path: 'userManage',
                            name: 'UserManage',
                            component: UserManage
                        }
                    ]
                }
                
            ]
		},
		
		{
			path: '/LoginAndRegister',
			name: 'LoginAndRegister',
			component: LoginAndRegister,
			children: [
				{
					path: 'login',
					name: 'Login',
					component: Login
				},
				{
					path: 'register',
					name: 'Register',
					component: Register
				}
			]
		}
	],
	linkActiveClass: 'active'
});

router.beforeEach((to, from, next) => {
	//用你的方式获取登录的用户信息
	let value = getCookie('userId');
	let flag = false;
	if (value) {
		flag = true;
	}

	if (to.name === 'BookUpload'|| to.name === 'OrderCenter'|| to.name === 'ConfirmOrder') {
		//进行登录验证
		if (flag) {
			next();
		} else {
            // alert("请登录！");
            Message({
                message: "请登录",
                type: "warning",
                center: true
            });
            // $message('这是一条消息提示');
            //不然就跳转到登录；
			next({
				name: 'Login',
				query: { redirect: to.path }
			});
		}
	} else {
		// 不需要登录的放行
        next();
	}
});
export default router;
