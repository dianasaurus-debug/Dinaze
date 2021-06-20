<template>
  <div>
    <div class="col-12 mt-3">
      <!-- Button trigger modal -->
      <div class="card">
        <div class="card-header border-0">
          <h3 class="card-title"><b>Daftar Wakaf Abadi</b></h3>
        </div>
        <div class="card-body table-responsive p-0">
          <vue-good-table
              :columns="columns"
              :rows="rows"
              :search-options="{ enabled: true }"
              :pagination-options="{enabled: true}"
              :line-numbers="true">
            <template slot="table-row" slot-scope="props">
                                <span v-if="props.column.field == 'action'">
                                     <a href="#" class="mr-2" @click="viewWakaf(props.row.id)">
                                       <i class="fas fa-eye" data-toggle="tooltip" data-placement="top" title="Detail Wakaf"></i>
                                     </a>
                                      <a href="#" :class="{ disabled : isDisabled(props.row)}" @click="uploadDokumen(props.row.id)">
                                          <i class="fas fa-upload" data-toggle="tooltip" data-placement="top" title="Upload Akta dan Sertifikat Wakaf" :class="{ disabledIcon : isDisabled(props.row)}"></i>
                                      </a>
                                </span>
              <span v-if="props.column.field == 'status_pembayaran'" style="font-size: large">
                                     <span v-if="props.row.status_pembayaran=='success'" class="badge bg-green">Sukses</span>
                                      <span v-if="props.row.status_pembayaran=='failure'" class="badge bg-red">Gagal</span>
                                      <span v-if="props.row.status_pembayaran=='pending'" class="badge bg-secondary">Pending</span>
                                      <span v-if="props.row.status_pembayaran=='refund'" class="badge bg-info">Refund</span>
                                </span>
              <span v-else-if="props.column.field == 'nominal'">
                                  {{props.row.nominal | filterMoney}}
                                </span>
              <span v-else-if="props.column.field == 'metode_pembayaran'">
                                        <img src="@/assets/images/logo_bank_bca.png" height="20px" v-if="props.row.metode_pembayaran=='bca'">
                                        <img src="@/assets/images/logo-bni.png" height="20px" v-else-if="props.row.metode_pembayaran=='bni'">
                                        <img src="@/assets/images/logo-bri.png" height="20px" v-else-if="props.row.metode_pembayaran=='bri'">
                                        <img src="@/assets/images/qris.png" height="20px" v-else-if="props.row.metode_pembayaran=='gopay'">
                                        <img src="@/assets/images/indomaret.png" height="20px" v-else-if="props.row.metode_pembayaran=='indomaret'">
                                        <img src="@/assets/images/alfamart.png" height="20px" v-else-if="props.row.metode_pembayaran=='alfamart'">
                                </span>
              <span v-else>
                                  {{props.formattedRow[props.column.field]}}
                                </span>
            </template>
          </vue-good-table>
        </div>
      </div>
      <!-- /.card -->
    </div>

    <!-- Modal -->
    <div class="modal fade" id="viewWakaf" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <table class="table table-hover">
              <tbody>
              <tr>
                <th scope="row">Nominal</th>
                <td>{{wakaf.nominal | filterMoney}}</td>
              </tr>
              <tr>
                <th scope="row">Metode Pembayaran</th>
                <td>
                  <img src="@/assets/images/logo_bank_bca.png" height="20px" v-if="wakaf.metode_pembayaran=='bca'">
                  <img src="@/assets/images/logo-bni.png" height="20px" v-else-if="wakaf.metode_pembayaran=='bni'">
                  <img src="@/assets/images/logo-bri.png" height="20px" v-else-if="wakaf.metode_pembayaran=='bri'">
                  <img src="@/assets/images/qris.png" height="20px" v-else-if="wakaf.metode_pembayaran=='gopay'">
                  <img src="@/assets/images/indomaret.png" height="20px" v-else-if="wakaf.metode_pembayaran=='indomaret'">
                  <img src="@/assets/images/alfamart.png" height="20px" v-else-if="wakaf.metode_pembayaran=='alfamart'">
                </td>
              </tr>
              <tr>
                <th scope="row">Status Pembayaran</th>
                <td>
                  <span v-if="wakaf.status_pembayaran=='success'" class="badge bg-green">Sukses</span>
                  <span v-if="wakaf.status_pembayaran=='failure'" class="badge bg-red">Gagal</span>
                  <span v-if="wakaf.status_pembayaran=='pending'" class="badge bg-secondary">Pending</span>
                  <span v-if="wakaf.status_pembayaran=='refund'" class="badge bg-info">Refund</span>
                </td>
              </tr>
              <tr>
                <th scope="row">Tanggal Bayar</th>
                <td>{{moment(wakaf.created_at).format('DD/MM/YYYY')}}</td>
              </tr>
              <tr v-if="wakaf.program!=undefined">
                <th scope="row">Program Wakaf</th>
                <td>{{wakaf.program.judul}}</td>
              </tr>
              <tr v-if="wakaf.nama_file_akta!=null&&wakaf.nama_file_sertifikat!=null">
                <th scope="row">Download</th>
                <td>
                  <button @click="downloadDokumen(wakaf.nama_file_sertifikat, 'sertifikat')" type="button" class="btn btn-primary mr-2">Sertifikat Wakaf</button>
                  <button @click="downloadDokumen( wakaf.nama_file_akta, 'akta')" type="button" class="btn btn-primary">Akta Ikrar Wakaf</button>
                </td>
              </tr>
              </tbody>
            </table>

          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>

    <div class="modal fade show" id="uploadDokumen" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title" v-if="wakaf.nama_file_sertifikat==null && wakaf.nama_file_akta==null">Upload Dokumen Wakaf</h4>
            <h4 class="modal-title" v-else>Upload Ulang Dokumen Wakaf</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <form @submit.prevent="submitDokumen">
            <div class="modal-body">
              <div class="row">
                <div class="col-6">
                  <div class="card">
                    <h5 class="card-title">Upload Akta</h5>
                    <div class="card-body">
                      <input type="file" id="fileAkta" ref="akta" v-on:change="aktaFIleUpload()" required>
                    </div>
                  </div>
                </div>
                <div class="col-6">
                  <div class="card">
                    <h5 class="card-title">Upload Sertifikat</h5>
                    <div class="card-body">
                      <input type="file" id="fileSertifikat" ref="sertifikat" v-on:change="sertifFileUpload()" required>
                    </div>
                  </div>
                </div>
              </div>

            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="submit" class="btn btn-primary">Upload</button>
            </div>
          </form>
        </div>
        <!-- /.modal-content -->
      </div>
      <!-- /.modal-dialog -->
    </div>

  </div>
</template>
<script>
import axios from 'axios';
import $ from "jquery";
import moment from 'moment'
import authHeader from '../../../services/auth-header-admin.service';
import swal from "sweetalert2";

const URL = 'https://wakaf.praditya.web.id'
export default {
  title: 'Daftar Wakaf Abadi',
  created() {
    this.getAllWakafAbadi();
    this.$on('AfterCreated', () => {
      this.getAllWakafAbadi();
    });
  },
  data() {
    return {
      columns: [
        {label: 'Wakif', field : 'wakif.nama'},
        {label: 'Nominal', field: 'nominal'},
        {label: 'Status Pembayaran', field: 'status_pembayaran'},
        {label: 'Metode Pembayaran', field: 'metode_pembayaran'},
        {label: 'Program Wakaf', field: 'program_wakaf.judul'},
        {
          label: 'Dibayar Pada', field: 'created_at',
          type: 'date',
          dateInputFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
          dateOutputFormat: 'dd/MM/yyyy'
        },
        {label : 'Action', field : 'action'}
      ],
      rows: [],
      page: 1,
      per_page: 10,
      wakaf: {},
      submitted : false,
      categories : [],
      files : {
        akta : '',
        sertifikat : '',
        id_wakaf : ''
      }
    }
  },
  computed: {
    currentUser() {
      return this.$store.state.auth.user;
    },
  },
  methods: {
    downloadDokumen(filename, fileType) {
      saveAs(`${URL}/dokumen/${fileType}/${filename}`, filename)
    },
    aktaFIleUpload(){
      this.files.akta = this.$refs.akta.files[0];
      console.log(this.files.akta)
    },
    sertifFileUpload(){
      this.files.sertifikat = this.$refs.sertifikat.files[0];
      console.log(this.files.sertifikat);
    },
    uploadDokumen(id){
      this.files.id_wakaf = id;
      $('#uploadDokumen').modal('show');
      axios.get(URL + '/api/admin/wakaf-abadi/' + id, {headers: authHeader()}).then(function (response) {
        this.wakaf = response.data;
      }.bind(this));
    },
    submitDokumen(){
      const formData = new FormData()
      formData.append('akta', this.files.akta)
      formData.append('sertifikat', this.files.sertifikat)
      this.$Progress.start()
      axios.post(URL + '/api/admin/upload-dokumen/abadi/'+this.files.id_wakaf, formData, { headers: authHeader() })
          .then((res) => {
                console.log(res)
                this.$emit('AfterCreated')
                $('#uploadDokumen')
                    .modal('hide')
                swal.fire(
                    'Sukses!',
                    'Dokumen akta dan sertifikat sukses diupload',
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
    },
    isDisabled (data){
      return data.status_pembayaran != 'success';
    },
    moment: function (value) {
      return moment(value);
    },
    getAllWakafAbadi() {
      axios.get(URL + '/api/admin/wakaf-abadi/all', {headers: authHeader()}).then(function (response) {
        this.rows = response.data;
      }.bind(this));

    },
    viewWakaf(id){
      $("#viewWakaf").modal('show');
      axios.get(URL + '/api/admin/wakaf-abadi/' + id, {headers: authHeader()}).then(function (response) {
        this.wakaf = response.data;
      }.bind(this));
    }

  }
}
</script>
<style>
.disabledIcon {
  opacity: 0.5;
}
</style>
