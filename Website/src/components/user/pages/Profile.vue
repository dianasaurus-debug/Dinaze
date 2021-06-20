<template>
  <div>
    <!-- Modal -->
    <div class="page-content page-container" id="page-content">
      <div class="padding">
        <div class="row container d-flex justify-content-center">
          <div class="col-xl-12 col-md-12">
            <div class="card user-card-full">
              <div class="row m-l-0 m-r-0">
                <div class="col-sm-4 bg-c-lite-green user-profile">
                  <div class="card-block text-center text-white">
                      <div size="80" class="user">
                        <img :src="'https://wakaf.praditya.web.id/images/'+currentUser.data.foto" class="profile-img">
                        <a @click="$refs.FileInput.click()"><i class="fas fa-upload"></i></a>
                        <input ref="FileInput" type="file" style="display: none;" @change="onFileSelect" />
                      </div>
                    <h6 class="f-w-600">{{ currentUser.data.nama }}</h6>
                    <p>Wakif</p>
                  </div>
                </div>
                <div class="col-sm-8">
                  <div class="card-block">
                    <h6 class="m-b-20 p-b-5 b-b-default f-w-600">Information</h6>
                    <div class="row">
                      <div class="col-sm-6">
                        <p class="m-b-10 f-w-600">Email</p>
                        <h6 class="text-muted f-w-400">{{ currentUser.data.email }}</h6>
                      </div>
                      <div class="col-sm-6">
                        <p class="m-b-10 f-w-600">Phone</p>
                        <h6 class="text-muted f-w-400">{{ currentUser.data.nomor_ponsel }}</h6>
                      </div>
                    </div>
                    <!--                  <h6 class="m-b-20 m-t-40 p-b-5 b-b-default f-w-600">Projects</h6>-->
                    <div class="row">
                      <div class="col-sm-6">
                        <p class="m-b-10 f-w-600">Nomor KTP</p>
                        <h6 class="text-muted f-w-400">{{ currentUser.data.nik }}</h6>
                      </div>
                      <div class="col-sm-6">
                        <p class="m-b-10 f-w-600">Alamat</p>
                        <h6 class="text-muted f-w-400">{{ currentUser.data.alamat }}</h6>
                      </div>
                    </div>
                    <ul class="social-link list-unstyled m-t-40 m-b-10">
                      <li>
                        <button class="btn btn-success mr-2" @click.prevent="editProfileModal(currentUser.data)">Edit
                          Profile
                        </button>
                      </li>
                      <li>
                        <button class="btn btn-success" @click.prevent="editPasswordModal">Reset Password</button>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="modal fade" id="editProfile" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog"
         aria-labelledby="editProfile" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Edit Profile</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <form @submit.prevent="updateProfile">
            <div class="modal-body">
              <div class="row">

                <!-- Nama lengkap -->
                <div class="input-group col-lg-12 mb-4">
                  <div class="input-group-prepend">
                            <span class="input-group-text bg-white px-4 border-md border-right-0">
                                <i class="fa fa-user text-muted"></i>
                            </span>
                  </div>
                  <input id="nama" type="text" v-model="user.nama" name="nama" placeholder="Nama Lengkap"
                         class="form-control bg-white border-left-0 border-md"
                         :class="{ 'is-invalid': submitted && $v.user.nama.$error }">
                  <div v-if="submitted && !$v.user.nama.required" class="invalid-feedback">Nama lengkap tidak bole
                    kosong
                  </div>
                </div>

                <!-- Email Address -->
                <div class="input-group col-lg-12 mb-4">
                  <div class="input-group-prepend">
                            <span class="input-group-text bg-white px-4 border-md border-right-0">
                                <i class="fa fa-envelope text-muted"></i>
                            </span>
                  </div>
                  <input id="email" type="email" v-model="user.email" name="email" placeholder="Email Address"
                         class="form-control bg-white border-left-0 border-md"
                         :class="{ 'is-invalid': submitted && $v.user.email.$error }">
                  <div v-if="submitted && $v.user.email.$error" class="invalid-feedback">
                    <span v-if="!$v.user.email.required">Email is required</span>
                    <span v-if="!$v.user.email.email">Email is invalid</span>
                  </div>
                </div>

                <!-- Nomor Telepon -->
                <div class="input-group col-lg-6 mb-4">
                  <div class="input-group-prepend">
                            <span class="input-group-text bg-white px-4 border-md border-right-0">
                                <i class="fa fa-phone text-muted"></i>
                            </span>
                  </div>
                  <input id="nomor_ponsel" v-model="user.nomor_ponsel" type="number" name="nomor_ponsel"
                         placeholder="Nomor Telepon" class="form-control bg-white border-left-0 border-md"
                         :class="{ 'is-invalid': submitted && $v.user.nomor_ponsel.$error }">
                  <div v-if="submitted && $v.user.nomor_ponsel.$error" class="invalid-feedback">
                    <span v-if="!$v.user.nomor_ponsel.required">Nomor Telepon is required</span>
                    <span v-if="!$v.user.nomor_ponsel.numeric">Nomor Telepon must be numbers</span>
                  </div>
                </div>

                <!-- Nomor KTP -->
                <div class="input-group col-lg-6 mb-4">
                  <div class="input-group-prepend">
                            <span class="input-group-text bg-white px-4 border-md border-right-0">
                                <i class="fa fa-id-card text-muted"></i>
                            </span>
                  </div>
                  <input id="nik" v-model="user.nik" type="number" name="nik" placeholder="Nomor KTP"
                         class="form-control bg-white border-left-0 border-md"
                         :class="{ 'is-invalid': submitted && $v.user.nik.$error }">
                  <div v-if="submitted && $v.user.nik.$error" class="invalid-feedback">
                    <span v-if="!$v.user.nik.required">Nomor KTP is required</span>
                    <span v-if="!$v.user.nik.numeric">Nomor KTP must be numbers</span>
                    <span v-if="!$v.user.nik.minLength">NIK Tidak bisa kurang dari 16 karakter</span>
                    <span v-if="!$v.user.nik.maxLength">NIK Tidak bisa lebi dari 16 karakter</span>
                  </div>
                </div>

                <!-- Email Address -->
                <div class="form-group col-lg-12 mb-4">
                  <textarea id="alamat" v-model="user.alamat" name="alamat" placeholder="Alamat Lengkap"
                            class="form-control bg-white border-md"
                            :class="{ 'is-invalid': submitted && $v.user.alamat.$error }"></textarea>
                  <div v-if="submitted && $v.user.alamat.$error" class="invalid-feedback">
                    <span v-if="!$v.user.alamat.required">Alamat is required</span>
                  </div>
                </div>

              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
              <button type="submit" class="btn btn-primary">Update</button>
            </div>
          </form>
        </div>
      </div>
    </div>
    <div class="modal fade" id="resetPassword" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog"
         aria-labelledby="resetPassword" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="updatePasswordLabel">Reset Password</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <form @submit.prevent="updatePassword">
            <div class="modal-body">
              <div class="container">
                <div class="row">
                  <div class="col-12">
                    <div class="form-group">
                      <input type="password" class="form-control" v-model="reset_password.recentPassword"
                             placeholder="Recent Password"
                             :class="{ 'is-invalid': submitted && $v.reset_password.recentPassword.$error }"
                             id="recent_password">
                      <div v-if="submitted && $v.reset_password.recentPassword.$error" class="invalid-feedback">
                        <span v-if="!$v.reset_password.recentPassword.required">Password is required</span>
                        <span
                            v-if="!$v.reset_password.recentPassword.minLength">Password must be at least 6 characters</span>

                      </div>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-12">
                    <div class="form-group">
                      <input type="password" class="form-control" v-model="reset_password.password"
                             placeholder="New Password"
                             :class="{ 'is-invalid': submitted && $v.reset_password.password.$error }"
                             id="new_password">
                      <div v-if="submitted && $v.reset_password.password.$error" class="invalid-feedback">
                        <span v-if="!$v.reset_password.password.required">Password is required</span>
                        <span v-if="!$v.reset_password.password.minLength">Password must be at least 6 characters</span>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-12">
                    <div class="form-group">
                      <input type="password" class="form-control" v-model="reset_password.confirmPassword"
                             placeholder="Confirm New Password"
                             :class="{ 'is-invalid': submitted && $v.reset_password.confirmPassword.$error }"
                             id="confirm_password">
                      <div v-if="submitted && $v.reset_password.confirmPassword.$error" class="invalid-feedback">
                        <span v-if="!$v.reset_password.confirmPassword.required">Password is required</span>
                        <span v-else-if="!$v.reset_password.confirmPassword.sameAsPassword">Passwords must match</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
              <button type="submit" class="btn btn-primary">Update</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <div class="modal" id="modalfoto" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <VueCropper v-show="selectedFile" ref="cropper" :src="selectedFile" alt="Source Image"></VueCropper>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary" @click="saveImage()">Update Foto</button>
          </div>
        </div>
      </div>
    </div>

  </div>
</template>
<script>
import authHeader from '@/services/auth-header'
import axios from 'axios'
import $ from 'jquery'
import swal from 'sweetalert2'
import { email, minLength, required, sameAs, numeric, maxLength } from 'vuelidate/lib/validators'

const URL = 'https://wakaf.praditya.web.id/api/wakif-auth/'

import VueCropper from 'vue-cropperjs'
import 'cropperjs/dist/cropper.css'
export default {
  components: { VueCropper },
  title: 'Profil',
  data() {
    return {
      user: {
        email: '',
        nama: '',
        nomor_ponsel: '',
        nik: '',
        alamat: '',
        foto : '',
      },
      reset_password: {
        password: '',
        recentPassword: '',
        confirmPassword: ''
      },
      submitted: false,
      image_name: 'https://img.icons8.com/bubbles/100/000000/user.png',
      mime_type: '',
      cropedImage: '',
      autoCrop: false,
      selectedFile: '',
      image: '',
      dialog: false,
      files: '',
    }
  },
  computed: {
    currentUser() {
      return this.$store.state.auth.user.data
    }
  },
  validations: {
    user: {
      email: { required, email },
      nama: { required },
      nomor_ponsel: { required, numeric },
      nik: { required, minLength: minLength(16), maxLength: maxLength(16), numeric },
      alamat: { required }
    },
    reset_password: {
      recentPassword: {
        required,
        minLength: minLength(6)
      },
      password: {
        required,
        minLength: minLength(6)
      },
      confirmPassword: {
        required,
        sameAsPassword: sameAs('password')
      }
    }
  },
  created() {
    console.log(this.currentUser.data)
  },
  methods: {
    editPasswordModal() {
      this.submitted = false
      $('#resetPassword')
          .modal('show')
    },
    editProfileModal(user) {
      this.submitted = false
      this.user = user
      $('#editProfile')
          .modal('show')
    },
    updateProfile() {
      this.message = ''
      this.submitted = true
      this.$v.$touch()
      this.$Progress.start()
      // if (!this.$v.$invalid) {
        console.log('updated')
        this.$store.dispatch('auth/update', this.user).then(
            () => {
              $('#editProfile').modal('hide')
              this.$Progress.finish()
              swal.fire(
                  'Update Sukses!',
                  'Profil anda sudah diupdate',
                  'success'
              )
            },
            error => {
              this.$Progress.fail();
              swal.fire(
                  'Update Profil Gagal!',
                  'Pastikan anda mengisikan data dengan benar',
                  'error'
              )
            }
        );
      // } else {
      //   swal.fire(
      //       'Wrong Input!',
      //       'Pastikan anda mengisikan data dengan benar',
      //       'error'
      //   )
      // }
    },
    updatePassword() {
      console.log('update')
      this.message = ''
      this.submitted = true
      // this.$v.$touch();
      this.$Progress.start()
      // if (!this.$v.$invalid) {
      //   console.log('benar')
      axios.put(URL + 'change-password',
          {
            new_password: this.reset_password.password,
            old_password: this.reset_password.recentPassword
          }, {
            headers: authHeader(),
            data_wakif: this.currentUser.data
          }
      )
          .then(response => {
            $('#resetPassword')
                .modal('hide')
            this.$Progress.finish()
            swal.fire(
                'Update Sukses!',
                'Password anda sudah diupdate',
                'success'
            )

          })
          .catch(err => {
            this.$Progress.fail()
            swal.fire(
                'Update password Gagal!',
                'Pastikan anda mengisikan data dengan benar',
                'error'
            )
          })
    },
    saveImage() {
      this.cropedImage = this.$refs.cropper.getCroppedCanvas().toDataURL()
      this.$refs.cropper.getCroppedCanvas().toBlob((blob) => {
        const formData = new FormData()
        console.log('dis is blob : ' + blob);
        const file = new File([blob], "gambar",{ type: this.mime_type});
        console.log(file);
        formData.append('foto', file);
        this.$Progress.start();
        this.$store.dispatch('auth/updateFoto', formData)
            .then((response) => {
              $("#modalfoto").modal('hide');
              swal.fire(
                  'Sukses!',
                  'Profil foto terupdate',
                  'success'
              )
              this.$Progress.finish();
            })
            .catch(error => {
              swal.fire(
                  'Gagal!',
                  'Pastikan anda mengisikan data dengan benar',
                  'error'
              )
              this.$Progress.fail();
            })
      }, this.mime_type)
    },
    onFileSelect(e) {
      const file = e.target.files[0]
      this.mime_type = file.type
      console.log(this.mime_type)
      if (typeof FileReader === 'function') {
        $('#modalfoto').modal('show');
        const reader = new FileReader()
        reader.onload = (event) => {
          this.selectedFile = event.target.result
          this.$refs.cropper.replace(this.selectedFile)
        }
        reader.readAsDataURL(file)
      } else {
        alert('Sorry, FileReader API not supported')
      }
    },

  }
}
</script>
<style scoped>
.padding {
  padding: 3rem !important
}

.user-card-full {
  overflow: hidden
}

.card {
  border-radius: 5px;
  -webkit-box-shadow: 0 1px 20px 0 rgba(69, 90, 100, 0.08);
  box-shadow: 0 1px 20px 0 rgba(69, 90, 100, 0.08);
  border: none;
  margin-bottom: 30px
}

.m-r-0 {
  margin-right: 0px
}

.m-l-0 {
  margin-left: 0px
}

.user-card-full .user-profile {
  border-radius: 5px 0 0 5px
}

.bg-c-lite-green {
  background: -webkit-gradient(linear, left top, right top, from(#8ac4d0), to(#28527a));
  background: linear-gradient(to right, #28527a, #8ac4d0)
}

.user-profile {
  padding: 20px 0
}

.card-block {
  padding: 1.25rem
}

.m-b-25 {
  margin-bottom: 25px
}

.img-radius {
  border-radius: 5px
}

h6 {
  font-size: 14px
}

.card .card-block p {
  line-height: 25px
}

@media only screen and (min-width: 1400px) {
  p {
    font-size: 14px
  }
}

.card-block {
  padding: 1.25rem
}

.b-b-default {
  border-bottom: 1px solid #e0e0e0
}

.m-b-20 {
  margin-bottom: 20px
}

.p-b-5 {
  padding-bottom: 5px !important
}

.card .card-block p {
  line-height: 25px
}

.m-b-10 {
  margin-bottom: 10px
}

.text-muted {
  color: #919aa3 !important
}

.b-b-default {
  border-bottom: 1px solid #e0e0e0
}

.f-w-600 {
  font-weight: 600
}

.m-b-20 {
  margin-bottom: 20px
}

.m-t-40 {
  margin-top: 20px
}

.p-b-5 {
  padding-bottom: 5px !important
}

.m-b-10 {
  margin-bottom: 10px
}

.m-t-40 {
  margin-top: 20px
}

.user-card-full .social-link li {
  display: inline-block
}

.user-card-full .social-link li a {
  font-size: 20px;
  margin: 0 10px 0 0;
  -webkit-transition: all 0.3s ease-in-out;
  transition: all 0.3s ease-in-out
}
.user {
  width: 120px;
  height: 120px;
  border-radius: 100%;
  border: 3px solid #2e7d32;
  margin-left: 105px;
  margin-bottom : 30px;
}
.profile-img {
  height: 100%;
  width: 100%;
  border-radius: 50%;
}
.icon {
  position: absolute;
  bottom : 15px;
  right: 0;
  background: #e2e2e2;
  border-radius: 100%;
  width: 30px;
  height: 30px;
  line-height: 30px;
  vertical-align: middle;
  text-align: center;
  color: #0000ff;
  font-size: 14px;
  cursor: pointer;
}
.cropper-crop-box, .cropper-view-box {
  border-radius: 50%;
}

.cropper-view-box {
  box-shadow: 0 0 0 1px #39f;
  outline: 0;
}

</style>
