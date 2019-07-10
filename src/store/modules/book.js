const state = {
	//要设置的全局访问的state对象
	searchContent: {
        content: null,
        bookType: null,
        bookSubject: null,
        bookDegree: null
    },
    bookList:[],
    total:0,
    currentPage:1,
    pageSize: 10
	
};

const getters = {
	//实时监听state值的变化(最新状态)
	getSearchContent(state) {
		return state.searchContent;
    },
    getBookList(state) {
        // state.bookList = JSON.parse(sessionStorage.getItem('bookList'));
        // console.log(state.bookList,1111);
        
        return state.bookList;
    },
    getTotal(state) {
        return state.total;
    },
    getCurrentPage(state) {
        return state.currentPage;
    },
    getPageSize(state) {
        return state.pageSize;
    }
};

const mutations = {
	setSearchContent(state, searchContent) {
		state.searchContent = searchContent;
    },
    setBookList(state, bookList) {
        // sessionStorage.setItem("bookList", JSON.stringify(bookList)); 
        state.bookList = bookList;
        // console.log(state.bookList,222);
        
    },
    setTotal(state, total) {
        state.total = total;
    },
    setCurrentPage(state, currentPage) {
        state.currentPage = currentPage;
    },
    setPageSize(state, pageSize) {
        state.pageSize = pageSize;
    }
};

const actions = {
	setSContent({ commit }, searchContent) {

        // if(searchContent=="") {
        //     return
        // }
		commit('setSearchContent', searchContent);
    },
    setBList({ commit }, bookList) {
		commit('setBookList', bookList);
    },
    setAll({ commit }, total) {
		commit('setTotal', total);
    },
    setCPage({ commit }, currentPage) {
        commit('setCurrentPage', currentPage);
    },
    setPSize({ commit }, pageSize) {
        commit('setPageSize', pageSize);
    }
};

export default {
	namespaced: true, //用于在全局引用此文件里的方法时标识这一个的文件名
	state,
	getters,
	mutations,
	actions
};
