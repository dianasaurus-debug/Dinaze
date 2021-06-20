<template>
  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-dark navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
    </ul>

  </nav>
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
        this.$router.push('/login');
      }
    }
  };
</script>
