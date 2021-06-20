<template>
  <div class="container mb-5 mt-5">
  <div class="row py-5 mt-4 align-items-center">
    <!-- For Demo Purpose -->
    <div class="col-md-5 pr-lg-5 mb-5 mb-md-0">
      <img src="../../../assets/images/login_pic.png" alt="" class="img-fluid mb-3 d-none d-md-block">
      <h1>Login</h1>
    </div>

    <!-- Registeration Form -->
    <div class="col-md-7 col-lg-6 ml-auto">
      <form @submit.prevent="handleLogin">
        <div class="row">

          <!-- Email Address -->
          <div class="input-group col-lg-12 mb-4">
            <div class="input-group-prepend">
                            <span class="input-group-text bg-white px-4 border-md border-right-0">
                                <i class="fa fa-envelope text-muted"></i>
                            </span>
            </div>
            <input id="email" v-model="user.email" type="email" name="email" placeholder="Email Address"
                   class="form-control bg-white border-left-0 border-md"
                   :class="{ 'is-invalid': submitted && $v.user.email.$error }">
            <div v-if="submitted && $v.user.email.$error" class="invalid-feedback">
              <span v-if="!$v.user.email.required">Email is required</span>
              <span v-if="!$v.user.email.email">Email is invalid</span>
            </div>
          </div>

          <!-- Password -->
          <div class="input-group col-lg-12 mb-4">
            <div class="input-group-prepend">
                            <span class="input-group-text bg-white px-4 border-md border-right-0">
                                <i class="fa fa-lock text-muted"></i>
                            </span>
            </div>
            <input id="password" v-model="user.password" type="password" name="password" placeholder="Password"
                   class="form-control bg-white border-left-0 border-md"
                   :class="{ 'is-invalid': submitted && $v.user.password.$error }">
            <div v-if="submitted && $v.user.password.$error" class="invalid-feedback">
              <span v-if="!$v.user.password.required">Password is required</span>
              <span v-if="!$v.user.password.minLength">Password must be at least 6 characters</span>
            </div>
          </div>

          <!-- Submit Button -->
          <div class="form-group col-lg-12 mx-auto mb-0">
            <button class="btn btn-primary btn-block py-2" type="submit">
              <span class="font-weight-bold">Login</span>
            </button>
          </div>

          <!-- Already Registered -->
          <div class="text-center w-100">
            <p class="text-muted font-weight-bold">Belum punya akun?
              <router-link to="/register" class="text-primary ml-2">Register</router-link>
            </p>
          </div>
          <div class="text-center w-100">
            <p class="text-muted font-weight-bold">Lupa kata sandi?
              <router-link to="/forgot-password/request" class="text-primary ml-2">Atur ulang kata sandi</router-link>
            </p>
          </div>
        </div>
      </form>
    </div>
  </div>
  </div>
</template>
<script>
import {required, email, minLength} from "vuelidate/lib/validators";
import swal from 'sweetalert2'

export default {
  title: 'Login',
  name: "app",
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
  computed: {
    loggedIn() {
      return this.$store.state.auth.status.loggedIn;
    }
  },
  created() {
    if (this.loggedIn) {
      this.$router.push('/profile');
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
          this.$store.dispatch('auth/login', this.user).then(
              () => {
                this.loading = false;
                this.$Progress.finish();
                this.$router.push('/home');
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
    }
  },

};
</script>
