<template>
    <div class="adminCenter-container">
        <div class="adminCenter-content">
            <div class="adminCenter-guide-wrapper">
                <router-link to="/home/adminCenter/bookManage" tag="div">书籍管理</router-link>
                <router-link to="/home/adminCenter/userManage" tag="div">用户管理</router-link>
            </div>

            <router-view/>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            active: true
        }
    }
};
</script>


<style lang="less" scoped>
.adminCenter-container {
    .adminCenter-content {
        width: 1160px;
        background-color: #fff;
        margin: 0 auto;
        margin-top: 40px;
        padding: 40px;
        
        .adminCenter-guide-wrapper {
            padding-bottom: 15px;
            border-bottom: 1px dashed #ccc;
            display: flex;
            justify-content: flex-start;
            div {
                font-size: 16px;
                font-weight: bold;
                margin-right: 50px;
                
                
                cursor: pointer;

                &:hover {
                    color: rgb(250, 162, 162);
                }
            }

            .active {
                color: rgb(240, 71, 71);
                border-bottom: 2px solid rgb(240, 71, 71);
            }
        }
    }
}
</style>

