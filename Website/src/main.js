import Vue from 'vue'
import App from './App.vue'
import 'bootstrap'
import 'bootstrap/dist/css/bootstrap.min.css'
import '@fortawesome/fontawesome-free/css/all.css'
import '@fortawesome/fontawesome-free/js/all.js'
import 'viewerjs/dist/viewer.css';
import Vuelidate from 'vuelidate';
import store from './store';
import VueProgressBar from 'vue-progressbar'
import moment from 'moment'
import router from '@/router/router';
import UserLayout from '@/components/user/layouts/Index';
import AdminLayout from '@/components/admin/layout/Index';
import AdminAuth from '@/components/admin/layout/Autentikasi'
import UserDashboardLayout from '@/components/user/layouts/Dashboard';
import LandingPage from '@/components/user/layouts/LandingPage'
import VueGoodTablePlugin from 'vue-good-table';
import 'vue-good-table/dist/vue-good-table.css'
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import money from 'v-money';
import titleMixin from './utils/titleMixins'
import VueRs from "@appbaseio/reactivesearch-vue";
import firebase from "firebase";
// register directive v-money and component <money>
Vue.use(VueRs);
Vue.use(Vuelidate);
Vue.use(VueProgressBar, {
  color: 'rgb(143, 255, 199)',
  failedColor: 'red',
  height: '20px'
})
Vue.filter('formatDate', function(value) {
  if (value) {
    return moment(String(value)).format('MMMM Do YYYY')
  }
})
Vue.use(VueGoodTablePlugin);
window.Fire = new Vue();
Vue.config.productionTip = false
Vue.component('user-layout', UserLayout);
Vue.component('landing-page-layout', LandingPage);
Vue.component('admin-layout', AdminLayout);
Vue.component('user-dashboard-layout', UserDashboardLayout);
Vue.component('admin-auth-layout', AdminAuth)
Vue.use(money, {
  decimal: ',',
  thousands: '.',
  precision: 2,
  masked: false})
// Install BootstrapVue
Vue.use(BootstrapVue)
// Install BootstrapVue icon
Vue.use(IconsPlugin)
var filter = function(text, length, clamp){
  clamp = clamp || '...';
  var node = document.createElement('div');
  node.innerHTML = text;
  var content = node.textContent;
  return content.length > length ? content.slice(0, length) + clamp : content;
};
Vue.mixin(titleMixin);
Vue.filter('truncate', filter);
Vue.filter("filterMoney", function (value) {
  return new Intl.NumberFormat("id-ID", { style: "currency", currency: "IDR" }).format(value);
});
const config = {
  apiKey: "AIzaSyA3cOFLbZWLeIKQjRR2Yoe0X4IVTkyTp3Q",
  authDomain: "wakafapp.firebaseapp.com",
  projectId: "wakafapp",
  storageBucket: "wakafapp.appspot.com",
  messagingSenderId: "246266541125",
  appId: "1:246266541125:web:1c9fabbfc8c5ad0808df2c",
  measurementId: "G-ZNVYK7BLX9"
}
firebase.initializeApp(config);

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
