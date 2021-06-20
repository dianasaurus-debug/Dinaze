<template>
  <div class="container">
    <div class="row">
      <div class="col-12 mt-3">
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
            <!--            <div style="max-width: 1000px">-->
            <!--              <div class="progress" style="height:20px;">-->
            <!--                <div class="progress-bar" role="progressbar"-->
            <!--                     :style="progressStyle(currentProgram.terkumpul,currentProgram.target)">-->
            <!--                  {{ currentProgram.terkumpul | filterMoney}}-->
            <!--                </div>-->
            <!--              </div>-->
            <!--              <h6 class="float-right">Dari <b>{{ currentProgram.target | filterMoney }}</b></h6>-->
            <!--            </div>-->
            <!--            <p class="text-left mt-3"><span class="mr-2"><i class="fa fa-calendar"></i></span>{{formatDate(currentProgram.createdAt)}} - {{formatDate(currentProgram.deadline)}}</p>-->
            <!--            <p class="text-left"><span class="mr-2"><i class="fa fa-sitemap"></i></span>{{ currentProgram.alamat}}</p>-->
            <!--            <p><a class="btn btn-primary mt-2" href="#" role="button">Edit <i class="fa fa-edit"></i></a></p>-->
            <p><a class="btn btn-primary mt-1" href="#" role="button" @click.prevent="addNewLaporan">Buat Laporan <i class="fa fa-paperclip"></i></a></p>
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
                    <a class="nav-item nav-link" id="nav-wakaf-tab" data-toggle="tab" href="#nav-wakaf" role="tab"
                       aria-controls="nav-wakaf" aria-selected="false">Daftar Wakaf</a>
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
                  <div class="tab-pane fade" id="nav-wakaf" role="tabpanel" aria-labelledby="nav-wakaf-tab">
                    <select class="form-control mb-3 mt-2 col-md-4 ml-auto" v-model="isAbadi">
                      <option v-bind:value="1" selected>Abadi</option>
                      <option v-bind:value="0">Berjangka</option>
                    </select>
                    <div v-if="isAbadi==1">
                      <vue-good-table
                          :columns="columns"
                          :rows="allWakafAbadi"
                          :search-options="{ enabled: true }"
                          :pagination-options="{enabled: true}"
                          :line-numbers="true">
                        <template slot="table-row" slot-scope="props">
                          <span v-if="props.column.field == 'nominal'">
                                  {{props.row.nominal | filterMoney}}
                                </span>
                          <span v-else>
                                  {{props.formattedRow[props.column.field]}}
                                </span>
                        </template>
                      </vue-good-table>
                    </div>
                    <div v-else-if="isAbadi==0">
                      <vue-good-table
                          :columns="columns"
                          :rows="allWakafBerjangka"
                          :search-options="{ enabled: true }"
                          :pagination-options="{enabled: true}"
                          :line-numbers="true">
                        <template slot="table-row" slot-scope="props">
                          <span v-if="props.column.field == 'nominal'">
                                  {{props.row.nominal | filterMoney}}
                                </span>
                          <span v-else>
                                  {{props.formattedRow[props.column.field]}}
                                </span>
                        </template>
                      </vue-good-table>

                    </div>
                  </div>
                  <div class="tab-pane fade" id="nav-laporan" role="tabpanel" aria-labelledby="nav-laporan-tab">
                    <div class="container mt-3">
                      <div class="row" v-if="laporannew.length>0">
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
                      <div class="row" v-else>
                        <div class="col-12">
                          <section class="content">
                            <div class="container text-center p-5">
                              <img class="img-thumbnail mb-5" src="@/assets/empty_data_set.png" style="max-width: 300px" alt="logo kosong"/>
                              <h4 class="text-muted">Maaf, Belum ada data laporan program wakaf</h4>
                            </div>
                          </section>
                        </div>
                      </div>
                    </div>
                    <!-- /.content -->
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
      </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="addNewLaporan" tabindex="-1" role="dialog"
         aria-labelledby="addNewLaporan" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalCenterTitle">Buat Laporan</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <form @submit.prevent="createLaporan">
            <div class="modal-body">
              <div class="form-group">
                <label for="deskripsi">Deskripsi</label>
                <textarea name="deskripsi" v-model="laporan.deskripsi" id="deskripsi" class="form-control" placeholder="Masukkan Deskripsi Laporan Program Wakaf Uang" :class="{ 'is-invalid': submitted && $v.laporan.deskripsi.$error }"></textarea>
                <div v-if="submitted && $v.program.judul.$error" class="invalid-feedback">
                  <span v-if="!$v.laporan.deskripsi.required">Deskripsi laporan is required</span>
                </div>
              </div>

              <div class="form-group">
                <div
                    class="imagePreviewWrapper"
                    :style="{ 'background-image': `url(${imagePreview})` }"
                    @click="selectImage">
                </div>

                <input
                    ref="fileInput"
                    type="file"
                    @input="pickFile">

              </div> <!-- form-group// -->
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
              <button class="btn btn-primary" type="submit">Save changes</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import authHeader from '@/services/auth-header-admin.service'
import axios from 'axios'
import $ from 'jquery'
import moment from 'moment'
import swal from 'sweetalert2'
import { required } from 'vuelidate/lib/validators'
const URL = 'https://wakaf.praditya.web.id'
export default {
  title: 'Detail Program Wakaf',
  created() {
    this.getLaporan();
    this.getDataWakafAbadi();
    this.getDataWakafBerjangka();
    this.$on('AfterCreated', () => {
      this.getLaporan()
    })
  },
  data() {
    return {
      submitted : false,
      isAbadi : 1,
      abadi : [],
      berjangka : [],
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
      imagePreview: '../../../assets/images/image_placeholder.png',
      laporan: {
        deskripsi: '',
        gambar: '',
        ProgramId: '',
      },
      allWakafAbadi : [],
      allWakafBerjangka : [],
      laporannew : [],
    }
  },
  computed : {
    currentProgram() {
      return this.$store.state.currentProgramAdmin.program;
    },
    bgStyle(){
      let bgImg = URL + '/images/'+this.currentProgram.gambar;
      return {
        "background": 'linear-gradient(rgba(0,0,0,.7), rgba(0,0,0,.7)), url('+bgImg+')'
      }
    },
  },
  validations: {
    laporan: {
      deskripsi: {required},
    }
  },
  methods : {
    viewLaporan(){
      this.getLaporan();
      $("#laporan").modal('show');
    },
    getLaporan(){
      axios.get(URL + '/api/laporan/view/byprogram/' + this.currentProgram.id, { headers: authHeader() }).then(function (response) {
        this.laporannew = response.data.data;
      }.bind(this));

    },
    formatDate(dm) {
      return moment(dm).format('DD/MM/YYYY');
    },
    getDataWakafAbadi(){
      axios.get(URL + '/api/admin/wakaf-abadi/all', { headers: authHeader() }).then(function (response) {
        this.allWakafAbadi = response.data.filter(wakaf => {
          return wakaf.program_wakaf_id == this.currentProgram.id && wakaf.status_pembayaran == 'success';
        })
      }.bind(this));
    },
    getDataWakafBerjangka(){
      axios.get(URL + '/api/admin/wakaf-berjangka/all', { headers: authHeader() }).then(function (response) {
        this.allWakafBerjangka = response.data.filter(wakaf => {
          return wakaf.program_wakaf_id == this.currentProgram.id && wakaf.status_pembayaran == 'success';
        })
      }.bind(this));
    },
    progressStyle(terkumpul, total) {
      return {
        "width": (terkumpul / total) * 100 + '%',
        height: `${this.height}px`
      };
    },
    addNewLaporan(){
      this.submitted = false;
      this.imagePreview = 'https://www.pikpng.com/pngl/b/74-745720_download-img-icon-png-clipart.png';
      this.laporan = {};
      $("#addNewLaporan").modal('show');
    },
    selectImage() {
      this.$refs.fileInput.click()
    },
    pickFile() {
      let input = this.$refs.fileInput
      this.laporan.gambar = input.files[0];

      let reader = new FileReader();

      reader.addEventListener("load", function () {
        this.imagePreview = reader.result;
      }.bind(this), false);

      if (this.laporan.gambar) {
        if (/\.(jpe?g|jpg|png|gif)$/i.test(this.laporan.gambar.name)) {
          reader.readAsDataURL(this.laporan.gambar);
        }
      }
    },
    createLaporan(){
      this.submitted = true;
      const formData = new FormData();
      this.$v.$touch();
      this.laporan.ProgramId=this.currentProgram.id;
      formData.append('deskripsi', this.laporan.deskripsi);
      formData.append('file', this.laporan.gambar);
      formData.append('program_wakaf_id', this.laporan.ProgramId);
      if (!this.$v.$invalid) {
        this.$Progress.start();
        axios.post(URL + '/api/laporan/', formData, {headers: authHeader()}).then((res) => {
              this.$emit('AfterCreated');
              $("#addNewLaporan").modal('hide');
              swal.fire(
                  'Sukses!',
                  'Data Laporan sudah diadd',
                  'success'
              )
              this.$Progress.finish();
              this.getLaporan();
            }
        ).catch(err => {
          console.log(err);
          swal.fire(
              'Gagal!',
              'Pastikan anda mengisikan data dengan benar',
              'error'
          )
          this.$Progress.fail();
        })
      }

    }
  }
}
</script>
<style scoped>

.project-tab {
  margin-top: -2%;
}

.project-tab #tabs {
  background: #007b5e;
  color: #eee;
}

.project-tab #tabs h6.section-title {
  color: #eee;
}

.project-tab #tabs .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
  color: #0062cc;
  background-color: transparent;
  border-color: transparent transparent #f3f3f3;
  border-bottom: 3px solid !important;
  font-size: 16px;
  font-weight: bold;
}

.project-tab .nav-link {
  border: 1px solid transparent;
  border-top-left-radius: .25rem;
  border-top-right-radius: .25rem;
  color: #0062cc;
  font-size: 16px;
  font-weight: 600;
}

.project-tab .nav-link:hover {
  border: none;
}

.project-tab thead {
  background: #f3f3f3;
  color: #333;
}

.project-tab a {
  text-decoration: none;
  color: #333;
  font-weight: 600;
}
.bg-overlay {
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center center;
  color: #fff;

}
</style>
