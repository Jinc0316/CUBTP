<template>
    <div class="home">
        <nav-header></nav-header>
        <!-- <banner-box></banner-box>
        <option-menu></option-menu>
        <book-list></book-list>-->

        <router-view v-if="isRouterAlive"/>
        <footer-box></footer-box>
    </div>
</template>


<script>
import Header from "./Header/Header";

import Footer from "./Footer/Footer";
// import OptionMenu from "./Body/OptionMenu";
// import BookList from "./Body/BookList";

export default {
    provide() {
        return {
            reload: this.reload
        };
    },
    data() {
        return {
            isRouterAlive: true
        };
    },
    methods: {
        reload() {
            this.isRouterAlive = false;
            this.$nextTick(() => (this.isRouterAlive = true));
        }
    },
    components: {
        "nav-header": Header,
        "footer-box": Footer
        // "option-menu": OptionMenu,
        // "book-list": BookList
    }
};
</script>


<style lang="less" scoped>
</style>

