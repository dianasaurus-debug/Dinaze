<template>
  <div id="app">
    <component :is="layout">
      <router-view></router-view>
    </component>
  </div>
</template>

<script>
export default {
  name: 'App',
  computed : {
    layout() {
      return (this.$route.meta.layout) + '-layout';
    }
  }
}
</script>
<style>
@import url('https://fonts.googleapis.com/css?family=Raleway');
html,h1,h2,h3,h4,h5,h6,a{
  font-family: "Raleway";
}
.navbar-brand{
  color: #f4f4f4;
  cursor: pointer;
}
</style>


