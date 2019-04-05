<template>
    <div class="header-wrap">
        <div class="nav-header">
            <!-- logo -->
            <router-link class="logo" to="/home" tag="div">
                <span>校园二手书交易网</span>
            </router-link>
            <!-- 书籍上传 -->
            <div class="upload-book-icon">
                <span class="fa fa-upload fa-lg"></span>
            </div>
            <router-link class="upload-book" to="/bookUpload" tag="div">
                <span>上传</span>
            </router-link>
            <!-- 搜索 -->
            <div class="nav-header-search-bar-wrapper">
                <input type="text" class="search" placeholder="请输入要查询的内容">
                <div class="search-icon">
                    <i class="fa fa-search fa-2x"></i>
                </div>
            </div>
            <!-- 头像 -->
            <div class="head-image">
                <img src="@/assets/images/default_head.jpg" alt>
                <div class="user-info">
                    <div class="user-name">
                        <span>Jason_0316</span>
                    </div>
                    <div class="user-option">
                        <div>
                            <router-link to="/userInfo">
                                <span class="fa fa-info fa-lg"></span> &nbsp;个人信息
                            </router-link>
                        </div>
                        <div>
                            <a>
                                <span class="fa fa-truck fa-lg"></span> &nbsp;我的店铺
                            </a>
                        </div>
                    </div>
                    <div class="user-logout">
                        <a>
                            <span class="fa fa-sign-out fa-lg"></span> &nbsp;退出登录
                        </a>
                    </div>
                </div>
            </div>
            <!-- 订单中心 -->
            <div class="order-center-icon">
                <span class="fa fa-sign-in fa-lg"></span>
            </div>
            <div class="order-center">
                <span>订单中心</span>
            </div>
        </div>
    </div>
</template>


<script>
export default {
    data() {
        return {};
    },
    methods: {}
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
                font-size: 18px;
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
            margin-left: 40px;
            height: inherit;
            // width: 250px;
            cursor: pointer;
            width: 80px;
            position: relative;

            img {
                position: absolute;
                top: 10px;
                // margin-top: 10px;
                // background-color: red;
                border-radius: 50%;
                width: 40px;
                height: 40px;
                right: 0;
                transition-delay: 100ms;
                transition-duration: 500ms;
                z-index: 90;
            }

            &:hover img {
                top: 20px;
                right: -20px;
                width: 80px;
                height: 80px;
                transition-delay: 100ms;
                transition-property: width, height, top, right;
                transition-duration: 500ms;
            }

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
                left: -80px;
                top: 60px;
                // left: 50px;
                display: block;
                width: 250px;
                height: 160px;
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

                .user-logout {
                    a {
                        color: #222;
                        text-decoration: none;
                        line-height: 20px;
                    }
                    a:hover {
                        color: rgb(240, 71, 71);
                        font-size: 16px;
                    }
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
            height: inherit;

            span {
                display: block;
                margin-top: 20px;
                line-height: 20px;
                text-align: center;
                cursor: pointer;
            }
        }
    }
}
</style>

