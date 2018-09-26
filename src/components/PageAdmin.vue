<template>
    <div class='main-admin-box'>
        <ul class='page-list-box panel-box'>
            <li class='page-list-item panel' @click='showDetail(index)' v-for='(item,index) in pageData' :key='index'>
                <div>
                    <span :class="['icon',item.icon]"></span>{{item.pagename}}
                </div>
                <span class='set-page-code icon icon-cog' @click.stop @click='changeCode(index)'></span>
                <div>
                    <p class='expect'>第<span>{{item.expect}}</span>期</p>
                    <p class='opencode'>
                        中奖号码<span>{{item.opencode}}</span>
                    </p>
                </div>
            </li>
        </ul>
        <div class='modal-content' v-if='modal'>
            <div class='modal-box panel' v-if='modalCode == 1'>
                <div class='panel-title'>{{currPageData.pagename}}</div>
                <div class='modal-item'>
                    <div class='currpage-info'>
                        <div>本期期号<span>{{currPageData.expect}}</span></div>
                        <div>开奖号码<span>{{currPageData.opencode}}</span></div>
                        <div>开奖时间<span>{{currPageData.opentime}}</span></div>
                    </div>
                    <h3 class='panel-title'>历史开奖</h3>
                    <div class='his-list'>
                        <ul>
                            <li v-for='(item,index) in currHisData' :key='index'>
                                <div>期号<span>{{item.expect}}</span></div>
                                <div>开奖号码<span>{{item.opencode}}</span></div>
                                <div>开奖时间<span>{{item.opentime}}</span></div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class='modal-btn-box'>
                    <span class='mybtn' @click='confirmModal(1)'>确定</span>
                    <span class='mybtn' @click='closeModal()'>取消</span>
                </div>
            </div>
            <div class='modal-box panel' v-if='modalCode == 2'>
                <div class='panel-title'>{{currPageData.pagename}}，第{{currPageData.expect}}期开奖号码</div>
                <div class='modal-item'>
                    <p class='modal-notice'>输入开奖号码，以,;或空格分割。请保证位数正确</p>
                    <div class='input-pay'><input type="text" maxlength="20" v-model="currOpenCode"></div>
                </div>
                <div class='modal-btn-box'>
                    <span class='mybtn' @click='confirmModal(2)'>确定</span>
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
            pageData:[],
            userName:'',
            userId:'',
            currPageData:[],
            currHisData:[],
            currOpenCode:''
        }
    },
    mounted(){
        this.userName = localStorage.getItem('uname');
        this.userId = localStorage.getItem('userid');
        this.$http.post('http://lgkj.chuangkegf.com/wuchuang/pagekind.php',{
            kind:'getallpage',
            username:this.userName,
            userid:this.userId
        },{emulateJSON:true}).then((res)=>{
            this.pageData = res.body.data;
        },(err)=>{
            console.log(err);
        })
        this.getPageData();
    },
    methods:{
        getPageData(){
            var timer = setInterval(()=>{
                this.$http.post('http://lgkj.chuangkegf.com/wuchuang/pagekind.php',{
                    kind:'getallpage',
                    username:this.userName,
                    userid:this.userId
                },{emulateJSON:true}).then((res)=>{
                    this.pageData = res.body.data;
                },(err)=>{
                    console.log(err);
                })
            },5000)
        },
        showDetail(index){
            this.modal = true;
            this.modalCode = 1;
            this.currPageData = this.pageData[index];
            this.$http.post('http://lgkj.chuangkegf.com/wuchuang/getpageinfo.php',{
                kind:'gethisinfo',
                pageid:this.currPageData.pid,
                pagename:this.currPageData.pagename
            },{emulateJSON:true}).then((res)=>{
                if(res.body.code == 200){
                    this.currHisData = res.body.data;
                }
            })
        },
        changeCode(index){
            this.modal = true;
            this.modalCode = 2;
            this.currPageData = this.pageData[index];
        },
        confirmModal(code){
            this.modal = false;
            this.modalCode = 0;
            if(code == 2){
                console.log(this.currPageData.expect);
                console.log(this.currPageData.pid);
                console.log(this.currOpenCode);
                this.currOpenCode = this.currOpenCode.split(/[,; ，；]/).join(',');
                this.$http.post('http://lgkj.chuangkegf.com/wuchuang/pagekind.php',{
                    kind:'changecode',
                    pid:this.currPageData.pid,
                    expect:this.currPageData.expect,
                    code:this.currOpenCode
                },{emulateJSON:true}).then((res)=>{
                    if(res.body.code == 200){
                        alert('修改成功');
                        this.$http.post('http://lgkj.chuangkegf.com/wuchuang/pagekind.php',{
                            kind:'getallpage',
                            username:this.userName,
                            userid:this.userId
                        },{emulateJSON:true}).then((res)=>{
                            this.pageData = res.body.data;
                        },(err)=>{
                            console.log(err);
                        })
                    }else{
                        alert('当前期号已开奖');
                    }
                })
            }
        },
        closeModal(){
            this.modal = false;
            this.modalCode = 0;
        }
    }
}
</script>

