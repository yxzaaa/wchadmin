<template>
    <div class='login-box'>
        <div class='login-content'>
            <div class='login-item'>
                <div class='sys-title'>{{sysTitle}}</div>
                <div class='com-name'>{{comName}}</div>
                <div class='user-name'>
                    <input type="text" v-model='userName' autocomplete="off" :class='{error:hasError}' placeholder="请输入用户名" maxlength="10"/>
                </div>
                <div class='user-pwd'>
                    <input type="password" v-model='userPwd' autocomplete="new-password" :class='{error:hasError}' placeholder='请输入密码' maxlength="16"/>
                </div>
                <div class='stayIn'><span type='checkbox' :class="['icon-ok',{stayActive:stay}]" @click='setStay()' id='1'></span><label for='1'>自动登录？</label></div>
                <div class='login-btn' @click='login()'>登录</div>
                <div class='login-btn' @click='register()'>注册</div>
            </div>
            <div class='login-img'>
                <img src="../assets/images/loginbg.jpg" alt="1">
            </div>
        </div>
    </div>
</template>
<script>
import '../assets/css/login.css';
export default {
    data(){
        return {
            sysTitle:'伍创国际',
            comName:'登录您的账号',
            userName:'',
            userPwd:'',
            hasError:false,
            copyRight:'',
            stay:false,
            prjid:3
        }
    },
    mounted(){
        var userid = localStorage.getItem('userid');
        if(userid){
            this.$http.post('http://lgkj.chuangkegf.com/wuchuang/login.php',
            {
                userid:userid,
                kind:'check'
            },{emulateJSON:true}).then((res)=>{
                if(res.body.code == 200){
                    localStorage.setItem('uname', res.body.uname);
                    this.$router.replace('/');
                }
            },(err)=>{
                console.log(err);
            })
        }
    },
    methods:{
        register(){
            this.$router.push('/register');
        },
        login(){
            if(this.userName != '' && this.userPwd != ''){
                this.$http.post('http://lgkj.chuangkegf.com/wuchuang/login.php',
                {
                    uname:this.userName,
                    upwd:this.userPwd,
                    statelog:this.stay == true?1:0,
                    prjid:this.prjid,
                    kind:'login'
                },{emulateJSON:true}).then((res)=>{
                    if(res.body.code == 200){
                        localStorage.setItem('userid', res.body.userid);
                        localStorage.setItem('uname', this.userName);
                        this.$router.replace('/');
                    }else if(res.body.code == 400){
                        this.hasError = true;
                        setTimeout(()=>{
                            this.hasError = false;
                        },300);
                    }
                },(err)=>{
                    console.log(err);
                })
            }
        },
        setStay(){
            if(this.stay == false){
                this.stay = true;
            }else{
                this.stay = false;
            }
        }
    }
}
</script>

