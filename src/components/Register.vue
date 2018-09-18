<template>
    <div class='login-box'>
        <div class='login-content'>
            <div class='reg-close' @click='toLogin()'><span class='icon icon-remove'></span></div>
            <div :class="['auto-login',{'show':successShow}]">
                注册成功，现在登录? 
                <span class='icon icon-ok' @click='login()'></span>
                <span class='icon icon-remove' @click='toLogin()'></span>
            </div>
            <div class='login-item'>
                <div class='sys-title'>{{sysTitle}}</div>
                <div class='com-name'>{{comName}}</div>
                <div class='user-name'>
                    <input type="text" v-model='userName' autocomplete="off" :class='{error:hasError}'
                     placeholder="用户名/长度不小于3个字符" maxlength="10"/>
                </div>
                <div class='user-pwd'>
                    <input type="password" v-model='userPwd' autocomplete="new-password" :class='{error:hasError}' 
                    placeholder='密码/长度不小于6个字符' maxlength="16"/>
                </div>
                <div class='user-pwd'>
                    <input type="password" v-model='confirmPwd' autocomplete="new-password" :class='{error:hasError}' 
                    placeholder='确认密码' maxlength="16"/>
                </div>
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
            sysTitle:'注册',
            comName:'注册新的账号',
            userName:'',
            userPwd:'',
            confirmPwd:'',
            hasError:false,
            copyRight:'',
            stay:false,
            successShow:false,
            prjid:3
        }
    },
    mounted(){
    },
    methods:{
        toLogin(){
            this.$router.push('/login');
        },
        login(){
            if(this.userName != '' && this.userPwd != ''){
                this.$http.post('http://lgkj.chuangkegf.com/wuchuang/login.php',
                {
                    uname:this.userName,
                    upwd:this.userPwd,
                    statelog:0,
                    prjid:this.prjid,
                    kind:'login'
                },{emulateJSON:true}).then((res)=>{
                    if(res.body.code == 200){
                        localStorage.setItem('userid', res.body.userid);
                        localStorage.setItem('uname', this.userName);
                        this.$router.replace('/');
                    }else if(res.body.code == 400){
                        this.$router.replace('/login');
                    }
                },(err)=>{
                    console.log(err);
                })
            }
        },
        register(){
            if(this.userName.length>=3 && this.userPwd.length >=6 && this.userPwd === this.confirmPwd){
                this.$http.post('http://lgkj.chuangkegf.com/wuchuang/register.php',
                {
                    uname:this.userName,
                    upwd:this.userPwd,
                    prjid:this.prjid
                },{emulateJSON:true}).then((res)=>{
                    console.log(res.body);
                    if(res.body.code == 200){
                        this.successShow = true;
                    }else if(res.body.code == 400){
                        alert('注册失败');
                    }else if(res.body.code == 300){
                        alert('用户名已经存在！');
                    }
                },(err)=>{
                    console.log(err);
                })
            }else if(this.userName.length<3 || this.userPwd <6){
                alert('用户名或密码长度不足');
            }else if(this.userPwd !== this.confirmPwd){
                alert('两次密码不同');
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

