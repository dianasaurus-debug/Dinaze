<template>
  <div>
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0 text-dark">Dashboard</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Dashboard v1</li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <!-- Small boxes (Stat box) -->
        <div class="row">
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-info">
              <div class="inner">
                <h3>{{ programs.length }}</h3>

                <p>Program Wakaf</p>
              </div>
              <div class="icon">
                <i class="ion ion-cube"></i>
              </div>
              <router-link to="/admin/program" class="small-box-footer">More info <i
                  class="fas fa-arrow-circle-right"></i></router-link>
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-success">
              <div class="inner">
                <h3>{{ wakafabadi.length }}</h3>

                <p>Wakaf Abadi</p>
              </div>
              <div class="icon">
                <i class="ion ion-card"></i>
              </div>
              <router-link to="/admin/wakaf/abadi" class="small-box-footer">More info <i
                  class="fas fa-arrow-circle-right"></i></router-link>
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-warning">
              <div class="inner">
                <h3>{{ wakafberjangka.length }}</h3>

                <p>Wakaf Berjangka</p>
              </div>
              <div class="icon">
                <i class="ion ion-cash"></i>
              </div>
              <router-link to="/admin/wakaf/berjangka" class="small-box-footer">More info <i
                  class="fas fa-arrow-circle-right"></i></router-link>
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-danger">
              <div class="inner">
                <h3>{{ users.length }}</h3>

                <p>Wakif</p>
              </div>
              <div class="icon">
                <i class="ion ion-person-stalker"></i>
              </div>
              <router-link to="/admin/wakif/all" class="small-box-footer">More info <i
                  class="fas fa-arrow-circle-right"></i></router-link>
            </div>
          </div>
          <!-- ./col -->
        </div>
        <!-- /.row -->
        <div class="row mt-3">
          <div class="col-5">
            <h4>Grafik Wakaf Uang</h4>
            <div class="form-inline" style>
              <input type="date" class="form-control mr-2" v-model="startdate">
              <input type="date" class="form-control mr-2" v-model="enddate">
              <input type='button' class="btn btn-primary" @click='updateDatebyDate()' value='Search'>
              <div class="dropdown ml-2">
                <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                  <span class="selected">Filter Tanggal</span>
                  <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                  <li class="dropdown-item"><a href="#" @click="updateByFiltering(7)">7 Days ago</a></li>
                  <li class="dropdown-item"><a href="#" @click="updateByFiltering(14)">14 Days ago</a></li>
                  <li class="dropdown-item"><a href="#" @click="updateByFiltering(30)">1 Month ago</a></li>
                  <li class="dropdown-item"><a href="#" @click="updateByFiltering(60)">2 Months ago</a></li>

                </ul>
              </div>
            </div>
            <!-- Search Button -->
          </div>
          <div class="col-3">
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
          </div>
        </div>
        <div class="row">
          <div class="col-8">
            <LineCharts :chart-data="jenisWakafAbadi ? abadiData : berjangkaData"></LineCharts>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>
<script>
import axios from 'axios'
import moment from 'moment'

const URL = 'https://wakaf.praditya.web.id'

// import Chart from 'chart.js';
// import numeral from 'numeral';
// let start = new Date(),
//     end = new Date();
// start.setDate(start.getDate() - 7); // set to 'now' minus 7 days.
// start.setHours(0, 0, 0, 0); // set to midnight.
import LineCharts from '@/components/admin/layout/elements/Charts/LineCharts'
import authHeader from '@/services/auth-header-admin.service'

import _ from 'lodash'

var result = []
var result2 = []

export default {
  title: 'Dashboard',
  components: { LineCharts },
  result,
  result2,
  mounted() {
    $('div.dropdown ul.dropdown-menu li a').click(function (e) {
      //e.preventDefault();
      $('.selected').html($(this).html());
    })
  },
  created() {
    this.getAllPrograms()
    this.getAllWakafAbadi()
    this.getAllWakafBerjangka()
    this.getAllUsers()
    this.getGrafikData()
    this.getGrafikDataBerjangka()
  },
  data() {
    return {
      jenisWakafAbadi: true,
      chartData: null,
      chartData2: null,
      wakafabadi: [],
      wakafberjangka: [],
      users: [],
      programs: [],
      tanggal: [],
      startdate : 'none',
      enddate : 'none',
      // wakafabadifiltered : [],
      wakafberjangkafiltered: [],
      labels: [],
      abadibydate: [],
      jangkabydate: [],
      datasets: [],
      datasets2: [],
      labels2: [],
      grafikResult: [],
      grafikResultBerjangka: []
    }
  },
  computed: {
    wakafAbadi() {
      return this.wakafabadi
    },
    abadiData() {
      result = this.grafikResult
      var datareturn = {
        labels: result.map(item => item.tanggal),
        datasets: [
          {
            backgroundColor: '#98ddde',
            borderColor: '#030c0c',
            data: result.map(item => item.count),
            label: 'Nominal Wakaf'
          }
        ]
      }
      return datareturn
    },
    berjangkaData() {
      result2 = this.grafikResultBerjangka
      var datareturn2 = {
        labels: result2.map(item => item.tanggal),
        datasets: [
          {
            backgroundColor: '#98ddde',
            borderColor: '#030c0c',
            data: result2.map(item => item.count),
            label: 'Nominal Wakaf'
          }
        ]
      }
      return datareturn2
    }
  },
  methods: {
    checkDate(){
      if(this.startdate != 'none'){
        var startdate = new Date(this.startdate);
        var enddate = new Date(this.enddate);
        if(startdate.getTime() > enddate.getTime()){
          var day = startdate.getDate();
          var month = startdate.getMonth();
          var year = startdate.getFullYear();

          this.enddate = new Date(year, month, day);
        }
      }

    },
    updateDatebyDate(){
      this.getGrafikData();
      this.getGrafikDataBerjangka();
    },
    updateByFiltering(day){
      this.startdate = moment(Date.now() - day * 24 * 3600 * 1000).format('YYYY-MM-DD');
      this.enddate = moment(Date.now()).format('YYYY-MM-DD');
      this.getGrafikData();
      this.getGrafikDataBerjangka();
    },
    getGrafikData() {
      axios.get(URL + `/api/admin/wakaf-abadi/grafik/startdate/${this.startdate}/enddate/${this.enddate}`, { headers: authHeader() })
          .then(data => {
            this.grafikResult = data.data
          })
    },
    getGrafikDataBerjangka() {
      axios.get(URL + `/api/admin/wakaf-berjangka/grafik/startdate/${this.startdate}/enddate/${this.enddate}`, { headers: authHeader() })
          .then(data => {
            this.grafikResultBerjangka = data.data
            console.log(data.data)
          })

    },
    formatBulan(date) {
      return moment(date)
          .format('MMMM')
    },
    getAllPrograms() {
      axios.get('https://wakaf.praditya.web.id' + '/api/admin/program-wakaf/all', { headers: authHeader() })
          .then(function (response) {
            this.programs = response.data.data
          }.bind(this))
    },
    getAllWakafAbadi() {
      axios.get(URL + '/api/admin/wakaf-abadi/all/', { headers: authHeader() })
          .then(function (response) {
            this.wakafabadi = response.data
          }.bind(this))
    },
    getAllWakafBerjangka() {
      axios.get(URL + '/api/admin/wakaf-berjangka/all/', { headers: authHeader() })
          .then(function (response) {
            this.wakafberjangka = response.data
          }.bind(this))
    },
    getAllUsers() {
      axios.get(URL + '/api/admin/users/all/', { headers: authHeader() })
          .then(function (response) {
            this.users = response.data
          }.bind(this))
    },
    formatDate(dm) {
      return moment(dm)
          .format('DD/MM/YYYY')
    }
  }
}

</script>
