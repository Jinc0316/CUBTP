<template>
    <div id="app">
        <router-view/>
    </div>
</template>

<script>
export default {
    name: "App"
};
</script>

<style>
html,
body {
    margin: 0;
    padding: 0;
    background-color: rgb(240, 242, 245);
}

#app {
    font-family: "Avenir", Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    /* color: #2c3e50; */
    font-size: 12px;
    color: #222;

    /* background-color: rgb(240, 242, 245);
  width: 100%;
  height: 100%; */
}
</style>
