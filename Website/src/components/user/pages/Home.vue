<template>
  <div>
    <!-- Main content -->
    <section class="content mt-3">
      <div class="container-fluid">
        <!-- Info boxes -->
        <div class="row mb-1">
          <div class="col-12">
            <h4>Statistik</h4>
          </div>
        </div>
        <div class="row">
          <div class="col-12 col-sm-6 col-md-3">
            <div class="info-box">
              <span class="info-box-icon bg-info elevation-1"><i class="fas fa-money-check"></i></span>
              <div class="info-box-content">
                <span class="info-box-text">Wakaf Abadi</span>
                <span class="info-box-number">
                  {{ wakafabadi.length}}
                </span>
              </div>
              <!-- /.info-box-content -->
            </div>
            <!-- /.info-box -->
          </div>
          <!-- /.col -->
          <div class="col-12 col-sm-6 col-md-3">
            <div class="info-box mb-3">
              <span class="info-box-icon bg-danger elevation-1"><i class="fas fa-money-check-alt"></i></span>

              <div class="info-box-content">
                <span class="info-box-text">Wakaf Berjangka</span>
                <span class="info-box-number">{{ wakafberjangka.length}}</span>
              </div>
              <!-- /.info-box-content -->
            </div>
            <!-- /.info-box -->
          </div>
          <!-- /.col -->

          <!-- fix for small devices only -->
          <div class="clearfix hidden-md-up"></div>

          <div class="col-12 col-sm-6 col-md-3">
            <div class="info-box mb-3">
              <span class="info-box-icon bg-success elevation-1"><i class="fas fa-shopping-cart"></i></span>

              <div class="info-box-content">
                <span class="info-box-text">Total Wakaf Uang Dibayarkan</span>
                <span class="info-box-number">{{total | filterMoney}}</span>
              </div>
              <!-- /.info-box-content -->
            </div>
            <!-- /.info-box -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
        <div class="row mt-2 mb-1">
          <div class="col-12">
            <h4>Pembayaran Wakaf Terbaru</h4>
          </div>
        </div>
        <div class="row">
          <div class="col-lg-7">
            <!-- TABLE: LATEST ORDERS -->
            <div class="card">
              <div class="card-header border-transparent">
                <div class="card-tools">
                  <div class="row">
                    <div class="col-6">
                      <div class="mr-2">
                        <select class="custom-select form-control-border" v-model="statusPembayaran">
                          <option v-bind:value="'success'">Sukses</option>
                          <option v-bind:value="'pending'">Pending</option>
                          <option v-bind:value="'failure'">Gagal</option>
                          <option v-bind:value="'refund'">Refund</option>
                        </select>
                      </div>
                    </div>
                    <div class="col-6">
                      <select class="custom-select form-control-border" v-model="isAbadi">
                        <option v-bind:value="true">Abadi</option>
                        <option v-bind:value="false">Berjangka</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body p-0">
                <div class="table-responsive" v-if="latestwakafdata.length>0">
                  <table class="table m-0">
                    <thead>
                    <tr>
                      <th>Program</th>
                      <th>Tanggal</th>
                      <th>Nominal</th>
                      <th>Status</th>
                      <th>Metode</th>
                    </tr>
                    </thead>
                    <tbody>
                      <tr v-for="w in latestwakafdata.slice(0, 5)" v-bind:key="w.id">
                        <td>{{w.program_wakaf.judul}}</td>
                        <td>{{w.tanggal}}</td>
                        <td>{{w.nominal | filterMoney}}</td>
                        <td>
                          <span v-if="w.status_pembayaran=='success'" class="badge bg-green">Sukses</span>
                          <span v-if="w.status_pembayaran=='failure'" class="badge bg-red">Gagal</span>
                          <span v-if="w.status_pembayaran=='pending'" class="badge bg-secondary">Pending</span>
                          <span v-if="w.status_pembayaran=='refund'" class="badge bg-info">Refund</span>
                        </td>
                        <td>
                          <img src="@/assets/images/logo_bank_bca.png" height="20px" v-if="w.metode_pembayaran=='bca'">
                          <img src="@/assets/images/logo-bni.png" height="20px" v-else-if="w.metode_pembayaran=='bni'">
                          <img src="@/assets/images/logo-bri.png" height="20px" v-else-if="w.metode_pembayaran=='bri'">
                          <img src="@/assets/images/qris.png" height="20px" v-else-if="w.metode_pembayaran=='gopay'">
                          <img src="@/assets/images/indomaret.png" height="20px" v-else-if="w.metode_pembayaran=='indomaret'">
                          <img src="@/assets/images/alfamart.png" height="20px" v-else-if="w.metode_pembayaran=='alfamart'">
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                <div v-else>
                  <h5 class="text-muted text-center">Data Wakaf Kosong</h5>
                </div>
                <!-- /.table-responsive -->
              </div>
              <!-- /.card-body -->
              <div class="card-footer clearfix">
                <router-link v-if="isAbadi==true" to="/home/wakaf/abadi" class="btn btn-sm btn-success float-right">Selengkapnya</router-link>
                <router-link v-else-if="isAbadi==false" to="/home/wakaf/berjangka" class="btn btn-sm btn-success float-right">Selengkapnya</router-link>
              </div>
              <!-- /.card-footer -->
            </div>
            <!-- /.card -->
          </div>
        </div>
      </div>
    </section>
  </div>
</template>
<script>
import authHeader from '@/services/auth-header'
import axios from 'axios'
import moment from 'moment'
const URL = 'https://wakaf.praditya.web.id'
export default {
  title: 'Home',
  computed: {
    latestwakafdata() {
      var wakafAbadi = this.wakafabadi;
      var wakafBerjangka = this.wakafberjangka;
      if(this.isAbadi==true){
        if(wakafAbadi.length>=5){
          wakafAbadi.slice(0,5).sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime())
        } else {
          wakafAbadi.sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime())
        }
        return wakafAbadi.filter(wakafabadi => {
          return wakafabadi.status_pembayaran.toLowerCase()
              .includes(this.statusPembayaran)
        });
      } else {
        if(wakafBerjangka.length>=5){
          wakafBerjangka.slice(0,5).sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime())
        } else {
          wakafBerjangka.sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime())
        }
        return wakafBerjangka.filter(wakafberjangka => {
          return wakafberjangka.status_pembayaran.toLowerCase()
              .includes(this.statusPembayaran)
        });
      }
    },
    latestPrograms: function() {
      return this.programs.slice().sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime())
    },
    currentUser() {
      return this.$store.state.auth.user.data;
    },
    total(){
      let totalWakafAbadi = [], totalWakafBerjangka = [];

      Object.entries(this.wakafabadi).forEach(([key, val]) => {
        if(val.status_pembayaran=='success')
          totalWakafAbadi.push(parseInt(val.nominal)) // the value of the current key.
      });
      Object.entries(this.wakafberjangka).forEach(([key, val]) => {
        if(val.status_pembayaran=='success')
          totalWakafBerjangka.push(parseInt(val.nominal)) // the value of the current key.
      });
      return totalWakafAbadi.reduce(function(total, num){ return total + num }, 0)+totalWakafBerjangka.reduce(function(total, num){ return total + num }, 0);
    }
  },
  mounted() {
    this.getAllPrograms();
    this.getAllWakafAbadi();
    this.getAllWakafBerjangka();
  },
  data(){
    return {
      statusPembayaran : 'success',
      isAbadi : true,
      wakafabadi: [],
      wakafberjangka : [],
      programs : [],
      latestWakaf : []
    }
  },
  methods : {
    getAllPrograms() {
      axios.get(URL + '/api/program-wakaf/all',{headers: authHeader()}).then(function (response) {
        this.programs = response.data.data;
      }.bind(this));
    },
    getAllWakafAbadi() {
      axios.get(URL + '/api/wakaf-abadi/',{headers: authHeader()}).then(function (response) {
        this.wakafabadi = response.data.data;
      }.bind(this));
    },
    getAllWakafBerjangka() {
      axios.get(URL + '/api/wakaf-berjangka/',{headers: authHeader()}).then(function (response) {
        this.wakafberjangka = response.data.data;
      }.bind(this));
    },
    getBasedOnStatus(status){
      console.log('olla');
      let self = this
      self.wakafabadi.filter(wakafabadi => {
        return wakafabadi.status_pembayaran.toLowerCase()
            .includes(status)
      })
      self.wakafberjangka.filter(wakafberjangka => {
        return wakafberjangka.status_pembayaran.toLowerCase()
            .includes(status)
      })
    },
    formatDate(dm) {
      return moment(dm).format('DD/MM/YYYY');
    }
  }
}
</script>
<style scoped>
.card-img-top {
  width: 100%;
  height: 18vw;
  object-fit: cover;
}
</style>
