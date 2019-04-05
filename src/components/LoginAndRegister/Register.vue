<template>
    <div class="register-container">
        <div input-item>
            <el-input placeholder="账户" v-model="Account" prefix-icon="fa fa-user fa-2x" clearable></el-input>
            <el-input placeholder="密码" v-model="pwd1" prefix-icon="fa fa-lock fa-2x" show-password></el-input>
            <el-input placeholder="再次输入密码" v-model="pwd2" prefix-icon="fa fa-lock fa-2x" show-password></el-input>
            <el-input placeholder="电话" v-model="tel" prefix-icon="fa fa-phone fa-2x" clearable></el-input>
            <el-input placeholder="邮箱" v-model="email" prefix-icon="fa fa-envelope fa-2x" clearable></el-input>
            <el-button type="primary">提交</el-button>
        </div>
    </div>
</template>


<script>
export default {
    data: function() {
        return {
            Account: "",
            pwd1: "",
            pwd2: "",
            tel: "",
            email: ""
        };
    },
    methods: {}
};
</script>


<style lang="less">
.register-container {
    // margin: 0 auto;
    margin-top: 35px;
}

//原样式覆盖
.fa-2x {
    font-size: 20px;
}
.el-input__icon  {
    height: 50px;
}
.el-input--prefix .el-input__inner {
    padding-left: 40px;
}

.el-input__prefix{
    width: 35px;
    height: 50px;
    color: #000000;
}

.el-input__inner{
    height: 50px; 
    margin-bottom: 20px;
}

.el-button {
    height: 50px;
    width: 100%;
}
</style>
