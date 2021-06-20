<template>
  <section id="cover" class="min-vh-100">
    <div id="cover-caption">
      <div class="container">
        <div class="row text-white">
          <div class="col-xl-5 col-lg-6 col-md-8 col-sm-10 mx-auto text-center form p-4">
            <div v-if="state==0">
              <img class="img-thumbnail py-2 mb-3" style="max-width: 150px" src="../../../assets/images/padlock.png">
              <h3 class="py-2 text-truncate">Masukkan E-Mail</h3>
              <div class="px-2">
                <form @submit.prevent="submitEmail" class="justify-content-center" >
                  <div class="form-group">
                    <label class="sr-only">Email</label>
                    <input type="text" class="form-control" v-model="requestEmail" placeholder="jane.doe@example.com">
                  </div>
                  <button type="submit" class="btn btn-primary btn-lg">Kirim</button>
                </form>
                <h6 class="py-2">Kami akan mengirimkan 6 digit kode ke E-Mail Anda untuk akses reset password</h6>
              </div>
            </div>
            <div v-else>
              <div class="px-2">
                <form @submit.prevent="submitPassword" class="justify-content-center" >
                  <h3 class="py-2 text-truncate">Perbaharui Password</h3>
                  <div class="form-group">
                    <label class="sr-only">6 Digit Kode</label>
                    <input type="text" class="form-control" v-model="password_reset.code" placeholder="Ex : 871918">
                  </div>
                  <div class="form-group">
                    <label class="sr-only">Password Baru</label>
                    <input type="password" class="form-control" v-model="password_reset.password" placeholder="******">
                  </div>
                  <div class="form-group">
                    <label class="sr-only">Konfirmasi Password Baru</label>
                    <input type="password" class="form-control" v-model="password_reset.confirmPassword" placeholder="******">
                  </div>
                  <button type="submit" class="btn btn-primary btn-lg">Atur Ulang</button>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
<script>
import authHeader from '@/services/auth-header-admin.service'
import axios from 'axios'
import $ from 'jquery'
import swal from 'sweetalert2'
const URL = 'https://wakaf.praditya.web.id'

export default {
  title: 'Atur Ulang Sandi',
  data() {
    return {
      requestEmail: '',
      state : 0,
      password_reset : {
        code : '',
        password : '',
        confirmPassword : ''
      }
    }
  },
  methods: {
    submitPassword(){
      const formData = new FormData()
      this.$Progress.start()
      axios({method : 'post', url : URL + '/api/wakif-auth/reset-password', data: { token : this.password_reset.code, password : this.password_reset.password, email : this.requestEmail}})
          .then((res) => {
                console.log(res)
                this.state=1;
                this.$emit('AfterCreated')
                $('#addNew')
                    .modal('hide')
                swal.fire(
                    'Sukses!',
                    'Password diupdate!',
                    'success'
                )
                this.$Progress.finish()
                this.$router.push('/login');
              }
          )
          .catch(err => {
            console.log(err)
            swal.fire(
                'Gagal!',
                'Pastikan anda mengisikan data dengan benar',
                'error'
            )
            this.$Progress.fail()
          })
    },
    submitEmail() {
      const formData = new FormData()
      this.$Progress.start()
      axios({method : 'post', url : URL + '/api/wakif-auth/reset-password/request', data: { email : this.requestEmail}})
          .then((res) => {
                console.log(res)
                this.state=1;
                this.$emit('AfterCreated')
                $('#addNew')
                    .modal('hide')
                swal.fire(
                    'Sukses!',
                    'Silahkan cek E-Mail Anda',
                    'success'
                )
                this.$Progress.finish()
              }
          )
          .catch(err => {
            console.log(err)
            swal.fire(
                'Gagal!',
                'Pastikan anda mengisikan data dengan benar',
                'error'
            )
            this.$Progress.fail()
          })
    }
  }
}
</script>
<style scoped>
#cover {
  height: 70%;
  text-align: center;
  display: flex;
  align-items: center;
  position: relative;
}

#cover-caption {
  width: 100%;
  position: relative;
  z-index: 1;
}

/* only used for background overlay not needed for centering */
form:before {
  content: '';
  height: 100%;
  left: 0;
  position: absolute;
  top: 0;
  width: 100%;
  background-color: rgba(0, 0, 0, 0.3);
  z-index: -1;
  border-radius: 10px;
}

</style>
