import Vue from 'vue'
import { publicPath } from '../../vue.config'
import Router from 'vue-router'
import Login from '../components/user/pages/Login.vue'
import Register from '../components/user/pages/Register.vue'
import UserHome from '../components/user/pages/Home'
import UserProgram from '../components/user/pages/Program'
import UserProfile from '../components/user/pages/Profile'
import AdminLogin from '../components/admin/pages/Login.vue'
import AdminRegister from '../components/admin/pages/Register.vue'
import AdminProgram from '../components/admin/pages/Program'
import AdminWakafAbadi from '../components/admin/pages/WakafAbadi'
import AdminWakafBerjangka from '../components/admin/pages/WakafBerjangka'
import AdminKategoriWakaf from '../components/admin/pages/Kategori'
import UserWakafAbadi from '../components/user/pages/WakafAbadi'
import UserWakafBerjangka from '../components/user/pages/WakafBerjangka'
import ProgramDetail from '../components/user/pages/ProgramDetail'
import UserList from '../components/admin/pages/UserList.vue'
import AdminProgramDetail from '../components/admin/pages/ProgramDetail.vue'
import LandingPage from '../components/user/pages/LandingPage'
import ResetPassword from '../components/user/pages/ResetPassword'
import PageNotFound from '@/components/user/pages/PageNotFound'
import AboutUS from "@/components/user/pages/AboutUS";

Vue.use(Router)
const routes = [
  {
    path: '/home',
    meta: {
      layout: 'user-dashboard',
      requiresAuth: true,
      isAdmin: false
    },
    name: 'userhome',
    component: UserHome

  },
  {
    path: '/home/wakaf/abadi',
    meta: {
      layout: 'user-dashboard',
      requiresAuth: true,
      isAdmin: false
    },
    name: 'wakafabadiuser',
    component: UserWakafAbadi

  },
  {
    path: '/home/wakaf/berjangka',
    meta: {
      layout: 'user-dashboard',
      requiresAuth: true,
      isAdmin: false
    },
    name: 'wakafberjangkauser',
    component: UserWakafBerjangka


  },
  {
    path: '/',
    meta: {
      layout: 'landing-page',
      guest: true,
      isAdmin: false
    },
    name: 'landing-page',
    component: LandingPage,
  },
  {
    path: '/about-us',
    meta: {
      layout: 'user',
      guest: true,
      isAdmin: false
    },
    name: 'about-us',
    component: AboutUS

  },
  {
    path: '/programs/detail',
    meta: {
      layout: 'user',
      requiresAuth: true,
      isAdmin: false
    },
    name: 'program-detail',
    component: ProgramDetail

  },
  {
    path: '/profile',
    meta: {
      layout: 'user-dashboard',
      requiresAuth: true,
      isAdmin: false
    },
    name: 'userprofile',
    component: UserProfile

  },
  {
    path: '/programs',
    meta: {
      layout: 'user',
      requiresAuth: true,
      isAdmin: false
    },
    name: 'userprogram',
    component: UserProgram

  },
  {
    path: '/login',
    meta: {
      layout: 'user',
      guest : true,
    },
    name: 'userlogin',
    component: Login

  },
  {
    path: '/forgot-password/request',
    meta: {
      layout: 'user',
      guest: true,
    },
    name: 'forgotpasswordrequest',
    component: ResetPassword

  },
  {
    path: '/register',
    name: 'userregister',
    meta: {
      layout: 'user',
      guest: true,
    },
    component: Register

  },
  // {
  //     path: '/user',
  //     name: 'user',
  //     meta: { layout: "user" },
  //     // lazy-loaded
  //     component: () => import('../components/users/pages/Dashboard.vue')
  // },
  // {
  //     path: '/profile',
  //     name: 'profile',
  //     meta: { layout: "user" },
  //     // lazy-loaded
  //     component: () => import('../components/users/pages/Profile.vue')
  // },
  // //admin
  {
    path: '/admin',
    name: 'admin',
    meta: {
      layout: 'admin',
      requiresAuth: true,
      isAdmin: true
    },
    // lazy-loaded
    component: require('../components/admin/pages/Dashboard.vue').default

  },
  {
    path: '/admin/program',
    name: 'admin.program',
    meta: {
      layout: 'admin',
      requiresAuth: true,
      isAdmin: true
    },
    // lazy-loaded
    component: AdminProgram

  },
  {
    path: '/admin/program/detail',
    name: 'admin.program.detail',
    meta: {
      layout: 'admin',
      requiresAuth: true,
      isAdmin: true
    },
    // lazy-loaded
    component: AdminProgramDetail

  },
  {
    path: '/admin/wakif/all',
    name: 'admin.users',
    meta: {
      layout: 'admin',
      requiresAuth: true,
      isAdmin: true
    },
    // lazy-loaded
    component: UserList

  },
  {
    path: '/admin/wakaf/abadi',
    name: 'admin.abadi',
    meta: {
      layout: 'admin',
      requiresAuth: true,
      isAdmin: true
    },
    // lazy-loaded
    component: AdminWakafAbadi

  },
  {
    path: '/admin/wakaf/berjangka',
    name: 'admin.berjangka',
    meta: {
      layout: 'admin',
      requiresAuth: true,
      isAdmin: true
    },
    // lazy-loaded
    component: AdminWakafBerjangka

  },
  {
    path: '/admin/wakaf/kategori',
    name: 'admin.kategori',
    meta: {
      layout: 'admin',
      requiresAuth: true,
      isAdmin: true
    },
    // lazy-loaded
    component: AdminKategoriWakaf

  },
  {
    path: '/admin/login',
    name: 'admin-login',
    meta: {
      layout: 'admin-auth',
      guest : true,
    },
    // lazy-loaded
    component: AdminLogin

  },
  {
    path: '/admin/register',
    name: 'admin-register',
    meta: {
      layout: 'admin-auth',
      guest : true,
    },
    // lazy-loaded
    component: AdminRegister
  },
  { path: "*", component: PageNotFound }

]

const router = new Router({
  base: publicPath,
  mode : 'hash',
  routes
})

router.beforeEach((to, from, next) => {
  if(to.matched.some(record => record.meta.requiresAuth)) {
    if (localStorage.getItem('user') == null && localStorage.getItem('admin')==null) {
      next({
        path: '/login',
        params: { nextUrl: to.fullPath }
      })
    } else if(localStorage.getItem('admin') != null){
      let admin = JSON.parse(localStorage.getItem('admin'))

      if(to.matched.some(record => record.meta.isAdmin)) {
        if(admin){
          next()
        }
        else{
          next({ name: 'admin-login'})
        }
      }else {
        next({ name: 'admin-login'})
      }
    } else if(localStorage.getItem('user') != null){
      next()
    }
  } else if(to.matched.some(record => record.meta.guest)) {
    if(localStorage.getItem('user') == null || localStorage.getItem('admin') == null){
      next()
    } else if(localStorage.getItem('admin') != null){
      next({ name: 'admin'})
    }
    else if (localStorage.getItem('user') != null){
      next({ name: 'userhome'})
    }
  }else {
    next()
  }
})

export default router;

