<template>
    <div class='center-box page-box'>
        <div class='center-content panel'>
            <ul class='center-tab'>
                <li :class="['center-tab-item',{'active':toggleTab == 1}]" @click='changeTab(1)'>充值申请</li>
                <li :class="['center-tab-item',{'active':toggleTab == 2}]" @click='changeTab(2)'>提现申请</li>
            </ul>  
            <ul class='page-list-box panel-box' v-if='toggleTab == 1' style="background:#fafafa;">
                <li :class="['page-list-item panel',{'state-no':item.resultstate=='未处理'},{'state-yes':item.resultstate=='已通过'},{'state-error':item.resultstate=='已驳回'}]" v-for='(item,index) in addRequestData' :key='index'>
                    <div class='user-request'>
                        <p class='opencode'>
                            用户<span>{{item.username}}</span>
                        </p>
                        <p class='opencode'>
                            卡号<span>{{item.cardnum}}</span>
                        </p>
                        <p class='opencode'>
                            金额<span>{{item.rnum}} 元</span>
                        </p>
                    </div>
                    <div class='btn-group' v-if='item.rstate == 0'>
                        <div class='mybtn' @click='throughRequest(item.rid,"充值",item.username,item.userid,item.rnum)'>通过</div>
                        <div class='mybtn' @click='stopRequest(item.rid,item.username,item.userid)'>驳回</div>
                    </div>
                    <div class='btn-group' v-if='item.rstate == 1'>
                        <div>{{item.resultstate}}</div>
                    </div>
                </li>
            </ul>
            <ul class='page-list-box panel-box' v-if='toggleTab == 2' style="background:#fafafa;">
                <li :class="['page-list-item panel',{'state-no':item.resultstate=='未处理'},{'state-yes':item.resultstate=='已通过'},{'state-error':item.resultstate=='已驳回'}]" v-for='(item,index) in getRequestData' :key='index'>
                    <div class='user-request'>
                        <p class='opencode'>
                            用户<span>{{item.username}}</span>
                        </p>
                        <p class='opencode'>
                            卡号<span>{{item.cardnum}}</span>
                        </p>
                        <p class='opencode'>
                            金额<span>{{item.rnum}} 元</span>
                        </p>
                    </div>
                    <div class='btn-group' v-if='item.rstate == 0'>
                        <div class='mybtn' @click='throughRequest(item.rid,"提现",item.username,item.userid,item.rnum)'>通过</div>
                        <div class='mybtn' @click='stopRequest(item.rid,item.username,item.userid)'>驳回</div>
                    </div>
                    <div class='btn-group' v-if='item.rstate == 1'>
                        <div>{{item.resultstate}}</div>
                    </div>
                </li>
            </ul>
        </div>
        <div class='modal-content' v-if='modal'>
            <div class='modal-box panel'>
                <div class='panel-title'>{{currModalTitle}}</div>
                <div class='modal-item'>
                    <p class='modal-notice'>{{currModaldus}}</p>
                    <div class='input-pay' v-if='currModalKind == 0'><input type="text" maxlength="10" v-model="newName"></div>
                    <div class='input-pay' v-if='currModalKind == 1'><input type="number" v-model="addMoney"> 元</div>
                    <div class='input-pay' v-if='currModalKind == 2'><input type="number" v-model="getMoney"> 元</div>
                    <div v-if='currModalKind == 3'></div>
                    <ul class='input-pwd' v-if='currModalKind == 4'>
                        <li><span>旧密码</span><input type="password" placeholder="请输入旧密码" maxlength="16" v-model="oldUserPwd"></li>
                        <li><span>新密码</span><input type="password" placeholder="请输入新密码" maxlength="16" v-model="newUserPwd"></li>
                        <li><span>确认新密码</span><input type="password" placeholder="请确认新密码" maxlength="16" v-model="cNewUserPwd"></li>
                    </ul>
                    <ul class='input-pwd' v-if='currModalKind == 5'>
                        <li><span>旧密码</span><input type="password" placeholder="请输入旧密码" maxlength="16" v-model="oldMoneyPwd"></li>
                        <li><span>新密码</span><input type="password" placeholder="请输入新密码" maxlength="16" v-model="newMoneyPwd"></li>
                        <li><span>确认新密码</span><input type="password" placeholder="请确新密码" maxlength="16" v-model="cNewMoneyPwd"></li>
                    </ul>
                    <ul class='input-pwd' v-if='currModalKind == 6'>
                        <li><span>姓名</span><input type="text" placeholder="请输入真实姓名" maxlength="16" v-model="cardName"></li>
                        <li><span>开户银行</span><input type="text" placeholder="请输入银行卡开户行" maxlength="64" v-model="cardOpen"></li>
                        <li><span>银行卡号</span><input type="text" placeholder="请输入银行卡号" maxlength="32" v-model="cardNum"></li>
                    </ul>
                    <div class='input-pay' v-if='currModalKind == 7'><input type="password" v-model="moneyPwd"/></div>
                    <div class='input-pay' v-if='currModalKind == 8'><input type="password" v-model="moneyPwd"/></div>
                </div>
                <div class='modal-btn-box'>
                    <span class='mybtn' @click='confirmModal(currModalKind)'>确定</span>
                    <span class='mybtn' @click='canelModal()'>取消</span>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import '../assets/css/account.css';
export default {
    data(){
        return{
            toggleTab:1,
            orderTab:1,
            currModalTitle:'充值',
            currModaldus:'',
            currModalKind:1,
            modal:false,
            userName:'未登录',
            userId:'',
            startpage:0,
            pagesize:10,
            totalPage:0,
            currPage:1,
            totalDataCount:0,
            addRequestData:[],
            getRequestData:[]
        }
    },
    mounted(){
        this.toggleTab = 1;
        this.userName = localStorage.getItem('uname');
        this.userId = localStorage.getItem('userid');
        this.refreshData();
    },
    watch: {
        $route: {
            handler: function (val, oldVal) {
                this.toggleTab = this.$route.query.tab;
            },
            deep: true
        },
        pagesize:{
            handler:function(val,oldVal){
                this.currPage = 1;
                this.startpage = 0;
                this.pagesize = parseInt(val);
                this.orderTab == 1?this.getListData():this.getHisData();
            }
        }
    },
    methods:{
        // 通过请求
        throughRequest(id,type,username,userid,pay){
            if(confirm('确认通过本次申请？')){
                if(type == '充值'){
                    this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
                        kind:'reqsuccess',
                        rid:id,
                        type:0,
                        username:username,
                        userid:userid
                    },{emulateJSON:true}).then((res)=>{
                        console.log(res);
                        if(res.body.code == 200){
                            this.refreshData();
                        }
                    },(err)=>{
                        console.log(err);
                    })
                }else if(type == '提现'){
                    this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
                        kind:'reqsuccess',
                        rid:id,
                        type:1,
                        username:username,
                        userid:userid
                    },{emulateJSON:true}).then((res)=>{
                        if(res.body.code == 200){
                            this.refreshData();
                        }
                    },(err)=>{
                        console.log(err);
                    })
                }
            }
        },
        // 驳回请求
        stopRequest(id,username,userid){
            console.log(username);
            console.log(userid);
            if(confirm('确认驳回本次申请？')){
                this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
                    kind:'reqerror',
                    rid:id,
                    username:username,
                    userid:userid
                },{emulateJSON:true}).then((res)=>{
                    if(res.body.code == 200){
                        this.refreshData();
                    }
                },(err)=>{
                    console.log(err);
                })
            }
        },
        refreshData(){
            this.addRequestData = [];
            this.getRequestData = [];
            this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
                kind:'getrequests'
            },{emulateJSON:true}).then((res)=>{
                if(res.body.code == 200){
                    var data = res.body.data;
                    console.log(data);
                    data.map((item,index)=>{
                        if(item.rkind == 1){
                            this.addRequestData.push(item);
                        }else{
                            this.getRequestData.push(item);
                        }
                    })
                }
                this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
                    kind:'gethisres'
                },{emulateJSON:true}).then((res)=>{
                    if(res.body.code == 200){
                        var data = res.body.data;
                        console.log(data);
                        data.map((item,index)=>{
                            if(item.rkind == 1){
                                this.addRequestData.push(item);
                            }else{
                                this.getRequestData.push(item);
                            }
                        })
                    }
                },(err)=>{
                    console.log(err);
                })
            },(err)=>{
                console.log(err);
            })
        },
        changeTab(index){
            this.toggleTab = index;
        },
        canelModal(){
            this.modal = false;
        },
        showModal(kind){
            switch(kind){
                case 0:
                    this.currModalTitle = '修改昵称';
                    this.currModaldus = '昵称不低于3个字符';
                    this.currModalKind = 0;
                    this.modal = true;
                    break;
                case 1:
                    if(this.pageData[2] != ''){
                        this.currModalTitle = '余额充值';
                        this.currModaldus = '请首先使用绑定的银行卡转账到商家账户';
                        this.currModalKind = 1;
                        this.modal = true;
                    }else{
                        this.$emit('showNotice','您尚未绑定银行卡');
                    }
                    break;
                case 2:
                    this.currModalTitle = '提现';
                    this.currModaldus = '提现金额需少于余额';
                    this.currModalKind = 2;
                    this.modal = true;
                    break;
                case 3:
                    this.currModalTitle = '解绑银行卡';
                    this.currModaldus = '解绑银行卡会导致后台无法正常处理您的充值或提现申请！';
                    this.currModalKind = 3;
                    this.modal = true;
                    break;
                case 4:
                    this.currModalTitle = '修改登录密码';
                    this.currModaldus = '修改登录密码可以提升账户安全,不少于6个字符';
                    this.currModalKind = 4;
                    this.modal = true;
                    break;
                case 5:
                    this.currModalTitle = '修改资金密码';
                    this.currModaldus = '修改资金密码可以提升账户安全,不少于6个字符';
                    this.currModalKind = 5;
                    this.modal = true;
                    break;
                case 6:
                    this.currModalTitle = '添加银行卡';
                    this.currModaldus = '请输入准确信息';
                    this.currModalKind = 6;
                    this.modal = true;
                    break;
                case 7:
                    if(this.pageData[2] != ''){
                        this.currModalTitle = '资金密码';
                        this.currModaldus = '请输入资金密码';
                        this.currModalKind = 7;
                        this.modal = true;
                    }else{
                        this.$emit('showNotice','您尚未绑定银行卡');
                    }
                    break;
                case 8:
                    if(this.pageData[2] != ''){
                        this.currModalTitle = '资金密码';
                        this.currModaldus = '请输入资金密码';
                        this.currModalKind = 8;
                        this.modal = true;
                    }else{
                        this.$emit('showNotice','您尚未绑定银行卡');
                    }
                    break;
            }
        },
        confirmModal(kind){
            switch(kind){
                case 0:
                    //修改昵称
                    if(this.newName.length>=3){
                        this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
                            kind:'changename',
                            userid:this.userId,
                            username:this.userName,
                            newname:this.newName
                        },{emulateJSON:true}).then((res)=>{
                            if(res.body.code == 200){
                                this.$emit('showNotice','修改成功');
                                this.$emit('changeName',this.newName);
                                this.userName = this.newName;
                                localStorage.setItem('uname',this.userName);
                                this.modal = false;
                                this.refreshData();
                            }else{
                                this.$emit('showNotice','修改失败');
                            }
                        },(err)=>{
                            console.log(err);
                        })
                    }else{
                       this.$emit('showNotice','昵称长度不足3个字符');
                    }
                    break;
                case 1:
                    //充值
                    if(this.addMoney>0){
                        this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
                            kind:'addmoney',
                            userid:this.userId,
                            username:this.userName,
                            addmoney:this.addMoney,
                            cardnum:this.pageData[2]
                        },{emulateJSON:true}).then((res)=>{
                            if(res.body.code == 200){
                                this.$emit('showNotice','申请已提交，待处理！ 如有疑问：请联系客服!');
                                this.modal = false;
                                this.refreshData();
                            }else{
                                this.$emit('showNotice','申请失败，请重试！');
                            }
                        },(err)=>{
                            console.log(err);
                        })
                    }else{
                        this.$emit('showNotice','请输入充值金额');
                    }
                    break;
                case 2:
                    //提现
                    if(this.getMoney <= parseFloat(this.pageData[0]) && this.getMoney>0){
                        this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
                            kind:'getmoney',
                            userid:this.userId,
                            username:this.userName,
                            getmoney:this.getMoney,
                            cardnum:this.pageData[2]
                        },{emulateJSON:true}).then((res)=>{
                            if(res.body.code == 200){
                                this.$emit('showNotice','申请已提交，待处理！ 如有疑问：请联系客服!');
                                this.modal = false;
                                this.refreshData();
                            }else{
                                this.$emit('showNotice','申请失败，请重试！');
                            }
                        },(err)=>{
                            console.log(err);
                        })
                    }else{
                        this.$emit('showNotice','余额不足');
                    }
                    break;
                case 3:
                    //解绑银行卡
                    this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
                        kind:'removecard',
                        userid:this.userId,
                        username:this.userName
                    },{emulateJSON:true}).then((res)=>{
                        if(res.body.code == 200){
                            this.$emit('showNotice','解绑成功！');
                            this.modal = false;
                            this.refreshData();
                        }else{
                            this.$emit('showNotice','解绑失败！');
                        }
                    },(err)=>{
                        console.log(err);
                    })
                    break;
                case 4:
                //修改登录密码
                    if(this.oldUserPwd.length>=6 && this.newUserPwd.length>=6 && this.cNewUserPwd.length>=6
                    && this.newUserPwd == this.cNewUserPwd){
                        this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
                            kind:'changeuserpwd',
                            userid:this.userId,
                            username:this.userName,
                            newpwd:this.newUserPwd,
                            oldpwd:this.oldUserPwd
                        },{emulateJSON:true}).then((res)=>{
                            if(res.body.code == 200){
                                this.$emit('showNotice','登录密码，修改成功');
                                this.modal = false;
                                this.refreshData();
                            }else if(res.body.code == 300){
                                this.$emit('showNotice','修改失败');
                            }else if(res.body.code == 400){
                                this.$emit('showNotice','登录密码错误');
                            }
                        },(err)=>{
                            console.log(err);
                        })
                    }
                    break;
                case 5:
                    if(this.oldMoneyPwd.length>=6 && this.newMoneyPwd.length>=6 && this.cNewMoneyPwd.length>=6
                    && this.newMoneyPwd == this.cNewMoneyPwd){
                        this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
                            kind:'changemoneypwd',
                            userid:this.userId,
                            username:this.userName,
                            newpwd:this.newMoneyPwd,
                            oldpwd:this.oldMoneyPwd
                        },{emulateJSON:true}).then((res)=>{
                            console.log(res);
                            if(res.body.code == 200){
                                this.$emit('showNotice','资金密码，修改成功');
                                this.modal = false;
                                this.refreshData();
                            }else if(res.body.code == 300){
                                this.$emit('showNotice','修改失败');
                            }else if(res.body.code == 400){
                                this.$emit('showNotice','资金密码错误');
                            }
                        },(err)=>{
                            console.log(err);
                        })
                    }
                    break;
                case 6:
                    //添加银行卡
                    if(this.cardNum != '' && this.cardName != '' && this.cardOpen !=''){
                        this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
                            kind:'addcard',
                            userid:this.userId,
                            username:this.userName,
                            cardnum:this.cardNum,
                            cardname:this.cardName,
                            cardopen:this.cardOpen
                        },{emulateJSON:true}).then((res)=>{
                            if(res.body.code == 200){
                                this.$emit('showNotice','银行卡已经绑定！');
                                this.modal = false;
                                this.refreshData();
                            }else{
                                this.$emit('showNotice','绑定失败！');
                            }
                        },(err)=>{
                            console.log(err);
                        })
                    }else{
                        this.$emit('showNotice','请输入完整的银行卡相关信息');
                    }
                    break;
                case 7:
                    //验证资金密码
                    if(this.moneyPwd.length>=6){
                        this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
                            kind:'checkpwd',
                            userid:this.userId,
                            username:this.userName,
                            moneypwd:this.moneyPwd
                        },{emulateJSON:true}).then((res)=>{
                            if(res.body.code == 200){
                                this.showModal(2);
                            }else{
                                this.$emit('showNotice','资金密码错误！');
                            }
                        },(err)=>{
                            console.log(err);
                        })
                    }
                    break;
                case 8:
                    //验证资金密码
                    if(this.moneyPwd.length>=6){
                        this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
                            kind:'checkpwd',
                            userid:this.userId,
                            username:this.userName,
                            moneypwd:this.moneyPwd
                        },{emulateJSON:true}).then((res)=>{
                            if(res.body.code == 200){
                                this.showModal(3);
                            }else{
                                this.$emit('showNotice','资金密码错误！');
                            }
                        },(err)=>{
                            console.log(err);
                        })
                    }
                    break;
            }
        },
        nextPage(){
            if(this.currPage<this.totalPage){
                this.startpage += this.pagesize;
                console.log(this.startpage);
                this.orderTab == 1?this.getListData():this.getHisData();
                this.currPage++;
            }
        },
        prevPage(){
            if(this.currPage>1){
                this.startpage -= this.pagesize;
                this.orderTab == 1?this.getListData():this.getHisData();
                this.currPage--;
            }
        },
        firstPage(){
            this.startpage = 0;
            this.orderTab == 1?this.getListData():this.getHisData();
            this.currPage = 1;
        },
        lastPage(){
            this.startpage = this.pagesize*(this.totalPage-1);
            this.orderTab == 1?this.getListData():this.getHisData();
            this.currPage = this.totalPage;
        }
    }
}
</script>


</template>
