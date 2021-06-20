<script>
import NavBar from "./elements/Navbar"
import Footer from "./elements/Footer";
export default {
  components: {
    NavBar,
    Footer
  }
};
</script>
<template>
  <div>
    <!-- Navbar -->
    <NavBar/>
    <!-- /.navbar -->

    <!-- Content Wrapper. Contains page content -->
    <div class="container-fluid">
      <slot/>
    </div>
    <!-- /.content-wrapper -->
    <Footer/>
  </div>
</template>
<style>
.container {
  max-width:1140px !important;
}
/* Sticky footer styles
-------------------------------------------------- */
html {
  position: relative;
  min-height: 100%;
}
body {
  margin-bottom: 60px; /* Margin bottom by footer height */
}
.footer {
  position: absolute;
  bottom: 0;
  width: 100%;
  height: 60px; /* Set the fixed height of the footer here */
  line-height: 60px; /* Vertically center the text there */
  background-color: #f5f5f5;
}


/* Custom page CSS
-------------------------------------------------- */
/* Not required for template or sticky footer method. */

.container {
  width: auto;
  max-width: 680px;
  padding: 0 15px;
}



</style>
