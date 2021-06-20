<template>
  <div>
    <div>
      <div class="header-blue">
        <nav class="navbar navbar-light navbar-expand-md navigation-clean-search">
          <div class="container-fluid"><a class="navbar-brand" href="#">WakafKu</a><button data-toggle="collapse" class="navbar-toggler" data-target="#navcol-1"><span class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
            <div class="collapse navbar-collapse" id="navcol-1">
              <ul class="nav navbar-nav">
                <li class="nav-item">
                  <router-link class="nav-link" to="/about-us">About Us</router-link>
                </li>
              </ul>
              <form class="form-inline mr-auto" target="_self">
                <div class="form-group"><label for="search-field"><i class="fa fa-search text-white"></i></label><input class="form-control search-field" type="search" id="search-field" name="search"></div>
              </form>
              <div v-if="currentUser==null">
                <span class="navbar-text"> <router-link class="login" to="/login">Masuk</router-link></span>
                <router-link class="btn btn-light action-button" role="button" to="/register">Daftar</router-link>
              </div>
              <div v-else>
                <router-link class="btn btn-light action-button" role="button" to="/home">Home</router-link>
              </div>
            </div>
          </div>
        </nav>
        <div class="container hero">
          <div class="row">
            <div class="col-12 col-lg-6 col-xl-5 offset-xl-1">
              <h1>Mari Berwakaf Uang</h1>
              <p>
                Berwakaf uang dengan mudah dimana saja dan kapan saja. Ayo lakukan sekarang juga untuk membantu masyarakat yang membutuhkan
              </p><button class="btn btn-light btn-lg action-button" type="button">Learn More<i class="fas fa-arrow-right ml-2"></i></button>
            </div>
            <div class="col-md-5 col-lg-5 offset-lg-1 offset-xl-0 d-none d-lg-block phone-holder">
              <div class="iphone-mockup"> <!-- <div class="screen">	</div>	-->
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Header -->
    <header class="bg-gradient-success text-center py-3 mb-4">
      <div class="container">
        <h3 class="font-weight-bold text-white">KATEGORI PROGRAM WAKAF UANG</h3>
      </div>
    </header>
    <!-- Page Content -->
    <div class="container mt-5">
      <div class="row d-flex justify-content-center">
        <!-- Team Member 1 -->
        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-0 shadow">
            <img src="https://cdn.statically.io/img/terasmaluku.com/wp-content/uploads/2019/02/IMG-20190214-WA0156.jpg?quality=100&f=auto" class="card-img-top" alt="...">
            <div class="card-body text-center">
              <h5 class="card-title mb-0 text-center">Pendidikan</h5>
            </div>
          </div>
        </div>
        <!-- Team Member 2 -->
        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-0 shadow">
            <img src="https://amcf.or.id/wp-content/uploads/2021/02/katarak-medan-796-x-442.jpg" class="card-img-top" alt="...">
            <div class="card-body text-center ">
              <h5 class="card-title mb-0 text-center">Kesehatan</h5>
            </div>
          </div>
        </div>
        <!-- Team Member 3 -->
        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-0 shadow">
            <img src="https://foto.kontan.co.id/eFZTAN7-gEWYsTCw3OkEPH8SwjA=/smart/2016/06/24/512281524p.jpg" class="card-img-top" alt="...">
            <div class="card-body text-center">
              <h5 class="card-title mb-0 text-center">Tempat Ibadah</h5>
            </div>
          </div>
        </div>
      </div>
        <!-- Team Member 4 -->
        <div class="row d-flex justify-content-center">
        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-0 shadow">
            <img src="https://cdn-asset.jawapos.com/wp-content/uploads/2021/02/SEDEKAH2-560x373.jpg" class="card-img-top" alt="...">
            <div class="card-body text-center ">
              <h5 class="card-title mb-0 text-center">Umum</h5>
            </div>
          </div>
        </div>
        <!-- Team Member 3 -->
        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-0 shadow">
            <img src="https://cdn.idntimes.com/content-images/post/20181023/00-fcf82172d6cedd71f5c081db59dd5360_600x400.jpg" class="card-img-top" alt="...">
            <div class="card-body text-center">
              <h5 class="card-title mb-0 text-center">Donasi Bencana</h5>
            </div>
          </div>
        </div>
          <!-- Team Member 3 -->
          <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-0">
              <img src="https://icon-library.com/images/next-icon/next-icon-11.jpg" class="card-img-top" alt="..." style="object-fit: contain;">
              <div class="card-body text-center">
                <router-link :to="isLoggedIn()">
                  <h5 class="card-title mb-0 text-center font-weight-bolder text-success">Selengkapnya</h5>
                </router-link>
              </div>
            </div>
          </div>

      </div>
      <!-- /.row -->

    </div>
    <!-- /.container -->
    <!-- Header -->
    <div class="container-fluid py-3 statistik-page">
      <header class="text-center py-3 mb-4">
        <div class="container">
          <h3 class="font-weight-bold text-white">STATISTIK</h3>
        </div>
      </header>
      <div class="container" id="statistik">
        <div class="row">
          <div class="four col-md-3">
            <div class="counter-box colored"> <i class="fa fa-building fa-3x mb-3"></i><span class="counter">6</span>
              <p>Program Wakaf Uang</p>
            </div>
          </div>
          <div class="four col-md-3">
            <div class="counter-box"> <i class="fa fa-money-check fa-3x mb-3"></i><span class="counter">5000000</span>
              <p>Wakaf Uang Abadi</p>
            </div>
          </div>
          <div class="four col-md-3">
            <div class="counter-box"> <i class="fa fa-credit-card fa-3x mb-3"></i> <span class="counter">5000000</span>
              <p>Wakaf Uang Berjangka</p>
            </div>
          </div>
          <div class="four col-md-3">
            <div class="counter-box"> <i class="fa fa-user fa-3x mb-3"></i><span class="counter">5</span>
              <p>Wakif</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="container marketing mb-5" id="aboutbwi">
      <hr class="featurette-divider">
      <div class="row featurette">
        <div class="col-md-7">
          <h2 class="featurette-heading">Tentang <span class="text-muted">Badan Wakaf Indonesia</span></h2>
          <p class="lead">
            Badan Wakaf Indonesia (BWI) adalah lembaga negara independen yang dibentuk berdasarkan Undang-Undang Nomor 41 Tahun 2004 tentang Wakaf. Badan ini dibentuk dalam rangka mengembangkan dan memajukan perwakafan di Indonesia.          </p>
        </div>
        <div class="col-md-5">
          <img class="featurette-image img-fluid mx-auto" src="https://www.bwi.go.id/wp-content/uploads/2020/01/Logo-Badan-Wakaf-Indonesia-Fix-1024x785.png" alt="Generic placeholder image">
        </div>
      </div>
    </div>

    <div class="container marketing mb-5" id="aboutbwi">
      <hr class="featurette-divider">
      <div class="row featurette">
        <div class="col-md-5">
          <img class="featurette-image img-fluid mx-auto" src="@/assets/device-preview.png" alt="Generic placeholder image">
        </div>
        <div class="col-md-7">
          <h2 class="featurette-heading">Tentang <span class="text-muted">WakafKu</span></h2>
          <p class="lead">
            WakafKu adalah platform digital untuk pembayaran wakaf uang dengan teknologi payment gateway. WakafKu tersedia di platform Website dan Mobile</p>
        </div>
      </div>
    </div>
    <Footer></Footer>
  </div>
</template>
<script>
const URL = 'http://localhost:4000'
import Footer from '@/components/user/layouts/elements/Footer'
import authHeader from '@/services/auth-header'
import axios from 'axios'
import moment from 'moment'
export default {
  title: 'Wakafku',
  data() {
    return {
      programs : []
    }
  },
  components: {
    Footer
  },
  computed: {
    currentUser() {
      return this.$store.state.auth.user;
    },
  },
  methods : {
    isLoggedIn(){
      return this.currentUser == null ? '/login' : '/programs';
    }
  }
}
</script>
<style scoped>
.statistik-page {
  background: url("../../../assets/images/orange-mosque.jpg");
  background-size: cover;
  background-position: bottom;
}
/* Center align the text within the three columns below the carousel */
.marketing .col-lg-4 {
  margin-bottom: 1.5rem;
  text-align: center;
}
.marketing h2 {
  font-weight: 400;
}
.marketing .col-lg-4 p {
  margin-right: .75rem;
  margin-left: .75rem;
}
.featurette-divider {
  margin: 5rem 0; /* Space out the Bootstrap <hr> more */
}
.counter-box {
  display: block;
  background: #f6f6f6;
  padding: 40px 20px 37px;
  text-align: center
}

.counter-box p {
  margin: 5px 0 0;
  padding: 0;
  color: #909090;
  font-size: 18px;
  font-weight: 500
}

.counter-box i {
  font-size: 60px;
  margin: 0 0 15px;
  color: #d2d2d2
}

.counter {
  display: block;
  font-size: 32px;
  font-weight: 700;
  color: #666;
  line-height: 28px
}

.counter-box.colored {
  background: #3acf87
}

.counter-box.colored p,
.counter-box.colored i,
.counter-box.colored .counter {
  color: #fff
}
.header-blue {
  background: linear-gradient(135deg, rgba(0, 121, 101, 0.7), rgba(0, 175, 145,0.4)), url("../../../assets/images/gambar_kepala.jpg");
  background-size: cover;
  background-position: center;
  padding-bottom: 80px;
  font-family: 'Source Sans Pro', sans-serif
}

@media (min-width:768px) {
  .header-blue {
    padding-bottom: 120px
  }
}

.header-blue .navbar {
  background: transparent;
  padding-top: .75rem;
  padding-bottom: .75rem;
  color: #fff;
  border-radius: 0;
  box-shadow: none;
  border: none
}

@media (min-width:768px) {
  .header-blue .navbar {
    padding-top: 1rem;
    padding-bottom: 1rem
  }
}

.header-blue .navbar .navbar-brand {
  font-weight: bold;
  color: inherit
}

.header-blue .navbar .navbar-brand:hover {
  color: #f0f0f0
}

.header-blue .navbar .navbar-collapse {
  border-top: 1px solid rgba(255, 255, 255, 0.3);
  margin-top: .5rem
}

@media (min-width:768px) {
  .header-blue .navbar .navbar-collapse {
    border-color: transparent;
    margin: 0
  }
}

.header-blue .navbar .navbar-collapse span .login {
  color: #fff;
  margin-right: .5rem;
  text-decoration: none
}

.header-blue .navbar .navbar-collapse span .login:hover {
  color: #fff
}

.header-blue .navbar .navbar-toggler {
  border-color: rgba(255, 255, 255, 0.3)
}

.header-blue .navbar .navbar-toggler:hover,
.header-blue .navbar-toggler:focus {
  background: none
}

@media (min-width: 768px) {
  .header-blue .navbar-nav .nav-link {
    padding-left: .7rem;
    padding-right: .7rem
  }
}

@media (min-width: 992px) {
  .header-blue .navbar-nav .nav-link {
    padding-left: 1.2rem;
    padding-right: 1.2rem
  }
}

.header-blue .navbar.navbar-light .navbar-nav .nav-link {
  color: #fff
}

.header-blue .navbar.navbar-light .navbar-nav .nav-link:focus,
.header-blue .navbar.navbar-light .navbar-nav .nav-link:hover {
  color: #fcfeff !important;
  background-color: transparent
}

.header-blue .navbar .navbar-nav>li>.dropdown-menu {
  margin-top: -5px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, .1);
  background-color: #fff;
  border-radius: 2px
}

.header-blue .navbar .dropdown-menu .dropdown-item:focus,
.header-blue .navbar .dropdown-menu .dropdown-item {
  line-height: 2;
  color: #37434d
}

.header-blue .navbar .dropdown-menu .dropdown-item:focus,
.header-blue .navbar .dropdown-menu .dropdown-item:hover {
  background: #ebeff1
}

.header-blue .action-button,
.header-blue .action-button:not(.disabled):active {
  border: 1px solid rgb(255, 255, 255);
  border-radius: 40px;
  color: #fff;
  box-shadow: none;
  text-shadow: none;
  padding: .3rem .8rem;
  background: transparent;
  transition: background-color 0.25s;
  outline: none
}

.header-blue .action-button:hover {
  color: #fff
}

.header-blue .navbar .form-inline label {
  color: #d9d9d9
}

.header-blue .navbar .form-inline .search-field {
  display: inline-block;
  width: 80%;
  background: none;
  border: none;
  border-bottom: 1px solid transparent;
  border-radius: 0;
  color: #fff;
  box-shadow: none;
  color: inherit;
  transition: border-bottom-color 0.3s
}

.header-blue .navbar .form-inline .search-field:focus {
  border-bottom: 1px solid #ccc
}

.header-blue .hero {
  margin-top: 20px;
  text-align: center
}

@media (min-width:768px) {
  .header-blue .hero {
    margin-top: 60px;
    text-align: left
  }
}

.header-blue .hero h1 {
  color: #fff;
  font-size: 40px;
  margin-top: 0;
  margin-bottom: 15px;
  font-weight: 300;
  line-height: 1.4
}

@media (min-width:992px) {
  .header-blue .hero h1 {
    margin-top: 190px;
    margin-bottom: 24px;
    line-height: 1.2
  }
}

.header-blue .hero p {
  color: rgba(255, 255, 255, 0.8);
  font-size: 20px;
  margin-bottom: 30px;
  font-weight: 300
}

.header-blue .phone-holder {
  text-align: right
}

.header-blue div.iphone-mockup {
  position: relative;
  max-width: 300px;
  margin-top: 172px;
  display: inline-block
}

.header-blue .iphone-mockup img.device {
  width: 100%;
  height: auto
}

.header-blue .iphone-mockup .screen {
  position: absolute;
  width: 88%;
  height: 77%;
  top: 12%;
  border-radius: 2px;
  left: 6%;
  border: 1px solid #444;
  background-color: #aaa;
  overflow: hidden;

}

.header-blue .iphone-mockup .screen:before {
  content: '';
  background-color: #fff;
  position: absolute;
  width: 70%;
  height: 140%;
  top: -12%;
  right: -60%;
  transform: rotate(-19deg);

  opacity: 0.2
}
.card-img-top {
  width: 100%;
  height: 13vw;
  object-fit: cover;
}
</style>
