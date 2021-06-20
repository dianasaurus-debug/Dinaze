<template>
  <div class="container-fluid pb-0 mb-0 justify-content-center text-light ">
    <footer>
      <div class="row my-3 justify-content-center py-5">
        <div class="col-11">
          <div class="row ">
            <div class="col-xl-8 col-md-4 col-sm-4 col-12 my-auto mx-auto a">
              <h3 class="text-muted mb-md-0 mb-5 bold-text">WakafKu</h3>
            </div>
            <div class="col-xl-2 col-md-4 col-sm-4 col-12">
              <h6 class="mb-3 mb-lg-4 bold-text "><b>MENU</b></h6>
              <ul class="list-unstyled">
                <li>Home</li>
                <li>About</li>
                <li>Programs</li>
              </ul>
            </div>
            <div class="col-xl-2 col-md-4 col-sm-4 col-12">
              <h6 class="mb-3 mb-lg-4 text-muted bold-text mt-sm-0 mt-5"><b>ALAMAT</b></h6>
              <p class="mb-1">Gedung Bayt Al Quran Lt. 2, Jalan Pintu Utama TMII, Jakarta Timur 13560</p>
            </div>
          </div>
          <div class="row">
            <div class="col-xl-2 col-md-4 col-sm-4 col-auto order-1 align-self-end ">
              <h6 class="mt-55 mt-2 text-muted bold-text"><b>E-Mail</b></h6><small> <span><i class="fas fa-envelope" aria-hidden="true"></i></span> bwi@bwi.go.id</small>
            </div>
            <div class="col-xl-2 col-md-4 col-sm-4 col-auto order-2 align-self-end mt-3 ">
              <h6 class="text-muted bold-text"><b>Nomor Telepon</b></h6><small><span><i class="fas fa-phone" aria-hidden="true"></i></span> 021-87799232, 021-87799311</small>
            </div>
          </div>
        </div>
      </div>
    </footer>
  </div>
</template>
<style scoped>
.container-fluid {
  overflow: hidden;
  background: #262626;
  color: #627482 !important;
  margin-bottom: 0;
  padding-bottom: 0;
  position: absolute;
  z-index: 100;
}

small {
  font-size: calc(12px + (15 - 12) * ((100vw - 360px) / (1600 - 360))) !important
}

.bold-text {
  color: #989c9e !important
}

.mt-55 {
  margin-top: calc(50px + (60 - 50) * ((100vw - 360px) / (1600 - 360))) !important
}

h3 {
  font-size: calc(34px + (40 - 34) * ((100vw - 360px) / (1600 - 360))) !important
}

.social {
  font-size: 21px !important
}

.rights {
  font-size: calc(10px + (12 - 10) * ((100vw - 360px) / (1600 - 360))) !important
}
</style>
