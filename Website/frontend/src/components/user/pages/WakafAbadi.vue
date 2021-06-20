<template>
  <div>
    <div class="col-12 mt-3">
      <!-- Button trigger modal -->
      <div class="card">
        <div class="card-header border-0">
          <h3 class="card-title">Wakaf Abadi</h3>
          <div class="card-tools">
            <select class="custom-select form-control-border" v-model="statusPembayaran">
              <option v-bind:value="'success'">Sukses</option>
              <option v-bind:value="'pending'">Pending</option>
              <option v-bind:value="'failure'">Gagal</option>
              <option v-bind:value="'refund'">Refund</option>
            </select>
          </div>
        </div>
        <div class="card-body table-responsive p-0">
          <vue-good-table
              :columns="columns"
              :rows="wakafdata"
              :search-options="{ enabled: true }"
              :pagination-options="{enabled: true}"
              :line-numbers="true">
            <template slot="table-row" slot-scope="props">
                                <span v-if="props.column.field == 'action'">
                                     <a href="#" class="mr-2" @click="viewWakaf(props.row)">
                                       <span class="text-primary">More...</span>
                                     </a>
                                </span>
                                <span v-else-if="props.column.field == 'nominal'">
                                     {{props.row.nominal | filterMoney}}
                                </span>
                                <span v-else-if="props.column.field == 'status_pembayaran'">
                                     <span v-if="props.row.status_pembayaran=='success'" class="badge bg-green">Sukses</span>
                                      <span v-if="props.row.status_pembayaran=='failure'" class="badge bg-red">Gagal</span>
                                      <span v-if="props.row.status_pembayaran=='pending'" class="badge bg-secondary">Pending</span>
                                      <span v-if="props.row.status_pembayaran=='refund'" class="badge bg-info">Refund</span>
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
            <h5 class="modal-title" id="staticBackdropLabel">Detail Riwayat Wakaf</h5>
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
                <th scope="row">Kode Pembayaran</th>
                <td>
                  <img :src="wakaf.kode_pembayaran" v-if="wakaf.metode_pembayaran=='gopay'" height="150px">
                  <h5 v-else>{{wakaf.kode_pembayaran}}</h5>
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
                <td>{{wakaf.tanggal}}</td>
              </tr>
              <tr v-if="wakaf.program!=undefined">
                <th scope="row">Program Wakaf</th>
                <td>{{wakaf.program.judul}}</td>
              </tr>
              <tr>
                <th scope="row">Cetak</th>
                <td>
                  <button type="button" class="btn btn-primary mr-2">Sertifikat Wakaf</button>
                  <button type="button" class="btn btn-primary">Akta Ikrar Wakaf</button>
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

  </div>
</template>
<script>
import authHeader from '@/services/auth-header'
import axios from 'axios';
import $ from "jquery";
import moment from 'moment'

const URL = 'https://wakaf.praditya.web.id'
export default {
  title: 'Riwayat Wakaf Abadi',
  created() {
    this.getAllWakafAbadi();
    this.$on('AfterCreated', () => {
      this.getAllWakafAbadi();
    });
  },
  data() {
    return {
      columns: [
        {label: 'Nominal', field: 'nominal'},
        {label: 'Status Pembayaran', field: 'status_pembayaran'},
        {label: 'Metode Pembayaran', field: 'metode_pembayaran'},
        {label: 'Program Wakaf', field: 'program_wakaf.judul'},
        {
          label: 'Dibayar Pada', field: 'tanggal',
        },
        {label : 'Action', field : 'action'}

      ],
      rows: [],
      page: 1,
      per_page: 10,
      wakaf: {},
      submitted : false,
      categories : [],
      statusPembayaran : 'success'
    }
  },
  computed: {
    wakafdata() {
        return this.rows.filter(wakafabadi => {
          return wakafabadi.status_pembayaran.toLowerCase()
              .includes(this.statusPembayaran)
        });
    },
    currentUser() {
      return this.$store.state.auth.user.data;
    },
  },
  methods: {
    moment: function (value) {
      return moment(value);
    },
    getAllWakafAbadi() {
      axios.get(URL + '/api/wakaf-abadi/' , {headers: authHeader(), data_wakif : this.currentUser.data}).then(function (response) {
        this.rows = response.data.data;
      }.bind(this));
    },
    viewWakaf(wakaf_data){
      $("#viewWakaf").modal('show');
      this.wakaf = wakaf_data;
    }

  }
}
</script>
