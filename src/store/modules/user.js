const state = {
	//要设置的全局访问的state对象
	userInfo: {
		userId: '',
		userPwd: '',
		userTel: '',
        userEmail: '',
        userHeadImg: "default_headImage.jpg",
        userRole: 0
	}
	//要设置的初始属性值
};

const getters = {
	//实时监听state值的变化(最新状态)
	getUserInfo(state) {
        state.userInfo = JSON.parse(sessionStorage.getItem('userInfo'));
        // console.log(state.userInfo+"--------");
        
		return state.userInfo;
	}
};

const mutations = {
	setUserInfo(state, userInfo) {
        //同上，这里面的参数除了state之外还传了需要增加的值sum
        sessionStorage.setItem("userInfo", JSON.stringify(userInfo)); 
		state.userInfo = userInfo;
	}
};

const actions = {
	setUser({ commit }, userInfo) {
		commit('setUserInfo', userInfo);
	}
};

export default {
    namespaced:true,//用于在全局引用此文件里的方法时标识这一个的文件名
    state,
    getters,
    mutations,
    actions
}