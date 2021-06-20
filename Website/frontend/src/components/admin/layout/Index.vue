<script>
import NavBar from "../layout/elements/Navbar"
import SideBar from "../layout/elements/Sidebar";
import FooterBar from "../layout/elements/Footer";
import 'admin-lte/dist/css/adminlte.css'
import 'admin-lte/dist/js/adminlte'
export default {
  components: {
    NavBar,
    SideBar,
    FooterBar
  },
  mounted () {
    document.body.classList.add('hold-transition')
    document.body.classList.add('sidebar-mini')
  },
  destroyed () {
    document.body.classList.remove('hold-transition')
    document.body.classList.remove('sidebar-mini')
  },
};
</script>
<template>
  <div class="wrapper">
    <!-- Navbar -->
    <NavBar/>
    <!-- /.navbar -->

    <!-- Main Sidebar Container -->
    <SideBar/>

    <!-- Content Wrapper. Contains page content -->
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
    <!-- /.content-wrapper -->
    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
      <!-- Control sidebar content goes here -->
      <div class="p-3">
        <h5>Title</h5>
        <p>Sidebar content</p>
      </div>
    </aside>
    <!-- /.control-sidebar -->

    <FooterBar/>

  </div>
</template>

