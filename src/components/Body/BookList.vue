<template>
    <div>
        <div class="book-list-wrapper">
            <div class="book-list">
                <router-link class="book-list-item" to="/bookinfo" tag="div">
                    <div
                        class="book-list-item-img"
                        style="background-image: url(&quot;//i2.hdslb.com/bfs/openplatform/201903/imr9OEJGULU.jpeg@350w_466h.jpeg&quot;);"
                    ></div>
                    <div class="book-list-item-detail">
                        <div class="book-list-item-title">高等数学</div>
                        <div class="book-list-item-time">
                            <span class="icon time-icon"></span>作者：Jason
                        </div>
                        <div class="book-list-item-time">
                            <span class="icon time-icon"></span>成色：九成新
                        </div>
                        <div class="book-list-item-time">
                            <span class="icon time-icon"></span>书籍数量：0
                        </div>
                        <div class="book-list-item-address">
                            <span class="icon address-icon"></span>
                            <!---->
                            <span class="venue-name-and-address">出版社：人民出版社</span>
                        </div>
                        <div class="book-list-item-price">
                            <div class="not-free">
                                <span class="price-symbol">¥</span>
                                <span class="price">170</span>
                            </div>
                        </div>
                    </div>
                </router-link>
            </div>
        </div>
    </div>
</template>


<script>
export default {};
</script>

<style lang="less" scoped>
.book-list-wrapper {
    width: 1160px;
    margin: 0 auto;
    overflow: hidden;
    padding-bottom: 55px;

    .book-list {
        width: 1160px;
        margin: 0 auto;
        .book-list-item {
            cursor: pointer;
            display: -ms-flexbox;
            display: flex;
            position: relative;
            margin-top: 60px;
            margin-right: 40px;
            width: 560px;
            height: 237px;
            background: #fff;
            box-shadow: 0 0 15px 0 hsla(203, 6%, 45%, 0.09);
            border-radius: 8px;
            float: left;
            transition: transform 0.2s;

            &:hover {
                box-shadow: 0 15px 20px 0 hsla(203, 6%, 45%, 0.4);
            }

            &:hover .book-list-item-img {
                transform: translate3d(0, -10px, 0);
            }

            .book-list-item-img {
                transition: transform 0.1s;
                background: #fff;
                box-shadow: 3px 3px 2px 0 hsla(203, 6%, 45%, 0.3);
                border-radius: 8px;
                left: 20px;
                bottom: 24px;
                position: absolute;
                width: 175px;
                height: 233px;
                background-repeat: no-repeat;
                background-size: 100% 100%;
            }

            .book-list-item-detail {
                margin-left: 223px;

                .book-list-item-title {
                    overflow: hidden;
                    text-overflow: ellipsis;
                    display: -webkit-box;
                    -webkit-line-clamp: 2;
                    margin-top: 30px;
                    width: 286px;
                    height: 20px;
                    font-size: 18px;
                    color: #222;
                    letter-spacing: 0;
                    line-height: 24px;
                }

                .book-list-item-time {
                    margin-top: 10px;
                    display: -ms-flexbox;
                    display: flex;
                    -ms-flex-align: center;
                    align-items: center;
                    height: 17px;
                    font-size: 14px;
                    color: #999;
                }

                .book-list-item-address {
                    margin-top: 10px;
                    display: -ms-flexbox;
                    display: flex;
                    -ms-flex-align: center;
                    align-items: center;
                    height: 17px;
                    font-size: 14px;
                    color: #999;
                }

                .book-list-item-price,
                .book-list-item-price .not-free {
                    display: -ms-flexbox;
                    display: flex;
                    -ms-flex-align: end;
                    align-items: flex-end;
                    margin-top: 10px;
                    color: #f25d8e;

                    .price-symbol {
                        -ms-flex-item-align: end;
                        align-self: flex-end;
                        font-size: 18px;
                        line-height: 18px;
                    }
                    .price {
                        margin-left: 4px;
                        font-size: 28px;
                        letter-spacing: 1px;
                        line-height: 24px;
                    }
                }
            }
        }
    }
}
</style>


