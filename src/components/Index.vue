<template>
    <!--主页面-->
    <div class='index-box'>
        <div :class="['toggle-icon',{'show':showNav}]" @click="navShow()"><span class='icon icon-align-left '></span></div>
        <div class='index-nav'>
            <div class='logo'><img src="../assets/images/logo.png" alt="" /></div>
            <div class='app-name'>{{appName}}&nbsp;&nbsp;<span>&nbsp;{{comName}}</span></div>
            <div class='user-tools'>
                <!-- <span class="icon-cog" @click='setSys()'></span>
                <span class="icon-off" @click='offSys()'></span> -->
                <div class='notice-tool'>
                    <!-- <div :class="['tool-items',{'active':notice}]" @click="toggleNotice">
                        <span class='icon icon-comment-alt'></span>
                        <span class='notice-count'>2</span>
                    </div> -->
                    <div :class="['notice-item',{'show':hasNotice}]">
                        <p>{{noticeInfo}}</p>
                        <span v-if="hasNotice"></span>
                    </div>
                    <ul class='tool-list' v-if='notice'>
                        <li @click="showNotice('已读信息已读信息已读信息已读信息已读信息已读信息')"><a><span class='notice-yes icon icon-circle'></span>已读信息已读信息已读信息</a></li>
                        <li><a href=""><span class='notice-no icon icon-circle'></span>未读信息未读信息未读信息</a></li>
                    </ul>
                </div>
                <div class='help-tool'>
                    <div :class="['tool-items',{'active':help}]" @click="toggleHelp">
                        <span class='icon icon-question-sign'></span>
                        <span class='show-text sm-hide'>帮助</span>
                        <span class='icon icon-angle-down sm-hide'></span>
                    </div>
                    <ul class='tool-list' v-if='help'>
                        <!-- <li><a href="">彩票玩法</a></li> -->
                        <li><a href="">网站公告</a></li>
                    </ul>
                </div>
                <div class='usercenter-tool'>
                    <div :class="['tool-items',{'active':user}]" @click="toggleUser">
                        <img src="../assets/images/avatar.png" alt="">
                        <span class='show-text sm-hide'>{{userName}}</span>
                        <span class='icon icon-angle-down sm-hide'></span>
                    </div>
                    <ul class='tool-list' v-if='user'>
                        <!-- <li @click='toIndex()' style='display:none;' class='sm-show'><a>首页</a></li> -->
                        <li @click='toAccount()'><a>账户中心</a></li>
                        <li @click='toAccount()'><a>订单中心</a></li>
                        <li @click='offSys()'><a href="">登出</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class='index-content'>
            <div :class="['left-nav',{'show':showNav}]">
                <div class='touser-center' v-if='uKind == 0'>
                    <div @click='toAccount()' class='mybtn'><span class='icon icon-gift'></span>充值</div>
                    <div @click='toAccount()' class='mybtn'><span class='icon icon-gift'></span>提现</div>
                </div>
                <div class='nav-list-box'>
                    <ul>
                        <li :class='{active:item.isActive}' v-for='(item,index) in navList' :key='index' @click="changePage(index,item.path)">
                            <span :class="[toggleIcon(item.icon),{'slide-left':slideToggle}]"></span>{{item.title}}
                        </li>
                    </ul>
                </div>
                <!-- <div class='nav-toggle' @click='slide()'>
                    <span :class="['icon-arrow-left',{'icon-arrow-right':slideToggle}]"></span>
                </div> -->
            </div>
            <div class='left-nav-line'>
                <ul>
                    <li :class='{active:item.isActive}' v-for='(item,index) in navList' :key='index' @click="changePage(index,item.path)">
                        <span :class="toggleIcon(item.icon)"></span>
                    </li>
                </ul>
            </div>
            <div :class="['right-content',{'slide-left':slideToggle},{'set-toggle':setToggle}]">
                <router-view @getNum='rcvMsg' @showNotice='showNotice'></router-view>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    data () {
        return {
            logo:'../assets/images/logo.png',
            appName: '',
            comName:'',
            isAreaHide:true,
            currArea:'选择大区',
            noticeInfo:'当前彩票已经开奖！',
            hasNotice:false,
            navList:[],
            userName:'未登录',
            uid:0,
            uKind:0,
            slideToggle:false,
            setToggle:false,
            notice:false,
            help:false,
            user:false,
            showNav:false
        }
    },
    mounted(){
        this.$http.get('http://lgkj.chuangkegf.com/wuchuang/check.php').then((res)=>{
            if(res.body.code == 400){
                //this.$router.replace('/login');
            }else if(res.body.code == 200){
                if(!sessionStorage.getItem('login')){
                    sessionStorage.setItem('login',true);
                }
                this.userName = res.body.uname;
                this.uid = res.body.uid;
                this.uKind = res.body.ukind;
                if(this.uKind == 1){
                    this.comName = '后台管理平台';
                }
                this.$http.post('http://lgkj.chuangkegf.com/wuchuang/pagekind.php',{
                    kind:'gettab',
                    userkind:this.uKind
                },{emulateJSON:true}).then((res)=>{
                    if(res.body.code == 200){
                        var that = this;
                        res.body.data.map(function(item,index){
                            that.navList.push({
                                title:item.pagename,
                                icon:item.icon,
                                isActive:item.pid==1?true:false,
                                path:item.pagepath,
                                pageNum:item.pid
                            })
                        })
                        if(sessionStorage.getItem('pagenum')){
                            var pagenum = sessionStorage.getItem('pagenum');
                            that.navList.map(function(item,index){
                                item.isActive = false;
                                if(item.pageNum == pagenum){
                                    item.isActive = true;
                                }
                            })
                        }else{
                            this.changePage(0,this.navList[0].path);
                        }
                    }
                },(err)=>{
                    console.log(err);
                })
            }
        },(err)=>{
            console.log(err);
        })
        // if(this.uKind == 1){
        //     this.appName = '后台管理平台';
        // }
        // this.$http.post('http://lgkj.chuangkegf.com/wuchuang/pagekind.php',{
        //     kind:'gettab',
        //     userkind:this.uKind
        // },{emulateJSON:true}).then((res)=>{
        //     if(res.body.code == 200){
        //         var that = this;
        //         res.body.data.map(function(item,index){
        //             that.navList.push({
        //                 title:item.pagename,
        //                 icon:item.icon,
        //                 isActive:false,
        //                 path:item.pagepath,
        //                 pageNum:item.pid
        //             })
        //         })
        //         console.log(that.navList);
        //         if(sessionStorage.getItem('pagenum')){
        //             var pagenum = sessionStorage.getItem('pagenum');
        //             that.navList.map(function(item,index){
        //                 item.isActive = false;
        //                 if(item.pageNum == pagenum){
        //                     item.isActive = true;
        //                 }
        //             })
        //         }else{
        //             this.changePage(0,this.navList[0].path);
        //         }
        //     }
        // },(err)=>{
        //     console.log(err);
        // })
        var username = localStorage.getItem('uname');
        this.userName = username;
    },
    methods:{
        // toIndex(){
        //     this.$router.push({path:'/index'});
        //     this.notice = false;
        //     this.help = false;
        //     this.user = false;
        // },
        showNotice(msg){
            this.noticeInfo = msg;
            this.hasNotice = true;
            setTimeout(()=>{
                this.hasNotice = false;
            },5000);
        },
        toAccount(){
            this.$router.push({path:'/account'});
            this.notice = false;
            this.help = false;
            this.user = false;
            this.showNav = false;
        },
        toggleNotice(){
            if(this.notice == false){
                this.notice = true;
                this.help = false;
                this.user = false;
            }else{
                this.notice = false;
            }
        },
        toggleHelp(){
            if(this.help == false){
                this.notice = false;
                this.help = true;
                this.user = false;
            }else{
                this.help = false;
            }
        },
        toggleUser(){
            if(this.user == false){
                this.notice = false;
                this.help = false;
                this.user = true;
            }else{
                this.user = false;
            }
        },
        changePage(index,path){
            for(var i=0;i<this.navList.length;i++){
                this.navList[i].isActive = false;
            }
            this.navList[index].isActive = true;
            sessionStorage.setItem('pagenum',this.navList[index].pageNum);
            sessionStorage.setItem('title',this.navList[index].title);
            this.$router.replace({
                path:"/"+path,
                query:{
                    pageid:this.navList[index].pageNum,
                    pagename:this.navList[index].title
                }
            });
            this.showNav = false;
        },
        toggleIcon(icon){
            return icon;
        },
        chooseArea(index){
            this.currArea = this.areaList[index];
            this.isAreaHide = true;
        },
        toggleAreaBox(){
            if(this.isAreaHide == true){
                this.isAreaHide = false;
            }else{
                this.isAreaHide = true;
            }
        },
        rcvMsg(msg){
            for(var i=0;i<this.navList.length;i++){
               if(msg == this.navList[i].pageNum){
                  this.navList[i].isActive = true;
               }else{
                   this.navList[i].isActive = false;
               }
            }
        },
        offSys(){
            if(confirm('退出系统？')){
                var userid = localStorage.getItem('userid');
                if(userid){
                    this.$http.post('http://lgkj.chuangkegf.com/logout.php',
                    {
                        userid:userid,
                    },{emulateJSON:true}).then((res)=>{
                        if(res.body.code == 200){
                            this.$router.replace('/login');
                        }
                    },(err)=>{
                        console.log(err);
                    })
                }else{
                    alert('登录状态异常，无法退出！');
                }
            }
        },
        slide(){
            if(this.slideToggle == true){
                this.slideToggle = false;
            }else{
                this.slideToggle = true;
            }
        },
        navShow(){
            if(this.showNav == true){
                this.showNav = false;
            }else{
                this.showNav = true;
            }
        },
        setSys(){
            if(this.setToggle == true){
                this.setToggle = false;
            }else{
                this.setToggle = true;
            }
        }
    }
}
</script>
