<template>
  <div>
    <div class="container mb-5">
      <div class="row">
        <div class="col-3 ml-auto">
            <form @submit.prevent="cariProgram">
              <div class="input-group mb-3">
              <input type="text" v-model="query" class="form-control" placeholder="Cari Program Wakaf..">
              <div class="input-group-append">
                <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i></button>
              </div>
              </div>
            </form>

          <!--          <ReactiveBase app="wakafku"-->
          <!--                        url="http://localhost:9200"-->
          <!--          >-->
          <!--            <DataSearch-->
          <!--                componentId="judul"-->
          <!--                iconPosition="right"-->
          <!--                :dataField="[-->
          <!--                  'judul',-->
          <!--                  'judul.raw',-->
          <!--                  'judul.search'-->
          <!--                ]"-->
          <!--                className="data-search"-->
          <!--                :showClear="true"-->
          <!--                queryFormat="or"-->
          <!--                placeholder="Search for program"-->
          <!--            />-->
          <!--          </ReactiveBase>-->

        </div>
      </div>
      <h5 class="text-center mb-3" v-if="isSearching">Menampilkan {{filteredByCategories.length}} program dengan kata kunci "{{katakunci}}" | <a class="text-danger" style="cursor : pointer" @click="clearPencarian">Clear Pencarian</a>
      </h5>

      <h4 class="text-center font-weight-bold mb-3">Daftar Program Wakaf</h4>
      <div class="row">
        <div class="col-12" v-if="filteredByCategories.length==0">
          <h5 class="mt-2 text-center">Belum ada program wakaf</h5>
        </div>
        <div class="col-md-4 mx-auto my-6" v-else-if="filteredByCategories.length>0"
             v-for="program in filteredByCategories" :key="program.id">
          <!--Card-->
          <div class="card card-cascade narrower mb-4">

            <!-- Card image -->
            <img class="card-img-top" :src="'https://wakaf.praditya.web.id/images/'+program.gambar"
                 alt="Card image cap">
            <a href="#!">
              <div class="mask rgba-white-slight"></div>
            </a>

            <!--Card content-->
            <div class="card-body card-body-cascade p-3">
            <span class="badge badge-pill badge-success mb-2">
              <i class="fas fa-graduation-cap" v-show="program.kategori_id == 1"></i>
              <i class="fas fa-heartbeat" v-show="program.kategori_id == 2"></i>
              <i class="fas fa-mosque" v-show="program.kategori_id == 3"></i>
              <i class="fas fa-user" v-show="program.kategori_id == 4"></i>
              <i class="fas fa-atlas" v-show="program.kategori_id == 5"></i>
              {{ program.kategori.nama }}
            </span>
              <!--                <span class="badge badge-pill badge-danger mr-1"><i-->
              <!--                    class="fas fa-calendar"></i> {{ formatDate(program.deadline) }}</span>-->
              <!--                <span v-if="formatDate(program.created_at)<=formatDate(program.deadline)" class="badge badge-pill badge-primary">Ongoing</span>-->
              <!--                <span v-if="formatDate(program.createdAt)>formatDate(program.deadline)" class="badge badge-pill badge-success">Selesai</span>-->
              <br>
              <!--Title-->
              <h4 class="card-title mb-2" style="font-size: 20px;font-weight: bold">{{ program.judul }}</h4>
              <!--Text-->
              <p class="card-text text-justify" style="font-size: 12px;">
                {{ program.deskripsi | truncate(150, '...') }}
              </p>
              <h6 class="card-text text-justify text-blue">
                <span class="font-weight-bold text-black-50">Terkumpul</span> :
                {{ program.wakaf_abadi_terkumpul + program.wakaf_berjangka_terkumpul | filterMoney }}
              </h6>
              <a href="" class="btn btn-primary mt-2 mr-1" @click.prevent="berwakaf(program)">Berwakaf</a>
              <a href="" class="btn btn-success mt-2" @click.prevent="navigateToDetail(program)">More</a>
            </div>
            <!-- Card footer -->
            <div class="card-footer text-muted text-center" style="font-size: 10px">
              {{ formatDate(program.created_at) }}
            </div>
            <!--/.Card content-->

          </div>
          <!--/.Card-->
        </div>
      </div>
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
import axios from 'axios'
import moment from 'moment'
import $ from 'jquery'
import authHeader from '../../../services/auth-header'

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
  computed: {
    currentUser() {
      return this.$store.state.auth.user.data;
    },
    currentCategory() {
      return this.$store.state.categoriesStore.category_id
    },
    currentQuery() {
      return this.$store.state.currentQuery.query
    },
    filteredByCategories() {
      if (this.currentCategory == 0) {
        let self = this
        if (this.currentQuery == null) {
          if(this.isSearching==false){
            return this.programs
          } else {
            return this.programDicari
          }
        } else {
          if(this.isSearching==false){
            return self.programs.filter(program => {
              let sameJudul = program.judul.toLowerCase()
                  .includes(self.currentQuery.toLowerCase())
              let sameDeskripsi = program.deskripsi.toLowerCase()
                  .includes(self.currentQuery.toLowerCase())
              return sameJudul || sameDeskripsi
            })
          } else {
            return self.programDicari.filter(program => {
              let sameJudul = program.judul.toLowerCase()
                  .includes(self.currentQuery.toLowerCase())
              let sameDeskripsi = program.deskripsi.toLowerCase()
                  .includes(self.currentQuery.toLowerCase())
              return sameJudul || sameDeskripsi
            })
          }

        }
      } else {
        let filteredProgram;

        if(this.isSearching==false){
          filteredProgram = this.programs.filter(program =>
              program.kategori_id == this.currentCategory
          );
        } else {
          filteredProgram = this.programDicari.filter(program =>
              program.kategori_id == this.currentCategory
          );
        }
        let self = this
        if (this.currentQuery == null) {
          return filteredProgram
        } else {
          return filteredProgram.filter(program => {
            let sameJudul = program.judul.toLowerCase()
                .includes(self.currentQuery.toLowerCase())
            let sameDeskripsi = program.deskripsi.toLowerCase()
                .includes(self.currentQuery.toLowerCase())
            return sameJudul || sameDeskripsi
          })
        }
      }
    }

  },
  created() {
    this.testSandbox()
    this.getAllPrograms()
    this.$on('AfterCreated', () => {
      this.getAllPrograms()
    })
    console.log(this.currentQuery)
  },
  data() {
    return {
      programDicari : '',
      query: '',
      isSearching: false,
      result: [],
      activeId: '',
      programs: [],
      selectedProgram: {},
      jenisWakafAbadi: true,
      jenis_pembayaran: '',
      metode_pembayaran: '',
      dirisendiri: true,
      katakunci : '',
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
  methods: {
    clearPencarian(){
      this.isSearching = false;
      this.programDicari = [];
      this.query = '';
      this.katakunci = '';
    },
    cariProgram(){
      this.isSearching = true;
      this.$Progress.start();
      this.katakunci = this.query
      axios.get(URL + '/api/program-wakaf/search/'+this.query,{ headers: authHeader() }).then(result=>{
        this.programDicari = result.data.data;
        this.$Progress.finish();
      }).catch(err=>{
        swal.fire(
            'Error!',
            'Ada kesalahan' + err,
            'error'
        )
        this.$Progress.fail();

      })
    },
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
    getAllPrograms() {
      axios.get(URL + '/api/program-wakaf/all', {
        headers: authHeader(),
        data_wakif: this.currentUser.data
      })
          .then(function (response) {
            console.log(response.data.data)
            this.programs = response.data.data
            this.result = response.data.data
            console.log(this.programs)
          }.bind(this))
    },
    testSandbox() {
      axios({
        // Below is the API URL endpoint
        url: `https://api.sandbox.midtrans.com/v2/A-20bbc88c-cf4d-4816-8282-2741825765af/status`,
        method: 'get',
        mode: 'no-cors',
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': '*',
          'Access-Control-Allow-Headers': '*',
          Accept: 'application/json',
          Authorization:
              'Basic ' +
              Buffer.from('SB-Mid-server-e4XJJ3-QK_WKD9R-XAmvU1cS')
                  .toString('base64')
          // Above is API server key for the Midtrans account, encoded to base64
        },
        option: {
          crossDomain: true
        }

      })
          .then(
              (snapResponse) => {
                console.log(snapResponse)
              },
              (error) => {
                console.log(error)
              }
          )
    },
    formatDate(dm) {
      return moment(dm)
          .format('DD/MM/YYYY')
    },
    downloadImage(url) {
      console.log('ola')
      saveAs(`${url}`, 'QR.jpg')

    },
    sendProgram(program) {
      console.log(program)
      this.$store.dispatch('currentProgram/pickProgram', program)
    },
    navigateToDetail(program) {
      this.sendProgram(program)
      this.$router.push('/programs/detail')
    }

  }
}
</script>
<style scoped>
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
