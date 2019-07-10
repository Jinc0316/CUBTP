<template>
    <div data-v-e3cc4bbe class="login-container">
        <div class="input-item">
            <div class="el-input el-input--prefix el-input--suffix">
                
                <input
                    type="text"
                    autocomplete="off"
                    placeholder="账户"
                    v-model="user.userId"
                    class="el-input__inner"
                >
                <span class="el-input__prefix">
                    <i class="el-input__icon fa fa fa-user fa-2x"></i>
                </span>
                
                
            </div>
            <div class="el-input el-input--prefix el-input--suffix">
                
                <input
                    type="password"
                    autocomplete="off"
                    placeholder="密码"
                    v-model="user.userPwd"
                    class="el-input__inner"
                >
                <span class="el-input__prefix">
                    <i class="el-input__icon fa fa-lock fa-2x"></i>
                </span>
                <span class="el-input__suffix">
                    <span class="el-input__suffix-inner">   
                    </span> 
                </span>
                
            </div>
            <div class="rememberMe">
                <el-checkbox v-model="user.rememberMe">七天免登录</el-checkbox>
            </div>
            <!-- <el-input placeholder="请输入账户" v-model="user.userId" prefix-icon="fa fa-user fa-2x" clearable></el-input>
            <el-input placeholder="请输入密码" v-model="user.userPwd" prefix-icon="fa fa-lock fa-2x" show-password></el-input>-->
            
            <button type="button" class="el-button el-button--primary" @click="toLogin">
                <span>登录</span>
            </button>
        </div>
    </div>
</template>


<script>
export default {
    data: function() {
        return {
            user: {
                userId: "",
                userPwd: "",
                rememberMe: false
            }
        };
    },
    methods: {
        //login登录方法
        toLogin() {
            //其他的校验逻辑

            // console.log(this.axios)

            this.$axios.post("/user/login", this.user).then(resp => {
                // let userInfoStr = JSON.stringify(resp.data.data);
                // console.log(userInfoStr);

                if (resp.data.msg == "success") {
                    //获取未登录的时候跳到登录页面的redirect地址
                    const redirect = this.$route.query.redirect;
                    if (redirect) {
                        //存在回跳地址就回跳
                        this.$router.push(redirect);
                    } else {
                        //否则就跳到默认的首页
                        this.$router.push({
                            path: "/"
                        });
                    }
                } else {
                    this.$message.error("用户名或者密码输入错误！");
                }
            });
        }
    }
};
</script>


<style lang="less" scoped>
.login-container {
    // margin: 0 auto;
    margin-top: 35px;
    .input-item {
        .rememberMe {
            margin-bottom: 15px;
            label {
                display: block;
                width: 100px;
                margin: 0 auto;
            }
        }
    }
}

//原样式覆盖

.el-input--prefix {
    .el-input__inner {
        padding-left: 40px;
        height: 50px;
        margin-bottom: 20px;
    }

    .el-input__prefix {
        width: 35px;
        height: 50px;
        color: #000000;

        .el-input__icon {
            height: 50px;
        }
        .fa-2x {
            font-size: 20px;
        }
    }
}

.el-button {
    height: 50px;
    width: 100%;
}
</style>


