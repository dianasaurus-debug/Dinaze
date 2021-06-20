<template>
  <div class="register-box">
    <div class="register-logo">
      <a href="../../index2.html"><b>Wakafku</b></a>
    </div>

    <div class="card">
      <div class="card-body register-card-body">
        <p class="login-box-msg">Daftar akun akses admin</p>

        <form @submit.prevent="handleRegister" method="post">
          <div class="input-group mb-3">
            <input type="text" class="form-control" v-model="user.nama" placeholder="Full name" :class="{ 'is-invalid': submitted && $v.user.nama.$error }">
            <div class="input-group-append">
              <div class="input-group-text">
                <span class="fas fa-user"></span>
              </div>
            </div>
            <div v-if="submitted && !$v.user.nama.required" class="invalid-feedback">Nama lengkap tidak bole kosong</div>
          </div>
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
            <input type="password" v-model="user.password" class="form-control" placeholder="Password" :class="{ 'is-invalid': submitted && $v.user.password.$error }">
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
          <div class="input-group mb-3">
            <input type="password" v-model="user.confirmPassword" class="form-control" placeholder="Retype password" :class="{ 'is-invalid': submitted && $v.user.confirmPassword.$error }">
            <div class="input-group-append">
              <div class="input-group-text">
                <span class="fas fa-lock"></span>
              </div>
            </div>
            <div v-if="submitted && $v.user.confirmPassword.$error" class="invalid-feedback">
              <span v-if="!$v.user.confirmPassword.required">Confirm Password is required</span>
              <span v-else-if="!$v.user.confirmPassword.sameAsPassword">Passwords must match</span>
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
              <button type="submit" class="btn btn-primary btn-block">Register</button>
            </div>
            <!-- /.col -->
          </div>
        </form>

        <router-link to="/admin/login" class="text-center mt-2">Login</router-link>
      </div>
      <!-- /.form-box -->
    </div><!-- /.card -->
  </div>
  <!-- /.register-box -->
</template>
<script>
import { required, email, minLength, sameAs } from "vuelidate/lib/validators";
import swal from 'sweetalert2'

export default {
  title: 'Register',
  name: "app",
  destroyed () {
    document.body.classList.remove('register-page')
  },
  data() {
    return {
      user: {
        nama: "",
        email: "",
        password: "",
        confirmPassword: ""
      },
      submitted: false,
      successful: false,
      message: ''
    };
  },
  computed: {
    loggedIn() {
      return this.$store.state.auth_admin.status.loggedIn;
    }
  },
  mounted() {
    if (this.loggedIn) {
      this.$router.push('/admin/login');
    }
    document.body.classList.add('register-page')
  },
  validations: {
    user: {
      nama: { required },
      email: { required, email },
      password: { required, minLength: minLength(6) },
      confirmPassword: { required, sameAsPassword: sameAs('password') }
    }
  },
  methods: {
    handleRegister() {
      this.message = '';
      this.submitted = true;
      this.$v.$touch();
      this.$Progress.start();
      if (!this.$v.$invalid) {
        this.$store.dispatch('auth_admin/register', this.user).then(
            data => {
              this.message = data.message;
              this.successful = true;
              this.$Progress.finish();
              this.$router.push('/admin/login');
            },
            error => {
              this.$Progress.fail();
              swal.fire(
                  'Login Gagal!',
                  'Pastikan anda mengisikan data dengan benar',
                  'error'
              )
              this.message =
                  (error.response && error.response.data) ||
                  error.message ||
                  error.toString();
              this.successful = false;
            }
        );
      }
    },
  }
};
</script>
