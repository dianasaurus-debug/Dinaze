<template>
  <div class="login-box">
    <div class="login-logo">
      <a href="../../index2.html"><b>Wakafku</b></a>
    </div>
    <!-- /.login-logo -->
    <div class="card">
      <div class="card-body login-card-body">
        <p class="login-box-msg">Login ke akses admin</p>

        <form @submit.prevent="handleLogin" method="post">
          <div class="input-group mb-3">
            <input type="email" class="form-control" v-model="user.email" placeholder="Email" :class="{ 'is-invalid': submitted && $v.user.email.$error }">
            <div class="input-group-append">
              <div class="input-group-text">
                <span class="fas fa-envelope"></span>
              </div>
            </div>
            <div v-if="submitted && $v.user.email.$error" class="invalid-feedback">
              <span v-if="!$v.user.email.required">Email is required</span>
              <span v-if="!$v.user.email.email">Email is invalid</span>
            </div>
          </div>
          <div class="input-group mb-3">
            <input type="password" class="form-control" v-model="user.password" placeholder="Password" :class="{ 'is-invalid': submitted && $v.user.password.$error }">
            <div class="input-group-append">
              <div class="input-group-text">
                <span class="fas fa-lock"></span>
              </div>
            </div>
            <div v-if="submitted && $v.user.password.$error" class="invalid-feedback">
              <span v-if="!$v.user.password.required">Password is required</span>
              <span v-if="!$v.user.password.minLength">Password must be at least 6 characters</span>
            </div>
          </div>
          <div class="row">
            <div class="col-8">
              <div class="icheck-primary">
                <!--                <input type="checkbox" id="remember">-->
                <!--                <label for="remember">-->
                <!--                  Remember Me-->
                <!--                </label>-->
              </div>
            </div>
            <!-- /.col -->
            <div class="col-4">
              <button type="submit" class="btn btn-primary btn-block">Sign In</button>
            </div>
            <!-- /.col -->
          </div>
        </form>
        <p class="mb-0">
          <router-link to="/admin/register" class="text-center mt-2">Daftar</router-link>
        </p>
      </div>
      <!-- /.login-card-body -->
    </div>
  </div>
  <!-- /.login-box -->
</template>
<script>
import {email, minLength, required} from "vuelidate/lib/validators";
import swal from "sweetalert2";

export default {
  title: 'Login',
  data() {
    return {
      user: {
        email: "",
        password: "",
      },
      loading : false,
      message : '',
      submitted : false,
    };
  },
  mounted () {
    document.body.classList.add('login-page')
  },
  destroyed () {
    document.body.classList.remove('login-page')
  },
  computed: {
    loggedIn() {
      return this.$store.state.auth_admin.status.loggedIn;
    }
  },
  validations: {
    user: {
      email: {required, email},
      password: {required, minLength: minLength(6)},
    }
  },
  methods: {
    handleLogin() {
      this.submitted = true;
      this.loading = true;
      this.$v.$touch();
      if (!this.$v.$invalid) {
        if (this.user.email && this.user.password) {
          this.$Progress.start();
          this.$store.dispatch('auth_admin/login', this.user).then(
              () => {
                this.loading = false;
                this.$Progress.finish();
                this.$router.push('/admin');
              },
              error => {
                this.$Progress.fail();
                swal.fire(
                    'Login Gagal!',
                    'Pastikan anda mengisikan data dengan benar',
                    'error'
                )
                this.loading = false;
                this.message =
                    (error.response && error.response.data) ||
                    error.message ||
                    error.toString();
              }
          );
        }
      }
    },
    logOut() {
      this.$store.dispatch('auth_admin/logout');
    }
  },
  created() {
    console.log(this.$store.state.auth_admin.user)
  }
}
</script>
