<template>
  <nav class="navbar navbar-expand-lg navbar-expand" style="background-color: rgba(19, 110, 68);" id="first-nav">
    <router-link class="navbar-brand" to="/">WAKAFKU</router-link>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav ml-auto">
        <li class="nav-item active">
          <router-link class="nav-link" v-if="currentUser" to="/home">Home</router-link>
        </li>
        <li class="nav-item">
          <router-link class="nav-link" v-if="currentUser" to="/programs">Program</router-link>
        </li>
        <li class="nav-item">
          <router-link class="nav-link" to="/about-us">About Us</router-link>
        </li>
        <li class="nav-item">
          <router-link class="btn btn-outline-success my-2 my-sm-0 mr-2" tag="button" to="/login" v-if="!currentUser">Masuk</router-link>
        </li>
        <li class="nav-item">
          <router-link class="btn btn-outline-success my-2 my-sm-0 mr-2" tag="button" to="/register" v-if="!currentUser">Daftar</router-link>
        </li>

        <li class="nav-item dropdown" v-if="currentUser">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown2" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            {{ currentUser.data.data.nama }}
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdown2">
            <router-link class="dropdown-item" to="/profile">Profile</router-link>
            <a class="dropdown-item" href @click.prevent="logOut">Logout</a>
          </div>
        </li>
      </ul>

    </div>
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
<style type="text/css" scoped>
.router-link-exact-active {
  font-weight: bold;
}
.nav-link {
  color: #fff !important;
}
nav {
  position:relative;
  z-index: 1000;
}

</style>
