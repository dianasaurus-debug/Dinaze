<template>
  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-blue elevation-4">
    <!-- Brand Logo -->
    <a href="index3.html" class="brand-link">
      <img src="../../../../assets/logo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">WakafKu</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="../../../../assets/images/admin-6.png" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block">{{ currentUser.user.nama}}</a>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item">
            <router-link to="/admin" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt cyan"></i>
              <p>Dashboard</p>
            </router-link>
          </li>
          <li class="nav-item">
            <router-link to="/admin/program" class="nav-link">
              <i class="nav-icon fas fa-mosque cyan"></i>
              <p>Program</p>
            </router-link>
          </li>
          <li class="nav-item">
            <router-link to="/admin/wakaf/kategori" class="nav-link">
              <i class="nav-icon fas fa-building cyan"></i>
              <p>Kategori</p>
            </router-link>
          </li>
          <li class="nav-item menu-open">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-cog green"></i>
              <p>
                Wakaf Uang
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <router-link to="/admin/wakaf/abadi" class="nav-link sub-management">
                  <i class="nav-icon fas fa-credit-card"></i>
                  <p>Wakaf Uang Abadi</p>
                </router-link>
              </li>
              <li class="nav-item">
                <router-link to="/admin/wakaf/berjangka" class="nav-link  sub-management">
                  <i class="nav-icon fas fa-credit-card"></i>
                  <p>Wakaf Uang Berjangka</p>
                </router-link>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <router-link to="/admin/wakif/all" class="nav-link">
              <i class="nav-icon fa fa-users cyan"></i>
              <p>Wakif List</p>
            </router-link>
          </li>
          <li class="nav-item">
            <a href @click.prevent="logOut" class="nav-link">
              <i class="nav-icon fas fa-sign-out-alt red"></i>
              <p>Logout</p>
            </a>
          </li>
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>
</template>

<script>
export default {
  computed: {
    currentUser() {
      return this.$store.state.auth_admin.user;
    },
  },
  methods: {
    logOut() {
      this.$store.dispatch('auth_admin/logout');
      this.$router.push('/admin/login');
    }
  }
};
</script>
