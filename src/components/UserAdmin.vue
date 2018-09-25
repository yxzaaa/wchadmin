<template>
    <div class='main-admin-box'>
        <ul class='page-list-box panel-box'>
            <li class='page-list-item panel' v-for='(item,index) in userData' :key='index'>
                <div>
                    <span class='icon icon-user'></span>{{item.username}}
                </div>
                <span class='set-page-code icon icon-rss' @click.stop @click='showMoreInfo(index)'></span>
                <div>
                    <p class='expect'>账户余额 <span> {{item.restmoney}} 元</span></p>
                    <p class='expect'>绑定卡号 <span> {{item.usercardnum}}</span></p>
                    <p class='expect'>户主姓名 <span> {{item.cardname}}</span></p>
                    <p class='expect'>开户银行 <span> {{item.cardopen}}</span></p>
                </div>
            </li>
        </ul>
        <div class='modal-content' v-if='modal'>
            <div class='modal-box panel' v-if='modalCode == 1'>
                <div class='panel-title'>{{currUserData.username}}--投注历史</div>
                <div class='page-list'>
                    <ul>
                        <li v-for='(item,index) in currHisData' :key='index'>
                            <div>彩种 <span>{{item.pagename}}</span></div>
                            <div>期号 <span>{{item.expect}}</span></div>
                            <div>支出 <span>{{item.pagepay}} 元</span></div>
                            <div>收益 <span>{{item.pageget}} 元</span></div>
                        </li>
                    </ul>
                </div>
                <div class='modal-btn-box'>
                    <span class='mybtn' @click='confirmModal(1)'>确定</span>
                    <span class='mybtn' @click='closeModal()'>取消</span>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import '../assets/css/admin.css';
export default {
    data(){
        return {
            modal:false,
            modalCode:0,
            userData:[],
            userName:'',
            userId:'',
            currUserData:[],
            currHisData:[]
        }
    },
    mounted(){
        this.userName = localStorage.getItem('uname');
        this.userId = localStorage.getItem('userid');
        this.getUsersData();
    },
    methods:{
        getUsersData(){
            this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
                kind:'getallusers',
                username:this.userName,
                userid:this.userId
            },{emulateJSON:true}).then((res)=>{
                this.userData = res.body.data;
            },(err)=>{
                console.log(err);
            })
        },
        showMoreInfo(index){
            this.modal = true;
            this.modalCode = 1;
            this.currUserData = this.userData[index];
            this.currHisData = [];
            this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
                kind:'getuserhis',
                userid:this.currUserData.userid,
                username:this.currUserData.username
            },{emulateJSON:true}).then((res)=>{
                console.log(res.body.data);
                if(res.body.code == 200 && res.body.data){
                    this.currHisData = res.body.data;
                }
            })
        },
        confirmModal(code){
            this.modal = false;
            this.modalCode = 0;
        },
        closeModal(){
            this.modal = false;
            this.modalCode = 0;
        }
    }
}
</script>

