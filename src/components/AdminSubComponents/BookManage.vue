<template>
    <div class="bookManage-container">
        <div class="bookManage-content">
            <div class="bookManage-guide-wrapper">
                <router-link to="/home/adminCenter/bookManage/notCheckedBook" tag="div">待审核书籍</router-link>
                <router-link to="/home/adminCenter/bookManage/checkedBook" tag="div">已审核书籍</router-link>
            </div>
            <router-view v-if="isRouterAlive2"/>
        </div>
    </div>
</template>

<script>
export default {
    name:"bookManage",
    provide() {
        return {
            reload2: this.reload2
        };
    },
    data() {
        return {
            isRouterAlive2: true
        };
    },
    methods: {
        reload2() {
            this.isRouterAlive2 = false;
            this.$nextTick(() => (this.isRouterAlive2 = true));
        }
    }
};
</script>


<style lang="less" scoped>
.bookManage-container {
    margin-top: 25px;
    .bookManage-content {
        .bookManage-guide-wrapper {
            padding-bottom: 15px;
            display: flex;
            justify-content: flex-start;
            div {
                font-size: 14px;
                font-weight: bold;
                margin-right: 50px;

                cursor: pointer;

                &:hover {
                    color: rgb(250, 162, 162);
                }
            }

            .active {
                color: rgb(240, 71, 71);
            }
        }
    }
}
</style>

