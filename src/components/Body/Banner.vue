<template>
 
    <div class="block">
        <!-- <span class="demonstration">默认 Hover 指示器触发</span> -->
        <el-carousel height="300px">
            <el-carousel-item v-for="(item,i) in bannerList" :key="i" style="z-index:1" :style="{backgroundImage: 'url(' + require('@/assets/images/banner_img/'+ item.bannerImg) + ')'}">
            </el-carousel-item>
        </el-carousel>
    </div>
</template>

<script>
export default {
    data() {
        return {
            bannerList:[
                {"bannerImg" : "banner_1.jpg"},
                {"bannerImg" : "banner_2.jpg"},
                {"bannerImg" : "banner_3.jpg"},
                {"bannerImg" : "banner_4.jpg"}
            ]
        }
    }
};
</script>



 <style lang="less">

.el-carousel__item h3 {
    color: #475669;
    font-size: 14px;
    opacity: 0.75;
    line-height: 300px;
    margin: 0;
}

.el-carousel__item:nth-child(2n) {
    background-color: #99a9bf;
}

.el-carousel__item:nth-child(2n + 1) {
    background-color: #d3dce6;
}
</style>