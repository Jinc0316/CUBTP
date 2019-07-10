<template>
    <div class="orderCenter-container">
        <!-- <h3>这里时订单中心</h3> -->

        <div class="orderCenter-content">
            <div class="orderCenter-guide-wrapper">
                <router-link to="/home/orderCenter/boughtBooks" tag="div">已买的书籍</router-link>
                <router-link to="/home/orderCenter/soldBooks" tag="div">已出售书籍</router-link>
                
            </div>
            <router-view/>
        </div>
    </div>
</template>


<script>
export default {
    
}
</script>



<style lang="less" scoped>
.orderCenter-container {
    .orderCenter-content {
        width: 1160px;
        background-color: #fff;
        margin: 0 auto;
        margin-top: 40px;
        padding: 40px;
        min-height: 545px;
        .orderCenter-guide-wrapper {
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




