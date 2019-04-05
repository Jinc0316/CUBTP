<template>
    <div class="login-container">
        <div input-item>
            <el-input
                placeholder="账户"
                v-model="account"
                prefix-icon="fa fa fa-user fa-2x"
                clearable
            ></el-input>
            <el-input placeholder="密码" v-model="pwd" prefix-icon="fa fa-lock fa-2x" show-password></el-input>
            <el-button type="primary" @click="toLogin">登录</el-button>
        </div>
    </div>
</template>


<script>
export default {
    data: function() {
        return {
            account: "",
            pwd: ""
        };
    },
    methods: {
        //login登录方法
        toLogin() {
            //其他的校验逻辑
            //...
            //获取未登录的时候跳到登录页面的redirect地址
            const redirect = this.$route.query.redirect;
            if (redirect) {
                //存在回跳地址就回跳
                this.$router.push(redirect);
            } else {
                //否则就跳到默认的首页
                this.$router.push({
                    name: "Home"
                });
            }
        }
    }
};
</script>


<style lang="less">
.login-container {
    // margin: 0 auto;
    margin-top: 35px;
}

//原样式覆盖
.fa-2x {
    font-size: 20px;
}
.el-input__icon {
    height: 50px;
}
.el-input--prefix .el-input__inner {
    padding-left: 40px;
}

.el-input__prefix {
    width: 35px;
    height: 50px;
    color: #000000;
}

.el-input__inner {
    height: 50px;
    margin-bottom: 20px;
}

.el-button {
    height: 50px;
    width: 100%;
}
</style>


