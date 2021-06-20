<script>
import NavBar from "./elements/Navbar"
import Footer from "./elements/Footer";
import Navbar2 from "@/components/user/layouts/elements/Navbar2";
import Sidebar from "@/components/user/layouts/elements/Sidebar";
import 'admin-lte/dist/css/adminlte.css'
import 'admin-lte/dist/js/adminlte'

export default {
  components: {
    Sidebar,
    Navbar2,
    NavBar,
    Footer
  },
  mounted() {
    document.body.classList.add('hold-transition')
    document.body.classList.add('sidebar-mini')
    document.getElementById('first-nav').classList.add('main-header')
  },
  destroyed() {
    document.body.classList.remove('hold-transition')
    document.body.classList.remove('sidebar-mini')
    document.getElementById('first-nav').classList.remove('main-header');
  },
};
</script>
<template>
  <div class="wrapper">
<!--    &lt;!&ndash; Navbar &ndash;&gt;-->
    <NavBar/>
    <!-- /.navbar -->
    <Navbar2/>
    <!-- Main Sidebar Container -->
    <Sidebar/>
    <div class="content-wrapper">
      <!-- Main content -->
      <div class="content">
        <div class="container-fluid">
          <slot/>
        </div><!-- /.container-fluid -->
      </div>
      <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    <Footer/>
  </div>
</template>
<style scoped>
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
