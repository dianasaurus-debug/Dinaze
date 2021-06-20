<template>
  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-light-blue elevation-4">
    <!-- Brand Logo -->
    <!-- Sidebar -->
    <div class="sidebar">

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item">
            <router-link to="/home" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt cyan"></i>
              <p>Dashboard</p>
            </router-link>
          </li>
          <li class="nav-item menu-open">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-cog green"></i>
              <p>
                Riwayat Wakaf Uang
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <router-link to="/home/wakaf/abadi" class="nav-link sub-management">
                  <i class="nav-icon fas fa-mosque cyan"></i>
                  <p>Wakaf Abadi</p>
                </router-link>
              </li>
              <li class="nav-item">
                <router-link to="/home/wakaf/berjangka" class="nav-link  sub-management">
                  <i class="nav-icon fas fa-mosque cyan"></i>
                  <p>Wakaf Berjangka</p>
                </router-link>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <router-link to="/profile" class="nav-link">
              <i class="nav-icon fas fa-building cyan"></i>
              <p>Profil</p>
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
      return this.$store.state.auth.user;
    },
  },
  methods: {
    logOut() {
      this.$store.dispatch('auth/logout');
      this.$router.push('/login');
    }
  }
};
</script>
<style type="text/css" scoped>
.router-link-exact-active {
  color: #fff !important;
  background-color : #00917c;
  font-weight: bold;
}
.nav-link:hover {
  color: #fff !important;
  background-color : #025955;
}
</style>
