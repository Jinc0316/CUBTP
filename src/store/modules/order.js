const state = {
	//要设置的全局访问的state对象
	bookInfo: {},
	buyNum: 1
};

const getters = {
	//实时监听state值的变化(最新状态)
	getBookInfo(state) {
		state.bookInfo = JSON.parse(sessionStorage.getItem('bookInfo'));
		return state.bookInfo;
	},
	getBuyNum(state) {
		state.buyNum = JSON.parse(sessionStorage.getItem('buyNum'));
		// console.log(state.userInfo+"--------");
		return state.buyNum;
	}
};

const mutations = {
	setBookInfo(state, bookInfo) {
		//同上，这里面的参数除了state之外还传了需要增加的值sum
		sessionStorage.setItem('bookInfo', JSON.stringify(bookInfo));
		state.bookInfo = bookInfo;
	},
	setBuyNum(state, buyNum) {
		//同上，这里面的参数除了state之外还传了需要增加的值sum
		sessionStorage.setItem('buyNum', JSON.stringify(buyNum));
		state.buyNum = buyNum;
	}
};

const actions = {
	setBookInfo({ commit }, bookInfo) {
		commit('setBookInfo', bookInfo);
	},
	setBuyNum({ commit }, buyNum) {
		commit('setBuyNum', buyNum);
	}
};

export default {
	namespaced: true, //用于在全局引用此文件里的方法时标识这一个的文件名
	state,
	getters,
	mutations,
	actions
};
