<template>
  <div class="container mb-5 mt-5">
  <div class="row py-5 mt-4 align-items-center">
    <!-- For Demo Purpose -->
    <div class="col-md-5 pr-lg-5 mb-5 mb-md-0">
      <img src="../../../assets/images/masjid.png" alt="" class="img-fluid mb-3 d-none d-md-block">
      <h1>Daftar</h1>
    </div>

    <!-- Registeration Form -->
    <div class="col-md-7 col-lg-6 ml-auto">
      <form @submit.prevent="handleRegister">
        <div class="row">

          <!-- Nama lengkap -->
          <div class="input-group col-lg-12 mb-4">
            <div class="input-group-prepend">
                            <span class="input-group-text bg-white px-4 border-md border-right-0">
                                <i class="fa fa-user text-muted"></i>
                            </span>
            </div>
            <input id="nama" type="text" v-model="user.nama" name="nama" placeholder="Nama Lengkap" class="form-control bg-white border-left-0 border-md" :class="{ 'is-invalid': submitted && $v.user.nama.$error }">
            <div v-if="submitted && !$v.user.nama.required" class="invalid-feedback">Nama lengkap tidak bole kosong</div>
          </div>

          <!-- Email Address -->
          <div class="input-group col-lg-12 mb-4">
            <div class="input-group-prepend">
                            <span class="input-group-text bg-white px-4 border-md border-right-0">
                                <i class="fa fa-envelope text-muted"></i>
                            </span>
            </div>
            <input id="email" type="email" v-model="user.email" name="email" placeholder="Email Address" class="form-control bg-white border-left-0 border-md" :class="{ 'is-invalid': submitted && $v.user.email.$error }">
            <div v-if="submitted && $v.user.email.$error" class="invalid-feedback">
              <span v-if="!$v.user.email.required">Email is required</span>
              <span v-if="!$v.user.email.email">Email is invalid</span>
            </div>
          </div>
          <!-- Password -->
          <div class="input-group col-lg-6 mb-4">
            <div class="input-group-prepend">
                            <span class="input-group-text bg-white px-4 border-md border-right-0">
                                <i class="fa fa-lock text-muted"></i>
                            </span>
            </div>
            <input id="password" v-model="user.password" type="password" name="password" placeholder="Password" class="form-control bg-white border-left-0 border-md" :class="{ 'is-invalid': submitted && $v.user.password.$error }">
            <div v-if="submitted && $v.user.password.$error" class="invalid-feedback">
              <span v-if="!$v.user.password.required">Password is required</span>
              <span v-if="!$v.user.password.minLength">Password must be at least 6 characters</span>
            </div>
          </div>

          <!-- Password Confirmation -->
          <div class="input-group col-lg-6 mb-4">
            <div class="input-group-prepend">
                            <span class="input-group-text bg-white px-4 border-md border-right-0">
                                <i class="fa fa-lock text-muted"></i>
                            </span>
            </div>
            <input id="passwordConfirmation"  v-model="user.confirmPassword" type="password" name="passwordConfirmation" placeholder="Confirm Password" class="form-control bg-white border-left-0 border-md" :class="{ 'is-invalid': submitted && $v.user.confirmPassword.$error }">
            <div v-if="submitted && $v.user.confirmPassword.$error" class="invalid-feedback">
              <span v-if="!$v.user.confirmPassword.required">Confirm Password is required</span>
              <span v-else-if="!$v.user.confirmPassword.sameAsPassword">Passwords must match</span>
            </div>
          </div>

          <!-- Submit Button -->
          <div class="form-group col-lg-12 mx-auto mb-0">
            <button class="btn btn-primary btn-block py-2" type="submit">
              <span class="font-weight-bold">Daftar</span>
            </button>
          </div>


          <!-- Already Registered -->
          <div class="text-center w-100">
            <p class="text-muted font-weight-bold">Already Registered? <a href="/login" class="text-primary ml-2">Login</a></p>
          </div>

        </div>
      </form>
    </div>
  </div>
  </div>
</template>
<script>
import {required, email, minLength, sameAs, numeric} from "vuelidate/lib/validators";
import swal from 'sweetalert2'

export default {
  title: 'Daftar',
  name: "app",
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
      return this.$store.state.auth.status.loggedIn;
    }
  },
  mounted() {
    if (this.loggedIn) {
      this.$router.push('/login');
    }
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
          this.$store.dispatch('auth/register', this.user).then(
              data => {
                this.message = data.message;
                this.successful = true;
                this.$Progress.finish();
                this.$router.push('/login');
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
