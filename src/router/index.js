import Vue from 'vue'
import Router from 'vue-router'
import Resource from 'vue-resource'
import IndexPage from '@/components/Index'
import Login from '@/components/Login'
import Register from '@/components/Register'
import PageAdmin from '@/components/PageAdmin'
import UserAdmin from '@/components/UserAdmin'
import PayAdmin from '@/components/PayAdmin'

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
          component:PageAdmin
        },
        {
          path:'/pageadmin',
          component:PageAdmin
        },
        {
          path:'/useradmin',
          component:UserAdmin
        },
        {
          path:'/payadmin',
          component:PayAdmin
        }
      ]
    },
    {
      path: '/index',
      component: IndexPage,
      children:[
        {
          path:'/',
          component:PageAdmin
        },
        {
          path:'/pageadmin',
          component:PageAdmin
        },
        {
          path:'/useradmin',
          component:UserAdmin
        },
        {
          path:'/payadmin',
          component:PayAdmin
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
