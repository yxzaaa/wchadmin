<template>
    <div class='main-page-box page-box'>
        <!-- <div class='scroll-box'>
            <div>公告</div>
            <marquee class='scroll-content'><span>Welcom CSDN!</span></marquee>
        </div> -->
        <div class='main-banner panel-box' id='mainBanner'>
            <ul class='slide-box' :style="{width:slideWidth+'px',left:'-'+Left+'px'}" id='slideList'>
                <li v-for='(item,index) in slideData' :key='index' class='banner-item' :style="{width:slideBoxWidth+'px'}"><img :src="item.src" alt=""></li>
            </ul>
            <ul class='slide-sign'>
                <li v-for='(item,index) in slideData' :key='index' :class="{'active':item.isActive}"></li>
            </ul>
        </div>
        <div class='to-center panel'>
            <div @click='toAccount()' class='mybtn'><span class='icon icon-gift'></span>充值</div>
            <div @click='toAccount()' class='mybtn'><span class='icon icon-gift'></span>提现</div>
        </div>
        <div class='nav-btns-box panel'>
            <h3 class='panel-title'>热门彩种</h3>
            <ul>
                <li v-for='(item,index) in navList' :key='index' @click='jump(index)'>
                    <img src="../assets/images/page.png" alt="">
                    <!-- <span :class="['icon',item.icon]"></span> -->
                    <p>{{item.title}}</p>
                </li>
            </ul>
        </div>
        <div class='main-box panel-box'>
            <div class='user-info-box panel'>
                <h3 class='panel-title'><span class='icon icon-user' style='padding-right:10px;display:inline-block;font-size:16px;'></span>个人信息</h3>
                <div>
                    <div class='main-avatar'>
                        <img src="../assets/images/avatar.png" alt="">
                    </div>
                    <h4 class='user-name'>
                        {{userName}}
                    </h4>
                    <div class='main-pay-detail'>
                        账户余额：<span>{{restMoney}}</span>
                        <!-- <span class='pay-btn'>充值</span> -->
                    </div>
                    <div class='main-pay-detail'>
                        可提现金额：<span>{{restMoney}}</span>
                        <!-- <span class='pay-btn'>提款</span> -->
                    </div>
                </div>
            </div>
            <div class='notice-web-box panel'>
                <h3 class='panel-title'><span class='icon  icon-bell' style='padding-right:10px;display:inline-block;font-size:16px;'></span>通知公告</h3>
                <div>
                    <ul></ul>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import '../assets/css/maininfo.css';
export default {
    data(){
        return {
            slideData:[
                {
                    isActive:true,
                    src:'/static/img/index-ban.png',
                },
                {
                    isActive:false,
                    src:'/static/img/index-ban1.png',
                },
                {
                    isActive:false,
                    src:'/static/img/index-ban1.png',
                },
            ],
            slideWidth:0,
            slideBoxWidth:0,
            Left:0,
            userName:'未登录',
            restMoney:0.00,
            navList:[]
        }
    },
    mounted(){
        this.$emit('getNum',sessionStorage.getItem('pagenum'));
        //轮播图代码
        this.slideBoxWidth = document.getElementById('mainBanner').clientWidth;
        this.slideWidth = this.slideData.length*this.slideBoxWidth;
        this.slideAuto();
        var that = this;
        window.onresize = function(){
            that.setSlide();
        }
        //轮播代码结束
        var username = localStorage.getItem('uname');
        var userid = localStorage.getItem('userid');
        this.userName = username;
        this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
            kind:'maininfo',
            userid:userid,
            username:username,
        },{emulateJSON:true}).then((res)=>{
            console.log(res);
            if(res.body.code == 200){
                this.restMoney = res.body.data[0];
            }
        },(err)=>{
            console.log(err);
        })
        this.$http.post('http://lgkj.chuangkegf.com/wuchuang/pagekind.php',{
            kind:'gettab',
            userkind:0
        },{emulateJSON:true}).then((res)=>{
            if(res.body.code == 200){
                var that = this;
                res.body.data.map(function(item,index){
                    that.navList.push({
                        title:item.pagename,
                        icon:item.icon,
                        img:item.pageimg,
                        path:item.pagepath,
                        pageNum:item.pid
                    })
                })
                that.navList.shift();
            }
        },(err)=>{
            console.log(err);
        })
    },
    methods:{
        toAccount(){
            this.$router.push({path:'/account'});
            this.help = false;
            this.user = false;
        },
        jump(index){
            sessionStorage.setItem('pagenum',this.navList[index].pageNum);
            sessionStorage.setItem('title',this.navList[index].title);
            this.$router.replace({
                path:"/"+this.navList[index].path,
                query:{
                    pageid:this.navList[index].pageNum,
                    pagename:this.navList[index].title
                }
            });
        },
        setSlide(){
            try{
                this.slideBoxWidth = document.getElementById('mainBanner').clientWidth;
                this.slideWidth = this.slideData.length*this.slideBoxWidth;
            }catch(res){
                console.log(res);
            }
        },
        slideAuto(){
            var page = 0;
            var that = this;
            var timer = setInterval(function(){
                page++;
                if(page == that.slideData.length){
                    page = 0;
                    that.Left = that.slideBoxWidth*page;
                }else{
                    that.Left = that.slideBoxWidth*page;
                }
                that.slideData.map(function(item,index){
                    if(index == page){
                        item.isActive = true;
                    }else{
                        item.isActive = false;
                    }
                })
            },5000)
        }
    }
}
</script>

