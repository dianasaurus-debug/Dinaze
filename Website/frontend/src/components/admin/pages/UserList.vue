<template>
  <div>
    <div class="col-12 mt-3">
      <!-- Button trigger modal -->
      <div class="card">
        <div class="card-header border-0">
          <h3 class="card-title"><b>Daftar Wakif</b></h3>
        </div>
        <div class="card-body table-responsive p-0">
          <vue-good-table
              :columns="columns"
              :rows="rows"
              :search-options="{ enabled: true }"
              :pagination-options="{enabled: true}"
              :line-numbers="true">
            <template slot="table-row" slot-scope="props">

                                <span v-if="props.column.field == 'nik'">
                                  <i v-if="props.row.nik==null">Belum dilengkapi</i>
                                  <span v-else>{{props.row.nik}}</span>
                                </span>
              <span v-else-if="props.column.field == 'nomor_ponsel'">
                                  <i v-if="props.row.nomor_ponsel==null">Belum dilengkapi</i>
                                  <span v-else>{{props.row.nomor_ponsel}}</span>
                                </span>
              <span v-else-if="props.column.field == 'alamat'">
                                  <i v-if="props.row.alamat==null">Belum dilengkapi</i>
                                  <span v-else>{{props.row.alamat}}</span>
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
  </div>
</template>
<script>
import authHeader from '@/services/auth-header-admin.service'
import axios from 'axios';
// import $ from "jquery";
import moment from 'moment'

const URL = 'https://wakaf.praditya.web.id'
export default {
  title: 'Daftar Wakif',
  mounted() {
    this.getAllUsers();
    this.$on('AfterCreated', () => {
      this.getAllUsers();
    });
  },
  data() {
    return {
      columns: [
        {label: 'id', field: 'id'},
        {label: 'Nama Lengkap', field : 'nama'},
        {label: 'Nomor KTP', field: 'nik'},
        {label: 'Nomor Telepon', field: 'nomor_ponsel'},
        {label: 'E-Mail', field: 'email'},
        {label: 'Alamat', field: 'alamat'},
        {
          label: 'Bergabung', field: 'created_at',
          type: 'date',
          dateInputFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
          dateOutputFormat: 'dd/MM/yyyy'
        },
      ],
      rows: [],
      page: 1,
      per_page: 10,
      user: {},
      submitted : false,
      // categories : []
    }
  },
  computed: {
    currentUser() {
      return this.$store.state.auth.user;
    },
  },
  methods: {
    moment: function (value) {
      return moment(value);
    },
    getAllUsers() {
      axios.get(URL + '/api/admin/users/all/', {headers: authHeader()}).then(function (response) {
        this.rows = response.data;
      }.bind(this));
    },
    // viewWakaf(id){
    //   $("#viewWakaf").modal('show');
    //   axios.get(URL + '/api/wakaf/abadi/' + id).then(function (response) {
    //     this.wakaf = response.data;
    //   }.bind(this));
    // }

  }
}
</script>
