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
              <input id="nama" type="text" v-model="user.nama" name="nama" placeholder="Nama Lengkap"
                     class="form-control bg-white border-left-0 border-md"
                     :class="{ 'is-invalid': submitted && $v.user.nama.$error }" required>
              <div v-if="submitted && !$v.user.nama.required" class="invalid-feedback">Nama lengkap tidak bole kosong
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
                     :class="{ 'is-invalid': submitted && $v.user.email.$error }" required>
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
              <input id="password" v-model="user.password" type="password" name="password" placeholder="Password"
                     class="form-control bg-white border-left-0 border-md"
                     :class="{ 'is-invalid': submitted && $v.user.password.$error }" required>
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
              <input id="passwordConfirmation" v-model="user.confirmPassword" type="password"
                     name="passwordConfirmation" placeholder="Confirm Password"
                     class="form-control bg-white border-left-0 border-md"
                     :class="{ 'is-invalid': submitted && $v.user.confirmPassword.$error }" required>
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
            <!-- Submit Button -->
            <div class="form-group col-lg-12 mx-auto mb-0">
              <button class="btn btn-primary btn-block py-2 mt-2" type="button" @click="socialLogin">
                <span class="font-weight-bold">Login/Register dengan Google</span>
              </button>
            </div>


            <!-- Already Registered -->
            <div class="text-center w-100">
              <p class="text-muted font-weight-bold">Already Registered? <a href="/login" class="text-primary ml-2">Login</a>
              </p>
            </div>

          </div>
        </form>
      </div>
    </div>
    <div class="modal" tabindex="-1" id="registerModal">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Register</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <form @submit.prevent="submitRegisterGmail">
            <div class="modal-body">
              <div class="form-group">
                <label for="exampleInputEmail1">Email address</label>
                <input type="email" class="form-control" v-model="userData.email" id="exampleInputEmail1"
                       aria-describedby="emailHelp" required>
                <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone
                  else.</small>
              </div>
              <div class="form-group">
                <label for="exampleInputPassword1">Nama</label>
                <input type="text" class="form-control" v-model="userData.nama" id="exampleInputPassword1" required>
              </div>
              <div class="form-group">
                <label for="exampleInputPassword1">Password</label>
                <input type="password" class="form-control" v-model="userData.password" id="exampleInputPassword1"
                       required>
              </div>

            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
              <button type="submit" class="btn btn-primary">Save changes</button>
            </div>
          </form>

        </div>
      </div>
    </div>
    <div class="modal" tabindex="-1" id="cameraModal">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Silahkan Senyum untuk Memvalidasi diri Anda</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <div class="camera-box" id="camera_place">
              <div class="camera-shutter"></div>
              <video class="embed-responsive embed-responsive-21by9" id="video" ref="camera" autoplay muted></video>
              <div ref="canvasContainer" id="canvas-container"></div>
            </div>
          </div>
          <div class="modal-footer">
            Anda dapat tersenyum lebar maupun tipis agar kami mengetahui bahwa Anda bukan robot
          </div>

        </div>
      </div>
    </div>
  </div>
</template>
<script>
import {required, email, minLength, sameAs, numeric} from "vuelidate/lib/validators";
import swal from 'sweetalert2'
import firebase from "firebase";
import $ from "jquery";
import * as faceapi from "face-api.js";

const WEIGHTS_URL = 'http://localhost:4000/models'

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
      message: '',
      googleId: '',
      userData: {
        googleId: '',
        nama: '',
        email: '',
        password: ''
      },
      allowedRegister: false
    };
  },
  computed: {
    loggedIn() {
      return this.$store.state.auth.status.loggedIn;
    },
  },
  async beforeMount() {
    await faceapi.loadTinyFaceDetectorModel(WEIGHTS_URL);
    await faceapi.loadFaceLandmarkTinyModel(WEIGHTS_URL);
    await faceapi.loadFaceLandmarkModel(WEIGHTS_URL);
    await faceapi.loadFaceRecognitionModel(WEIGHTS_URL);
    await faceapi.loadFaceExpressionModel(WEIGHTS_URL);
    await faceapi.loadFaceDetectionModel(WEIGHTS_URL);
  },
  mounted() {
    if (this.loggedIn) {
      this.$router.push('/login');
    }
  },

  validations: {
    user: {
      nama: {required},
      email: {required, email},
      password: {required, minLength: minLength(6)},
      confirmPassword: {required, sameAsPassword: sameAs('password')}
    }
  },
  methods: {
    createCameraElement() {
      $('#cameraModal').modal('show')
      const constraints = (window.constraints = {
        audio: false,
        video: true
      });
      navigator.mediaDevices
          .getUserMedia(constraints)
          .then(stream => {
            this.isLoading = false;
            this.$refs.camera.srcObject = stream;
            const video = this.$refs.camera;
            // const canvas = faceapi.createCanvasFromMedia(video)
            // document.body.append(canvas)
            // const displaySize = { width: video.width, height: video.height }
            // faceapi.matchDimensions(canvas, displaySize)
            const options = new faceapi.TinyFaceDetectorOptions({
              inputSize: 128,
              scoreThreshold: 0.3
            });
            setInterval(async () => {
              const detections = await faceapi.detectAllFaces(video, options)
                  .withFaceLandmarks()
                  .withFaceExpressions()
              if (detections[0].expressions.happy > 0.9) {
                this.allowedRegister = true;
              } else {
                this.allowedRegister = false;
              }
            }, 100)
          })
          .catch(error => {
            alert("May the browser didn't support or there is some errors.");
          });
    },
    socialLogin() {
      let provider = new firebase.auth.GoogleAuthProvider();
      firebase
          .auth()
          .signInWithPopup(provider)
          .then((result) => {
            let user = result.user;
            this.userData.nama = user.displayName;
            this.userData.email = user.email;
            this.userData.googleId = user.uid;

            this.$store.dispatch('auth/loginGmail', this.userData.googleId).then(
                () => {
                  this.loading = false;
                  this.$router.push('/home');
                },
                error => {
                  $('#registerModal').modal('show')
                }
            );
          })
          .catch((err) => {
            swal.fire(
                'Login Gagal!',
                'Pastikan anda mengisikan data dengan benar',
                'error'
            )
          });
    },
    submitRegisterGmail() {
      $('#cameraModal').modal('show')
      const constraints = (window.constraints = {
        audio: false,
        video: true
      });
      navigator.mediaDevices
          .getUserMedia(constraints)
          .then(stream => {
            this.isLoading = false;
            this.$refs.camera.srcObject = stream;
            const video = this.$refs.camera;
            // const canvas = faceapi.createCanvasFromMedia(video)
            // document.body.append(canvas)
            // const displaySize = { width: video.width, height: video.height }
            // faceapi.matchDimensions(canvas, displaySize)
            const options = new faceapi.TinyFaceDetectorOptions({
              inputSize: 128,
              scoreThreshold: 0.3
            });
            var i = 0;
            var timer = setInterval(async () => {
              const detections = await faceapi.detectAllFaces(video, options)
                  .withFaceLandmarks()
                  .withFaceExpressions()
              if (detections[0].expressions.happy > 0.9) {
                i++;
                $('#cameraModal').modal('hide')
                clearInterval(timer);
                if(i==1){
                  this.$store.dispatch('auth/registerGmail', this.userData).then(
                      data => {
                        this.message = data.message;
                        this.successful = true;
                        $('#registerModal').modal('hide')
                        this.$router.push('/home');
                      },
                      error => {
                        swal.fire(
                            'Register Gagal!',
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
              }
            }, 100)
          })
          .catch(error => {
            swal.fire(
                'Validasi Gagal!',
                'Pastikan anda mengisikan data dengan benar',
                'error'
            )
          });
    },
    handleRegister() {
        $('#cameraModal').modal('show')
        const constraints = (window.constraints = {
          audio: false,
          video: true
        });
        navigator.mediaDevices
            .getUserMedia(constraints)
            .then(stream => {
              this.isLoading = false;
              this.$refs.camera.srcObject = stream;
              const video = this.$refs.camera;
              // const canvas = faceapi.createCanvasFromMedia(video)
              // document.body.append(canvas)
              // const displaySize = { width: video.width, height: video.height }
              // faceapi.matchDimensions(canvas, displaySize)
              const options = new faceapi.TinyFaceDetectorOptions({
                inputSize: 128,
                scoreThreshold: 0.3
              });
              var i = 0;
              var timer = setInterval(async () => {
                const detections = await faceapi.detectAllFaces(video, options)
                    .withFaceLandmarks()
                    .withFaceExpressions()
                if (detections[0].expressions.happy > 0.9) {
                  i++;
                  $('#cameraModal').modal('hide')
                  clearInterval(timer);
                  if(i==1){
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
                            swal.fire(
                                'Registrasi Berhasil!',
                                'Silahkan login',
                                'success'
                            )
                            this.$router.push('/login');
                          },
                          error => {
                            this.$Progress.fail();
                            swal.fire(
                                'Registrasi Gagal!',
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

                  }
                }
              }, 100)
            })
            .catch(error => {
              swal.fire(
                  'Validasi Gagal!',
                  'Pastikan anda mengisikan data dengan benar',
                  'error'
              )
            });
      }

  },
};
</script>
