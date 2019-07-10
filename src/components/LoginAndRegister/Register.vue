<template>
    <!-- <div class="register-container">
        <div input-item>
            <el-input placeholder="账户" v-model="Account" prefix-icon="fa fa-user fa-2x" clearable></el-input>
            <el-input placeholder="密码" v-model="pwd1" prefix-icon="fa fa-lock fa-2x" show-password></el-input>
            <el-input placeholder="再次输入密码" v-model="pwd2" prefix-icon="fa fa-lock fa-2x" show-password></el-input>
            <el-input placeholder="电话" v-model="tel" prefix-icon="fa fa-phone fa-2x" clearable></el-input>
            <el-input placeholder="邮箱" v-model="email" prefix-icon="fa fa-envelope fa-2x" clearable></el-input>
            <el-button type="primary">提交</el-button>
        </div>
    </div>-->
    <div data-v-e3cc4bbe class="register-container">
        <div input-item>
            <div class="el-input el-input--prefix el-input--suffix">
                <!---->
                <input
                    type="text"
                    autocomplete="off"
                    placeholder="账户"
                    v-model="user.userId"
                    class="el-input__inner"
                >
                <span class="el-input__prefix">
                    <i class="el-input__icon fa fa-user fa-2x"></i>
                </span>
                <!---->
                <!---->
            </div>
            <div class="el-input el-input--prefix el-input--suffix">
                <!---->
                <input
                    type="password"
                    autocomplete="off"
                    placeholder="密码"
                    v-model="pwd1"
                    class="el-input__inner"
                >
                <span class="el-input__prefix">
                    <i class="el-input__icon fa fa-lock fa-2x"></i>
                </span>
                <span class="el-input__suffix">
                    <span class="el-input__suffix-inner">
                        <!---->
                        <!---->
                        <!---->
                    </span>
                    <!---->
                </span>
                <!---->
            </div>
            <div class="el-input el-input--prefix el-input--suffix">
                <!---->
                <input
                    type="password"
                    autocomplete="off"
                    placeholder="再次输入密码"
                    v-model="pwd2"
                    class="el-input__inner"
                >
                <span class="el-input__prefix">
                    <i class="el-input__icon fa fa-lock fa-2x"></i>
                </span>
                <span class="el-input__suffix">
                    <span class="el-input__suffix-inner">
                        <!---->
                        <!---->
                        <!---->
                    </span>
                    <!---->
                </span>
                <!---->
            </div>
            <div class="el-input el-input--prefix el-input--suffix">
                <!---->
                <input
                    type="text"
                    autocomplete="off"
                    placeholder="电话"
                    v-model="user.userTel"
                    class="el-input__inner"
                >
                <span class="el-input__prefix">
                    <i class="el-input__icon fa fa-phone fa-2x"></i>
                </span>
                <!---->
                <!---->
            </div>
            <div class="el-input el-input--prefix el-input--suffix">
                <!---->
                <input
                    type="text"
                    autocomplete="off"
                    placeholder="邮箱"
                    v-model="user.userEmail"
                    class="el-input__inner"
                >
                <span class="el-input__prefix">
                    <i class="el-input__icon fa fa-envelope fa-2x"></i>
                </span>
                <!---->
                <!---->
            </div>
            <button type="button" class="el-button el-button--primary" @click="register">
                <!---->
                <!---->
                <span>提交</span>
            </button>
        </div>
    </div>
</template>


<script>
export default {
    data: function() {
        return {
            pwd1: "",
            pwd2: "",
            user: {
                userId: "",
                userPwd: "",
                userTel: "",
                userEmail: ""
            }
        };
    },
    methods: {
        register() {
            if (this.pwd1 != this.pwd2) {
                this.$message.error("两次密码不一致");
            } else {
                this.user.userPwd = this.pwd2;
            }

            this.$axios.post("/user/register", this.user).then(resp => {
                console.log(resp.data.msg);
                if (resp.data.msg == "success") {
                    this.$message({
                        message: "注册成功，请登录",
                        type: "success"
                    });
                } else {
                    this.$message.error("注册失败，请重试");
                }

                //获取未登录的时候跳到登录页面的redirect地址
                const redirect = this.$route.query.redirect;
                if (redirect) {
                    //存在回跳地址就回跳
                    this.$router.push(redirect);
                } else {
                    //否则就跳到默认的首页
                    this.$router.push({
                        name: "Login"
                    });
                }
            });
        }
    }
};
</script>


<style lang="less" scoped>
.register-container {
    // margin: 0 auto;
    margin-top: 35px;
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
