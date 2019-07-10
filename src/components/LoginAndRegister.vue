<template>
    <div class="loginAndRegister-container">
        <div class="choose-item">
            <router-link to="/LoginAndRegister/login">登录</router-link>
            <router-link to="/LoginAndRegister/register">注册</router-link>
        </div>

        <router-view/>
    </div>
</template>


<script>
export default {
    data: function() {
        return {};
    },
    methods: {}
};
</script>


<style lang="less" scoped>
.loginAndRegister-container {
    margin: 0 auto;
    margin-top: 8%;
    width:350px;
    //height: 420px;
    border: 0 solid #ccc;
    background-color: #fff;
    border-radius: 3%;
    padding: 50px 55px;
    .choose-item {
        display: flex;
        justify-content: space-between;

        a {
            display: block;
            text-decoration: none;
            font-size: 20px;
            font-weight: bold;
            color: rgb(102, 102, 102);
            width: 50%;
            height: 50px;
            border-width: 0 0 1px 0;
            border-color: #ccc;
            border-style: solid;
            text-align: center;
        }

        .active {
            border-width: 0 0 3px 0;
            color: rgb(43, 129, 228);
            border-color: rgb(43, 129, 228);
        }
    }
}
</style>