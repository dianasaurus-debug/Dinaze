<template>
  <div>
    <div class="jumbotron text-center" style="background-color: rgba(236, 248, 252, 0.8);">
      <div class="container">
        <div class="row">
          <div class="col-xl-8 mx-auto text-center">
            <div class="section-title">
              <h5>KATEGORI PROGRAM WAKAF UANG</h5>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-lg-2 col-md-6">
            <div class="single-service" :class="{ active: isActive(0) }" @mouseover="hover = true;categoryOnMouse = 0" @mouseleave="hover = false">
              <i class="fa fa-globe"></i>
              <a @click.prevent="yourCategory(0)"><h4>Semua</h4></a>
            </div>
          </div>
          <div class="col-lg-2 col-md-6">
            <div class="single-service" :class="{ active: isActive(1) }" @mouseover="hover = true;categoryOnMouse = 1" @mouseleave="hover = false">
              <i class="fa fa-graduation-cap"></i>
              <a @click.prevent="yourCategory(1)"><h4>Pendidikan</h4></a>
            </div>
          </div>
          <div class="col-lg-2 col-md-6">
            <div class="single-service" :class="{ active: isActive(2) }" @mouseover="hover = true;categoryOnMouse = 2" @mouseleave="hover = false">
              <i class="fas fa-credit-card"></i>
              <a @click.prevent="yourCategory(2)"><h4>Kesehatan</h4></a>
            </div>
          </div>
          <div class="col-lg-2 col-md-6">
            <div class="single-service" :class="{ active: isActive(3) }" @mouseover="hover = true;categoryOnMouse = 3" @mouseleave="hover = false">
              <i class="fas fa-mosque"></i>
              <a @click.prevent="yourCategory(3)"><h4>Tempat Ibadah</h4></a>
            </div>
          </div>
          <div class="col-lg-2 col-md-6">
            <div class="single-service" :class="{ active: isActive(4) }" @mouseover="hover = true;categoryOnMouse = 4" @mouseleave="hover = false">
              <i class="fa fa-user"></i>
              <a @click.prevent="yourCategory(4)"><h4>Umum</h4></a>
            </div>
          </div>
          <div class="col-lg-2 col-md-6">
            <div class="single-service" :class="{ active: isActive(5) }" @mouseover="hover = true;categoryOnMouse = 5" @mouseleave="hover = false">
              <i class="fa fa-atlas"></i>
              <a @click.prevent="yourCategory(5)"><h4>Bantuan Sosial</h4></a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

</template>
<script>
  export default{
    data(){
      return {
        currentPick : '',
        category_id : '',
        hover: false,
        categoryOnMouse : '',
        query: '',
      }
    },
    computed: {
      currentCategory() {
        return this.$store.state.categoriesStore.category_id;
      },
      currentQuery() {
        return this.$store.state.currentQuery.query;
      },
    },
    created() {
      console.log(this.currentCategory);
    },
    methods : {
      yourCategory(id){
        this.currentPick = id;
        this.$store.dispatch('categoriesStore/pickCategory', id);
      },
      isActive(id){
        return this.hover&&this.categoryOnMouse==id || this.currentCategory==id
      },
      submitQuery(){
        this.$store.dispatch('currentQuery/pickQuery', this.query);
      }
    },
    mounted() {
      console.log(this.currentCategory);
    }
  }
</script>
<style scoped>
  .section-title {
    margin-bottom: 20px;
  }
  .section-title p {
    color: #777;
    font-size: 16px;
  }
  .section-title h5 {
    text-transform: capitalize;
    font-size: 25px;
    position: relative;
    padding-bottom: 20px;
    margin-bottom: 0px;
    font-weight: 600;
    color : darkblue;
  }
  .section-title h5:before {
    position: absolute;
    content: "";
    width: 60px;
    height: 2px;
    background-color: dodgerblue;
    bottom: 0;
    left: 50%;
    margin-left: -30px;
  }
  .section-title h5:after {
    position: absolute;
    background-color: dodgerblue;
    content: "";
    width: 10px;
    height: 10px;
    bottom: -4px;
    left: 50%;
    margin-left: -5px;
    border-radius: 50%;
  }
  .single-service {
    cursor : pointer;
    border: 1px solid #eee;
    padding: 10px 5px;
    position: relative;
    text-align: center;
    margin-bottom: 0px;
  }
  .single-service i.fa {
    width: 60px;
    height: 60px;
    font-size: 25px;
    color: #fff;
    line-height: 60px;
    text-align:center;
    margin-bottom:20px;
  }
  .single-service i.fa {
    -webkit-transition: .4s;
    transition: .4s;
  }
  .single-service:hover i.fa {
    border-radius: 50%;
  }
  .single-service h4 {
    text-transform: capitalize;
    font-size: 22px;
    margin-bottom: 10px;
    font-weight: 500;
  }
  .active {
    background-color: cornflowerblue;
    color : white;
  }
</style>
