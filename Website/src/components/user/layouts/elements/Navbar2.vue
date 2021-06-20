<template>
  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand-lg navbar-expand navbar-success navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="#" data-widget="pushmenu" role="button"><i class="fas fa-bars"></i></a>
      </li>
    </ul>

  </nav>
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
<style scoped>
nav {
  z-index:100;
}
</style>
