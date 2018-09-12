import Vue from 'vue'
import Router from 'vue-router'
import Resource from 'vue-resource'
import IndexPage from '@/components/Index'
import MainInfo from '@/components/MainInfo'
import Login from '@/components/Login'
import Register from '@/components/Register'
import AccountCenter from '@/components/AccountCenter'
import ActivePage from '@/components/ActivePage'
import BeiJing from '@/components/BeiJing'
import ChongQing from '@/components/ChongQing'
import PageAdmin from '@/components/PageAdmin'
import UserAdmin from '@/components/UserAdmin'

Vue.use(Router)
Vue.use(Resource)

export default new Router({
  routes: [
    {
      path: '/',
      component: IndexPage,
      children:[
        {
          path:'/',
          component:MainInfo
        },
        {
          path:'/maininfo',
          component:MainInfo
        },
        {
          path:'/account',
          component:AccountCenter
        },
        {
          path:'/active',
          component:ActivePage
        },
        {
          path:'/beijing',
          component:BeiJing
        },
        {
          path:'/chongqing',
          component:ChongQing
        },
        {
          path:'/pageadmin',
          component:PageAdmin
        },
        {
          path:'/useradmin',
          component:UserAdmin
        }
      ]
    },
    {
      path: '/index',
      component: IndexPage,
      children:[
        {
          path:'/',
          component:MainInfo
        },
        {
          path:'/maininfo',
          component:MainInfo
        },
        {
          path:'/account',
          component:AccountCenter
        },
        {
          path:'/active',
          component:ActivePage
        },
        {
          path:'/beijing',
          component:BeiJing
        },
        {
          path:'/chongqing',
          component:ChongQing
        },
        {
          path:'/pageadmin',
          component:PageAdmin
        },
        {
          path:'/useradmin',
          component:UserAdmin
        }
      ]
    },
    {
      path:'/login',
      component:Login
    },
    {
      path:'/register',
      component:Register
    }
  ]
})
