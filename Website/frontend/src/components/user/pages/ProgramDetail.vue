<template>
  <div>
    <div class="container">
      <div class="row mt-3">
        <div class="col-12">
          <!-- Main jumbotron for a primary marketing message or call to action -->
          <div class="jumbotron bg-overlay"  :style=bgStyle>
            <div class="container">
              <!--Card content-->
              <div class="mb-3">
            <span class="badge badge-pill badge-success mr-2">
              <i class="fas fa-graduation-cap" v-show="currentProgram.kategori_id == 1"></i>
              <i class="fas fa-heartbeat" v-show="currentProgram.kategori_id == 2"></i>
              <i class="fas fa-mosque" v-show="currentProgram.kategori_id == 3"></i>
              <i class="fas fa-user" v-show="currentProgram.kategori_id == 4"></i>
              <i class="fas fa-atlas" v-show="currentProgram.kategori_id == 5"></i>
              {{ currentProgram.kategori.nama }}
            </span>
                <!--              <span v-if="formatDate(currentProgram.createdAt)<=formatDate(currentProgram.deadline)" class="badge badge-pill badge-primary">Ongoing</span>-->
                <!--              <span v-if="formatDate(currentProgram.createdAt)>formatDate(currentProgram.deadline)" class="badge badge-pill badge-success">Selesai</span>-->
              </div>
              <h2>{{ currentProgram.judul }}</h2>
              <h6 class="card-text text-justify text-white-50 mt-2 mb-2">
                <span class="font-weight-bold text-white">Wakaf Abadi Terkumpul </span> : {{ currentProgram.wakaf_abadi_terkumpul | filterMoney }} <br>
                <span class="font-weight-bold text-white">Wakaf Berjangka Terkumpul </span> : {{ currentProgram.wakaf_berjangka_terkumpul | filterMoney }}
              </h6>
              <!--            <div style="max-width: 1000px">-->
              <!--              <div class="progress" style="height:20px;">-->
              <!--                <div class="progress-bar" role="progressbar"-->
              <!--                     :style="progressStyle(currentProgram.terkumpul,currentProgram.target)">-->
              <!--                  {{ currentProgram.terkumpul | filterMoney }}-->
              <!--                </div>-->
              <!--              </div>-->
              <!--              <h6 class="float-right">Dari  <b>{{ currentProgram.target | filterMoney }}</b></h6>-->
              <!--            </div>-->
              <!--            <p class="text-left mt-5"><span class="mr-2"><i class="fa fa-calendar"></i></span>{{formatDate(currentProgram.created_at)}} - {{formatDate(currentProgram.deadline)}}</p>-->
              <!--            <p class="text-left"><span class="mr-2"><i class="fa fa-sitemap"></i></span>{{ currentProgram.alamat}}</p>-->
              <p><a class="btn btn-primary btn-lg mt-2" href="#" role="button" @click="berwakaf(currentProgram)">Berwakaf</a></p>
            </div>
          </div>

        </div>
      </div>
      <div class="row">
        <div class="col-12">
          <section id="tabs" class="project-tab">
            <div class="container">
              <div class="row">
                <div class="col-md-12">
                  <nav>
                    <div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
                      <a class="nav-item nav-link active" id="nav-deskripsi-tab" data-toggle="tab" href="#nav-deskripsi" role="tab"
                         aria-controls="nav-deskripsi" aria-selected="true">Deskripsi</a>
                      <!--                    <a class="nav-item nav-link" id="nav-wakaf-tab" data-toggle="tab" href="#nav-wakaf" role="tab"-->
                      <!--                       aria-controls="nav-wakaf" aria-selected="false">Daftar Wakaf</a>-->
                      <a class="nav-item nav-link" id="nav-laporan-tab" data-toggle="tab" href="#nav-laporan" role="tab"
                         aria-controls="nav-laporan" aria-selected="false">Laporan</a>
                    </div>
                  </nav>
                  <div class="tab-content" id="nav-tabContent">
                    <div class="tab-pane fade show active" id="nav-deskripsi" role="tabpanel" aria-labelledby="nav-deskripsi-tab">
                      <p class="text-left mt-2" >
                        {{currentProgram.deskripsi}}
                      </p>
                    </div>
                    <div class="tab-pane fade" id="nav-laporan" role="tabpanel" aria-labelledby="nav-laporan-tab">
                      <div class="container mt-3">
                        <div class="row">
                          <div class="col-12">
                            <section class="content">
                              <div class="container-fluid">
                                <!-- Timelime example  -->
                                <div class="row">
                                  <div class="col-md-12">
                                    <!-- The time line -->
                                    <div class="timeline" v-for="laporan in laporannew" v-bind:key="laporan.id">
                                      <!-- timeline time label -->
                                      <div class="time-label">
                                        <span class="bg-red">{{formatDate(laporan.createdAt)}}</span>
                                      </div>
                                      <!-- /.timeline-label -->
                                      <!-- timeline item -->
                                      <div>
                                        <div class="timeline-item">
                                          <div class="timeline-body">
                                            <div class="container">
                                              <div class="row">
                                                <div class="col-4">
                                                  <img class="img-thumbnail" :src="'https://wakaf.praditya.web.id/images/'+laporan.gambar"
                                                       alt="Card image cap">
                                                </div>
                                                <div class="col-8">
                                                  {{laporan.deskripsi}}
                                                </div>
                                              </div>
                                            </div>
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                  <!-- /.col -->
                                </div>
                              </div>
                              <!-- /.timeline -->

                            </section>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section>
        </div>
      </div>


      <!-- Modal -->
    </div>
    <!-- Modal -->
    <div class="modal fade" id="berWakaf" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog"
         aria-labelledby="berWakaf" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLongTitle">Berwakaf</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <form @submit.prevent="jenisWakafAbadi ? berwakafAbadi() : berWakafBerjangka()">
            <div class="modal-body">
              <div class="card" style="max-width: 700px">
                <div class="card-horizontal">
                  <div class="img-square-wrapper">
                    <img class="" :src="'https://wakaf.praditya.web.id/images/'+selectedProgram.gambar" width="200px"
                         alt="Card image cap">
                  </div>
                  <div class="card-body">
                    <h4 class="card-title"><b>{{ selectedProgram.judul }}</b></h4>
                  </div>
                </div>
              </div>
              <h5 class="font-weight-bold">Jenis Wakaf Uang</h5>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1"
                       v-bind:value="true"
                       v-model="jenisWakafAbadi">
                <label class="form-check-label" for="inlineRadio1">Wakaf Abadi</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2"
                       v-bind:value="false" v-model="jenisWakafAbadi">
                <label class="form-check-label" for="inlineRadio2">Wakaf Berjangka</label>
              </div>
              <div class="form-group">
                <h5 class="font-weight-bold">Wakaf Untuk</h5>
                <div class="form-check form-check-inline">
                  <input class="form-check-input" type="radio" name="dirisendiri" v-model="dirisendiri"
                         id="dirisendiriradio" :value="true">
                  <label class="form-check-label" for="dirisendiriradio">Diri Sendiri</label>
                </div>
                <div class="form-check form-check-inline">
                  <input class="form-check-input" type="radio" name="oranglain" v-model="dirisendiri"
                         id="oranglainradio" :value="false">
                  <label class="form-check-label" for="oranglainradio">Orang Lain</label>
                </div>
              </div>
              <div class="row mb-2" v-if="jenisWakafAbadi==true">
                <div class="col-4 input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text" style="color : cornflowerblue; font-weight: bold">Rp.</span>
                  </div>
                  <money v-model="pembayaranAbadi.nominal"
                         class="form-control"
                         :class="{ 'is-invalid': submitted && $v.pembayaranAbadi.nominal.$error }">
                    >
                  </money>
                  <div v-if="submitted && $v.pembayaranAbadi.nominal.$error" class="invalid-feedback">
                    <span v-if="!$v.pembayaranAbadi.nominal.required">Nominal is required</span>
                  </div>
                </div>
                <div class="col-8 input-group" v-if="dirisendiri==false">
                  <div class="input-group-prepend">
                    <span class="input-group-text" style="color : cornflowerblue; font-weight: bold"><i
                        class="fa fa-user"></i></span>
                  </div>
                  <input name="atas_nama" class="form-control" placeholder="Atas Nama" type="text"
                         v-model="pembayaranAbadi.atas_nama"
                         :class="{ 'is-invalid': submitted && $v.pembayaranAbadi.atas_nama.$error }">
                  <div v-if="submitted && $v.pembayaranAbadi.atas_nama.$error" class="invalid-feedback">
                    <span v-if="!$v.pembayaranAbadi.atas_nama.required">Atas Nama is required</span>
                  </div>
                </div>
              </div>
              <div v-if="jenisWakafAbadi==false">
                <div class="row mb-3">
                  <div class="col-4 input-group">
                    <div class="input-group-prepend">
                      <span class="input-group-text" style="color : cornflowerblue; font-weight: bold">Rp.</span>
                    </div>
                    <money v-model="pembayaranBerjangka.nominal"
                           class="form-control"
                           :class="{ 'is-invalid': submitted && $v.pembayaranBerjangka.nominal.$error }">
                      >
                    </money>
                    <div v-if="submitted && $v.pembayaranBerjangka.nominal.$error" class="invalid-feedback">
                      <span v-if="!$v.pembayaranBerjangka.nominal.required">Nominal is required</span>
                    </div>
                  </div>
                  <div class="col-8 input-group" v-if="dirisendiri==false">
                    <div class="input-group-prepend">
                      <span class="input-group-text" style="color : cornflowerblue; font-weight: bold"><i
                          class="fa fa-user"></i></span>
                    </div>
                    <input name="target" class="form-control" placeholder="Atas Nama" type="text"
                           v-model="pembayaranBerjangka.atas_nama"
                           :class="{ 'is-invalid': submitted && $v.pembayaranBerjangka.atas_nama.$error }">
                    <div v-if="submitted && $v.pembayaranBerjangka.atas_nama.$error" class="invalid-feedback">
                      <span v-if="!$v.pembayaranBerjangka.atas_nama.required">Atas Nama is required</span>
                    </div>
                  </div>
                </div>
                <div class="form-group mb-2">
                  <label>Keterangan Pengembalian Uang</label>
                  <select class="form-control" v-model="pembayaranBerjangka.nama_bank"
                          :class="{ 'is-invalid': submitted && $v.pembayaranBerjangka.nama_bank.$error }">
                    <option value="" disabled hidden>Nama Bank</option>
                    <option v-for="bank in daftar_bank" v-bind:key="bank" :value="bank">{{ bank }}</option>
                  </select>
                  <div v-if="submitted && $v.pembayaranBerjangka.nama_bank.$error" class="invalid-feedback">
                    <span v-if="!$v.pembayaranBerjangka.nama_bank.required">Nama Bank is required</span>
                  </div>
                </div> <!-- form-group// -->
                <div class="row mb-2">
                  <div class="col-4 input-group">
                    <input name="target" class="form-control" placeholder="Rekening Pengembalian" type="number"
                           v-model="pembayaranBerjangka.nomor_rekening"
                           :class="{ 'is-invalid': submitted && $v.pembayaranBerjangka.nomor_rekening.$error }">
                    <div v-if="submitted && $v.pembayaranBerjangka.nomor_rekening.$error" class="invalid-feedback">
                      <span v-if="!$v.pembayaranBerjangka.nomor_rekening.required">Rekening is required</span>
                    </div>
                  </div>
                  <div class="col-8 input-group">
                    <input name="target" class="form-control" placeholder="Atas Nama" type="text"
                           v-model="pembayaranBerjangka.nama_pemilik_rekening"
                           :class="{ 'is-invalid': submitted && $v.pembayaranBerjangka.nama_pemilik_rekening.$error }">
                    <div v-if="submitted && $v.pembayaranBerjangka.nama_pemilik_rekening.$error"
                         class="invalid-feedback">
                      <span v-if="!$v.pembayaranBerjangka.nama_pemilik_rekening.required">Atas Nama is required</span>
                    </div>
                  </div>
                </div>
                <div class="form-group mb-2">
                  <select class="form-control" v-model="pembayaranBerjangka.jangka_waktu"
                          :class="{ 'is-invalid': submitted && $v.pembayaranBerjangka.jangka_waktu.$error }">
                    <option value="" disabled hidden>Jangka Waktu Wakaf</option>
                    <option value="1">
                      1 Tahun
                    </option>
                    <option value="2">
                      2 Tahun
                    </option>
                    <option value="3">
                      3 Tahun
                    </option>
                    <option value="4">
                      4 Tahun
                    </option>
                    <option value="5">
                      5 Tahun
                    </option>
                  </select>
                  <div v-if="submitted && $v.pembayaranBerjangka.jangka_waktu.$error" class="invalid-feedback">
                    <span v-if="!$v.pembayaranBerjangka.jangka_waktu.required">Jangka Waktu Wakaf is required</span>
                  </div>

                </div> <!-- form-group// -->
              </div>
              <div class="row mt-2">
                <h5 class="mb-2">Metode Pembayaran</h5>
                <div class="col-12">
                  <div class="form-group">
                    <table style="border : 0px;padding : 4px">
                      <tr>
                        <td>
                          <button @click.prevent="pickPayment('bca', 'bank');" :class="getActiveClass('bca')"
                                  style="display: block;"><img src="@/assets/images/logo_bank_bca.png" height="20px">
                          </button>
                        </td>
                        <td>
                          <button @click.prevent="pickPayment('bri', 'bank')" :class="getActiveClass('bri')"
                                  style="display: block;"><img src="@/assets/images/logo-bri.png" height="20px">
                          </button>
                        </td>
                        <td>
                          <button @click.prevent="pickPayment('bni', 'bank')" :class="getActiveClass('bni')"
                                  style="display: block;"><img src="@/assets/images/logo-bni.png" height="20px">
                          </button>
                        </td>
                        <td>
                          <button @click.prevent="pickPayment('alfamart', 'cstore')" :class="getActiveClass('alfamart')"
                                  style="display: block;"><img src="@/assets/images/alfamart.png" height="20px">
                          </button>
                        </td>
                        <td>
                          <button @click.prevent="pickPayment('indomaret', 'cstore')"
                                  :class="getActiveClass('indomaret')" style="display: block;"><img
                              src="@/assets/images/indomaret.png" height="20px"></button>
                        </td>
                        <td>
                          <button @click.prevent="pickPayment('gopay', 'qris')" :class="getActiveClass('gopay')"
                                  style="display: block;"><img src="@/assets/images/qris.png" height="20px"></button>
                        </td>
                      </tr>
                    </table>
                  </div>
                </div>
              </div>
            </div>

            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
              <button type="submit" class="btn btn-primary">Bayar</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import 'viewerjs/dist/viewer.css'
import authHeader from '@/services/auth-header'
import axios from 'axios'
import $ from 'jquery'
import moment from "moment";
const URL = 'https://wakaf.praditya.web.id'
import { required } from 'vuelidate/lib/validators'
import swal from 'sweetalert2'
import { saveAs } from 'file-saver'
export default {
  validations: {
    pembayaranAbadi: {
      nominal: { required },
      atas_nama: { required }
    },
    pembayaranBerjangka: {
      nominal: { required },
      atas_nama: { required },
      jangka_waktu: { required },
      nama_bank: { required },
      nomor_rekening: { required },
      nama_pemilik_rekening: { required }
    }
  },
  title: 'Detail Program Wakaf',
  created(){
    this.getLaporan();
    console.log(this.currentProgram)
  },
  data() {
    return {
      isAbadi : 1,
      columns: [
        {label: 'Nama Wakif', field: 'nama_wakif'},
        {label: 'Nominal', field: 'nominal'},
        {
          label: 'Dibayar Pada', field: 'created_at',
          type: 'date',
          dateInputFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
          dateOutputFormat: 'dd/MM/yyyy'
        },
      ],
      rows : [],
      page: 1,
      per_page: 5,
      displayNow : 0,
      laporannew : [],
      today : moment(),
      jenisWakafAbadi: true,
      jenis_pembayaran: '',
      metode_pembayaran: '',
      dirisendiri: true,
      katakunci : '',
      selectedProgram: {},
      pembayaranAbadi: {
        nominal: '',
        atas_nama: '',
        UserId: '',
        ProgramId: ''
      },
      pembayaranBerjangka: {
        nominal: '',
        atas_nama: '',
        UserId: '',
        ProgramId: '',
        nomor_rekening: '',
        nama_pemilik_rekening: '',
        jangka_waktu: '',
        nama_bank: ''
      },
      daftar_bank: ['Bank Mandiri', 'Bank Bukopin', 'Bank Danamon', 'Bank Mega', 'Bank CIMB Niaga', 'Bank BNI', 'Bank Permata', 'Bank BRI',
        'Bank Sinarmas', 'Bank Jatim', 'Bank Maybank'],
      submitted: false
    }
  },

  computed:{
    currentUser() {
      return this.$store.state.auth.user.data;
    },
    currentProgram() {
      return this.$store.state.currentProgram.program;
    },
    bgStyle(){
      let bgImg = 'https://wakaf.praditya.web.id/images/'+this.currentProgram.gambar;
      return {

        "background": 'linear-gradient(rgba(0,0,0,.7), rgba(0,0,0,.7)), url('+bgImg+')'
      }
    },
    allWakafAbadi(){
      let all = [];
      this.currentProgram.wakafabadi.forEach(abadi=> {
        if(abadi.status_pembayaran=='success')
          all.push(abadi)
      })

      return all;
    },
    allWakafBerjangka(){
      let all = [];
      this.currentProgram.wakafberjangka.forEach(berjangka=> {
        if(berjangka.status_pembayaran=='success')
          all.push(berjangka)
      })
      return all;
    }
  },
  methods : {
    getActiveClass(id) {
      if (id === this.metode_pembayaran) {
        return 'btn btn-outline-info active'
      } else {
        return 'btn btn-outline-info'
      }
    },
    pickPayment(metode, jenis) {
      this.jenis_pembayaran = jenis
      this.metode_pembayaran = metode
    },
    berwakaf(program) {
      this.selectedProgram = program
      $('#berWakaf').modal('show')
    },
    berwakafAbadi() {
      this.submitted = true
      // const formData = new FormData();
      // this.$v.$touch();
      this.pembayaranAbadi.UserId = this.currentUser.data.id
      this.pembayaranAbadi.ProgramId = this.selectedProgram.id
      if (this.pembayaranAbadi.atas_nama == '') {
        this.pembayaranAbadi.atas_nama = this.currentUser.data.nama
      }
      // if (!this.$v.$invalid) {
      console.log(this.pembayaranAbadi)
      this.$Progress.start()
      axios.post(URL + '/api/wakaf-abadi/', {
        nominal: this.pembayaranAbadi.nominal,
        nama_wakif: this.pembayaranAbadi.atas_nama,
        metode_pembayaran: this.metode_pembayaran,
        program_wakaf_id: this.pembayaranAbadi.ProgramId,
        wakif_id: this.pembayaranAbadi.UserId,
        jenis_pembayaran: this.jenis_pembayaran
      }, { headers: authHeader() })
          .then((res) => {
                this.$emit('AfterCreated')
                console.log(res)
                $('#berWakaf')
                    .modal('hide')
                if (this.jenis_pembayaran === 'qris') {
                  swal.fire(
                      {
                        title: `<strong>Pindai untuk membayar</strong>`,
                        imageUrl: `${res.data.data.kode_pembayaran}`,
                        html: `<p><br><button class="download btn btn-success">Download QR Code</button><br>Atas Nama : ${this.currentUser.data.nama}
                       <br>Nominal : ${res.data.data.nominal}<br>Status Pembayaran : ${res.data.data.status_pembayaran}<br>
                       Metode Pembayaran : ${res.data.data.metode_pembayaran}
                       </p>`,
                        showCloseButton: true,
                        willOpen: () => {
                          const download = document.querySelector('.download')

                          download.addEventListener('click', () => {
                            saveAs(`${res.data.data.kode_pembayaran}`, 'QR.jpg')
                          })
                        }
                      }
                  )
                } else if (this.jenis_pembayaran === 'bank') {
                  swal.fire(
                      {
                        title: `<strong>Transaksi Berhasil</strong>`,
                        html: `<p>Atas Nama : ${this.currentUser.data.nama}
                       <br>Nominal : ${res.data.data.nominal}<br>Status Pembayaran : ${res.data.data.status_pembayaran}<br>
                       Metode Pembayaran : ${res.data.data.metode_pembayaran}<br> Virtual Account : ${res.data.data.kode_pembayaran}
                       </p>`,
                        showCloseButton: true
                      }
                  )
                } else if (this.jenis_pembayaran === 'cstore') {
                  swal.fire(
                      {
                        title: `<strong>Cstore Payment</strong>`,
                        html: `<p>Atas Nama : ${this.currentUser.data.nama}
                       <br>Nominal : ${res.data.data.nominal}<br>Status Pembayaran : ${res.data.data.status_pembayaran}<br>
                       Metode Pembayaran : ${res.data.data.metode_pembayaran}<br> Kode Pembayaran : ${res.data.data.kode_pembayaran}
                       </p>`,
                        showCloseButton: true
                      }
                  )
                }

                this.$emit('AfterCreated')
                this.$Progress.finish()
                this.$router.push('/home/wakaf/abadi')
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
      // }
    },
    berWakafBerjangka() {
      this.submitted = true
      // const formData = new FormData();
      // this.$v.$touch();
      this.pembayaranBerjangka.UserId = this.currentUser.data.id
      this.pembayaranBerjangka.ProgramId = this.selectedProgram.id
      if (this.pembayaranBerjangka.atas_nama == '') {
        this.pembayaranBerjangka.atas_nama = this.currentUser.data.nama
      }
      // if (!this.$v.$invalid) {
      this.$Progress.start()
      axios.post(URL + '/api/wakaf-berjangka/', {
        nominal: this.pembayaranBerjangka.nominal,
        nama_wakif: this.pembayaranBerjangka.atas_nama,
        metode_pembayaran: this.metode_pembayaran,
        program_wakaf_id: this.pembayaranBerjangka.ProgramId,
        wakif_id: this.pembayaranBerjangka.UserId,
        nomor_rekening: this.pembayaranBerjangka.nomor_rekening,
        nama_pemilik_rekening: this.pembayaranBerjangka.nama_pemilik_rekening,
        jangka_waktu: this.pembayaranBerjangka.jangka_waktu,
        nama_bank: this.pembayaranBerjangka.nama_bank,
        jenis_pembayaran: this.jenis_pembayaran
      }, {
        headers: authHeader(),
        data_wakif: this.currentUser.data
      })
          .then((res) => {
                console.log(res)
                this.$emit('AfterCreated')
                $('#berWakaf')
                    .modal('hide')
                if (this.jenis_pembayaran === 'qris') {
                  swal.fire(
                      {
                        title: `<strong>Pindai untuk membayar</strong>`,
                        imageUrl: `${res.data.data.kode_pembayaran}`,
                        html: `<p><br><button class="download btn btn-success">Download QR Code</button><br>Atas Nama : ${this.currentUser.data.nama}
                       <br>Nominal : ${res.data.data.nominal}<br>Status Pembayaran : ${res.data.data.status_pembayaran}<br>
                       Metode Pembayaran : ${res.data.data.metode_pembayaran}
                       </p>`,
                        showCloseButton: true,
                        willOpen: () => {
                          const download = document.querySelector('.download')

                          download.addEventListener('click', () => {
                            console.log('disinii')
                            saveAs(`${res.data.data.kode_pembayaran}`, 'QR.jpg')
                          })
                        }
                      }
                  )
                } else if (this.jenis_pembayaran === 'bank') {
                  swal.fire(
                      {
                        title: `<strong>Transaksi Berhasil</strong>`,
                        html: `<p>Atas Nama : ${this.currentUser.data.nama}
                       <br>Nominal : ${res.data.data.nominal}<br>Status Pembayaran : ${res.data.data.status_pembayaran}<br>
                       Metode Pembayaran : ${res.data.data.metode_pembayaran}<br> Virtual Account : ${res.data.data.kode_pembayaran}
                       </p>`,
                        showCloseButton: true
                      }
                  )
                } else if (this.jenis_pembayaran === 'cstore') {
                  swal.fire(
                      {
                        title: `<strong>Cstore Payment</strong>`,
                        html: `<p>Atas Nama : ${this.currentUser.data.nama}
                       <br>Nominal : ${res.data.data.nominal}<br>Status Pembayaran : ${res.data.data.status_pembayaran}<br>
                       Metode Pembayaran : ${res.data.data.metode_pembayaran}<br> Kode Pembayaran : ${res.data.data.kode_pembayaran}
                       </p>`,
                        showCloseButton: true
                      }
                  )
                }
                this.$emit('AfterCreated')
                this.$Progress.finish()
                this.$router.push('/home/wakaf/berjangka')

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
      // }
    },
    getLaporan(){
      axios.get(URL + '/api/laporan/' + this.currentProgram.id, {headers: authHeader()}).then(function (response) {
        this.laporannew = response.data;
        console.log(this.currentProgram.id);
      }.bind(this));
    },
    formatDate(dm) {
      return moment(dm).format('DD/MM/YYYY');
    },
    progressStyle(terkumpul, total) {
      return {
        "width": (terkumpul / total) * 100 + '%',
        height: `${this.height}px`
      };
    },
    displayDeskripsi(){
      this.displayNow = 0
    },
    displayWakaf(){
      this.displayNow = 1
    },
  },
}
</script>
<style scoped>
.bg-overlay {
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center center;
  color: #fff;
}
.form-control {
  border-radius: 7px;
  border: 1.5px solid #E3E6ED
}

input.form-control:focus {
  box-shadow: none;
  border: 1.5px solid #E3E6ED;
  background-color: #F7F8FD;
  letter-spacing: 1px
}

.btn-primary {
  background-color: #5878FF !important;
  border-radius: 7px
}

.btn-primary:focus {
  box-shadow: none
}

.card-horizontal {
  display: flex;
  flex: 1 1 auto;
}

input[type=radio] {
  margin-right: 3px;
  border: 0px;
  height: 3em;
}

.card-img-top {
  width: 100%;
  height: 18vw;
  object-fit: cover;
}

</style>
