<template>
    <div class="header-wrap">
        <div class="nav-header">
            <!-- logo -->
            <router-link class="logo" to="/" tag="div">
                <span>校园二手书交易网</span>
            </router-link>
            <!-- 书籍上传 -->
            <div class="upload-book-icon">
                <span class="fa fa-upload fa-lg"></span>
            </div>
            <router-link class="upload-book" to="/home/bookUpload" tag="div">
                <span>上传</span>
            </router-link>
            <!-- 搜索 -->
            <div class="nav-header-search-bar-wrapper">
                <input type="text" class="search" placeholder="请输入要查询的内容" v-model="searchContent" @keyup.enter="search">
                <div class="search-icon" @click="search">
                    <i class="fa fa-search fa-2x"></i>
                </div>
            </div>
            <!-- 头像 -->
            <div class="head-image" v-show="isLogin">
                <img
                    class="img-active"
                    :src="require('@/assets/images/user_head_img/'+userInfo.userHeadImg)"
                    alt
                >
                <div class="user-info">
                    <div class="user-name">
                        <span>{{userInfo.userId}}</span>
                    </div>
                    <div class="user-option">
                        <div>
                            <router-link to="/home/userInfo">
                                <span class="fa fa-info fa-lg"></span> &nbsp;个人信息
                            </router-link>
                        </div>
                        <div>
                            <router-link to="/home/myStore">
                                <span class="fa fa-truck fa-lg"></span> &nbsp;我的店铺
                            </router-link>
                        </div>
                    </div>
                    <div class="user-option" v-show="isAdmin">
                        <div>
                            <router-link to="/home/adminCenter/bookManage/notCheckedBook">
                                <span class="fa fa-asterisk fa-lg"></span> &nbsp;管理中心
                            </router-link>
                        </div>
                    </div>
                    <div
                        class="user-option"
                        @click="logout"
                        style="border-bottom:none; margin-bottom:0;"
                    >
                        <div>
                            <a>
                                <span class="fa fa-sign-out fa-lg"></span> &nbsp;退出登录
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 登录|注册 -->
            <div class="nav-header-regis-login" v-show="!isLogin">
                <router-link class="nav-header-regis" to="/LoginAndRegister/register" tag="div">注册</router-link>
                <div data-v-7becb7b9 class="nav-header-middle-line"></div>
                <router-link
                    data-v-7becb7b9
                    class="nav-header-login"
                    to="/LoginAndRegister/login"
                    tag="div"
                >登录</router-link>
            </div>
            <!-- 订单中心 -->
            <div class="order-center-icon">
                <span class="fa fa-sign-in fa-lg"></span>
            </div>
            <router-link to="/home/orderCenter" class="order-center" tag="div">
                <span>订单中心</span>
            </router-link>
        </div>
    </div>
</template>


<script>
import { mapState, mapGetters, mapActions } from "vuex";
export default {
    data() {
        return {
            isLogin: false,
            isAdmin: false,
            userInfo: {
                userHeadImg: "default_headImage.jpg"
            },
            searchContent: ""
        };
    },
    created() {
        this.headerRender();
    },
    methods: {
        ...mapActions("user", [
            //user是指modules文件夹下的user.js
            "setUser" //user.js文件中的actions里的方法.
        ]),
        ...mapGetters("user", [
            //user是指modules文件夹下的user.js
            "getUserInfo" //user.js文件中的actions里的方法.
        ]),
        ...mapActions("book", [
            "setSContent",
            "setBList",
            "setAll",
            "setCPage",
            "setPSize"
        ]),
        ...mapGetters("book", [
            "getSearchContent",
            "getBookList",
            "getTotal",
            "getCurrentPage",
            "getPageSize"
        ]),
        search() {
            let searchContent = this.getSearchContent();
            console.log(searchContent);
            if (this.searchContent ==="") {
                searchContent.content = null;
            } else {
                searchContent.content = this.searchContent;
            }
            let param1 = {
                ...searchContent,
                currentPage: 1,
                pageSize: 10
            };
            console.log(param1);
            this.$axios.post("/book/searchBook", param1).then(resp => {
                // console.log(resp);
                this.setBList(resp.data.data);
                this.setCPage(1);
                this.setPSize(10);
                // this.setSContent("")
            });

            let param2 = {
                ...this.getSearchContent()
            };

            this.$axios.post("/book/getSearchBookCount", param2).then(resp => {
                // console.log(resp.data.data.total);
                this.setAll(resp.data.data.total);
            });
        },

        headerRender() {
            let userId = this.$cookieStore.getCookie("userId");
            console.log("Cookie中的用户为：" + userId);

            if (userId != null) {
                this.$axios
                    .get("/user/getUserInfo?userId=" + userId)
                    .then(resp => {
                        // console.log(resp.data.data);
                        // this.$store.dispatch("user/setUser", resp.data.data);
                        let userInfo = resp.data.data;
                        this.setUser(userInfo);
                        if (userInfo.userRole == 1) {
                            this.isAdmin = true;
                            // this.$message({
                            //     type: "info",
                            //     message: "欢迎管理员：" + userInfo.userId
                            // });
                            this.$notify.success({
                                title: "Info",
                                message: "欢迎管理员：" + userInfo.userId,
                                position: "bottom-right",
                                showClose: false
                            });
                        }
                        this.isLogin = true;
                        // console.log(this.getUserInfo());
                        console.log(this.getUserInfo());

                        this.userInfo = this.getUserInfo();
                    });
            } else {
                this.isLogin = false;
                this.isAdmin = false;
            }
        },
        logout() {
            this.$axios.get("/user/logout").then(resp => {
                console.log(resp.data.msg === "success");

                if (resp.data.msg === "fail") {
                    this.$message.error("退出登录错误");
                }

                this.$message({
                    message: "退出登录成功",
                    type: "success"
                });

                //回到首页
                this.$router.push({
                    path: "/"
                });

                this.headerRender();
            });
        }
    }
};
</script>


<style lang='less' scoped>
button,
input,
select,
textarea {
    outline: none;
}
.header-wrap {
    // position: relative;
    width: 100%;
    min-width: 1160px;
    height: 60px;
    background-color: #fff;
    border-bottom: 1px solid #ccc;
    box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2);
    text-align: center;

    .nav-header {
        width: 1160px;
        margin: 0 auto;
        display: flex;
        justify-content: flex-start;

        .logo {
            // position: absolute;
            // margin-left: 200px;
            left: 0;
            height: inherit;
            cursor: pointer;
            // width: 300px;

            span {
                font-size: 2em;
                line-height: 60px;
            }
        }

        .upload-book-icon {
            margin-left: 20px;
            span {
                line-height: 60px;
            }
        }
        .upload-book {
            margin-left: 8px;
            width: 45px;
            cursor: pointer;
            span {
                font-size: 1em;
                line-height: 60px;
            }

            &:hover {
                font-size: 16px;
                color: rgb(240, 71, 71);
            }
        }
        .nav-header-search-bar-wrapper {
            // flex: 1;
            position: relative;
            .search {
                cursor: auto;
                font-size: 12px;
                color: #6d757a;
                line-height: 14px;
                margin-left: 250px;
                margin-top: 9px;
                width: 360px;
                height: 40px;
                border: none;
                padding-left: 20px;
                background: #f1f3f5;
                border-radius: 40px;
            }
            .search-icon {
                position: absolute;
                cursor: pointer;
                // transform: translateY(-50%);
                // background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAAAXNSR…yI05QV1FNd/5uGnNysKY4mfNLOWZ/hAFD0tYIw7wz0/3EbU/0A4mUiUMEAAAAASUVORK5CYII=);
                top: 27%;
                right: 15px;
                color: rgb(173, 169, 169);
                width: 30px;
                height: 30px;
                // background-size: 100% 100%;
                // background-repeat: no-repeat;
            }
        }

        .head-image {
            // right: 305px;
            // position: absolute;
            // margin-left: 10px;
            height: inherit;
            // width: 250px;
            cursor: pointer;
            width: 60px;
            position: relative;

            .img-active {
                position: absolute;
                top: 10px;
                // margin-top: 10px;
                // background-color: red;
                border-radius: 50%;
                width: 40px;
                height: 40px;
                right: 0;
                transition: all 0.3s;
                z-index: 90;
            }
            &:hover .img-active {
                transform: scale(2) translateY(15px);
            }
            // &:hover img {
            //     top: 20px;
            //     right: -20px;
            //     width: 80px;
            //     height: 80px;
            //     transition-delay: 100ms;
            //     transition-property: width, height, top, right;
            //     transition-duration: 300ms;
            // }

            .user-info {
                position: absolute;
                display: none;
                // width: 0;
                // height: 0;
                // top: 0;
                // right: 0;
                z-index: 10;
            }

            &:hover .user-info {
                // position: absolute;
                left: -105px;
                top: 60px;
                // left: 50px;
                display: block;
                width: 250px;
                // height: 160px;
                padding: 40px 20px 0 20px;
                list-style: none;
                background-color: #fff;

                // margin: 0;
                // margin-top: -35px;
                // transition-delay: 100ms;
                // transition-property: width, height, top, right;
                // transition-duration: 500ms;

                .user-name {
                    margin-top: 20px;
                    width: 100%;
                    height: 34px;
                    color: rgb(240, 71, 71);
                    border-bottom: 1px solid #000;
                }

                .user-option {
                    margin-top: 20px;
                    display: flex;
                    justify-content: space-around;
                    margin-bottom: 15px;
                    border-bottom: 1px solid #000;

                    div {
                        a {
                            color: #222;
                            text-decoration: none;
                            line-height: 20px;
                        }
                        a:hover {
                            color: rgb(240, 71, 71);
                            font-size: 16px;
                        }
                        margin-bottom: 15px;
                    }
                }

                // .user-logout {
                //     a {
                //         color: #222;
                //         text-decoration: none;
                //         line-height: 20px;
                //     }
                //     a:hover {
                //         color: rgb(240, 71, 71);
                //         font-size: 16px;
                //     }
                // }
            }
        }

        .nav-header-regis-login {
            -ms-flex-align: center;
            align-items: center;
            display: -ms-flexbox;
            display: flex;
            font-size: 14px;
            color: #636c7b;
            letter-spacing: 0;
            line-height: 20px;
            margin-left: 35px;
            width: 90px;

            .nav-header-regis {
                color: #636c7b;
                text-decoration: none;
                cursor: pointer;

                &:hover {
                    color: rgb(240, 71, 71);
                }
            }

            .nav-header-middle-line {
                margin: 0 4px;
                width: 1px;
                height: 12px;
                background: #636c7b;
            }

            .nav-header-login {
                cursor: pointer;
                &:hover {
                    color: rgb(240, 71, 71);
                }
            }
        }

        .order-center-icon {
            margin-left: 30px;
            span {
                line-height: 60px;
            }
        }
        .order-center {
            // width: 100px;
            // position: absolute;
            margin-left: 8px;
            width: 65px;
            cursor: pointer;

            span {
                font-size: 1em;
                line-height: 60px;
            }

            &:hover {
                font-size: 16px;
                color: rgb(240, 71, 71);
            }
        }
    }
}
</style>

