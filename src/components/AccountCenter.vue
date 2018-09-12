<template>
    <div class='center-box page-box'>
        <div class='center-content panel'>
            <ul class='center-tab'>
                <li :class="['center-tab-item',{'active':toggleTab == 1}]" @click='changeTab(1)'>账户中心</li>
                <li :class="['center-tab-item',{'active':toggleTab == 2}]" @click='changeTab(2)'>订单中心</li>
            </ul>  
            <div class='center-item-box' v-if='toggleTab == 1'>
                <div class='name-pay'>
                    <div class='name-box'>
                        <h3>{{userName}}</h3>
                        <div>欢迎您
                            <span class='update-name' @click='showModal(0)'>修改昵称</span>
                        </div>
                    </div>
                    <ul class='pay-box'>
                        <li class='pay-item'>
                            <h3 class='panel-title'><span class='icon icon-user' style='padding-right:10px;display:inline-block;font-size:16px;'></span>账户余额</h3>
                            <div class='main-pay-detail'>
                                <span>{{pageData[0]}}</span><span class='pay-btn mybtn' @click='showModal(1)'>充值</span>
                            </div>
                        </li>
                        <li class='pay-item'>
                            <h3 class='panel-title'><span class='icon icon-user' style='padding-right:10px;display:inline-block;font-size:16px;'></span>可提现金额</h3>
                            <div class='main-pay-detail'>
                                <span>{{pageData[0]}}</span><span class='pay-btn mybtn' @click='showModal(2)'>提现</span>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class='name-pay'>
                    <ul class='pay-card-box'>
                        <li class='pay-item'>
                            <h3 class='panel-title'>
                                <span class='icon icon-user' style='padding-right:10px;display:inline-block;font-size:16px;'></span>
                                我的银行卡
                                <span class='pay-btn mybtn' @click='showModal(3)' v-if='!noCard'>解绑</span>
                            </h3>
                            <div class='main-pay-detail' v-if='!noCard'>
                                <span class='bank'>{{pageData[4]}}</span>
                                <span class='bank'>{{pageData[3]}}</span>
                                <span class='card-num'>{{pageData[2]}}</span>
                            </div>
                            <div class='main-pay-detail' v-if='noCard' @click='showModal(6)'>
                                <span class='icon icon-plus add-card'></span>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class='name-pay'>
                    <ul class='pay-card-box'>
                        <li class='pay-item'>
                            <h3 class='panel-title'><span class='icon icon-user' style='padding-right:10px;display:inline-block;font-size:16px;'></span>商家账号</h3>
                            <div class='main-pay-detail'>
                                <span class='bank'>工商银行</span>
                                <span class='card-num'>322331223245323442321</span>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class='name-pay'>
                    <h3 class='panel-title'><span class='icon icon-user' style='padding-right:10px;display:inline-block;font-size:16px;'></span>账号设置</h3>
                    <ul class='pay-card-box'>
                        <li class='set-item'>
                            <div class='set-item-left'>
                                <span class='icon icon-unlock'></span>
                                <div>
                                    <h5>登录密码</h5>
                                    <p>我们建议用户经常修改自己的登录密码，来保证资金的安全</p>
                                </div>
                            </div>
                            <div class='set-item-right mybtn' @click='showModal(4)'>
                                设置
                            </div>
                        </li>
                        <li class='set-item'>
                            <div class='set-item-left'>
                                <span class='icon icon-unlock'></span>
                                <div>
                                    <h5>资金密码</h5>
                                    <p>我们建议用户经常修改自己的资金密码，来保证资金的安全</p>
                                </div>
                            </div>
                            <div class='set-item-right mybtn' @click='showModal(5)'>
                                设置
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class='center-item-box' v-if='toggleTab == 2'>
                
            </div>
        </div>
        <div class='modal-content' v-if='modal'>
            <div class='modal-box panel'>
                <div class='panel-title'>{{currModalTitle}}</div>
                <div class='modal-item'>
                    <p class='modal-notice'>{{currModaldus}}</p>
                    <div class='input-pay' v-if='currModalKind == 0'><input type="text" maxlength="10"></div>
                    <div class='input-pay' v-if='currModalKind == 1'><input type="text"> 元</div>
                    <div class='input-pay' v-if='currModalKind == 2'><input type="text"> 元</div>
                    <ul class='input-pwd' v-if='currModalKind == 4'>
                        <li><span>旧密码</span><input type="password" placeholder="请输入旧密码" maxlength="16"></li>
                        <li><span>新密码</span><input type="password" placeholder="请输入新密码" maxlength="16"></li>
                        <li><span>确认新密码</span><input type="password" placeholder="请确认新密码" maxlength="16"></li>
                    </ul>
                    <ul class='input-pwd' v-if='currModalKind == 5'>
                        <li><span>旧密码</span><input type="password" placeholder="请输入旧密码" maxlength="16"></li>
                        <li><span>新密码</span><input type="password" placeholder="请输入新密码" maxlength="16"></li>
                        <li><span>确认新密码</span><input type="password" placeholder="请确新密码" maxlength="16"></li>
                    </ul>
                    <ul class='input-pwd' v-if='currModalKind == 6'>
                        <li><span>姓名</span><input type="text" placeholder="请输入真实姓名" maxlength="16"></li>
                        <li><span>开户银行</span><input type="text" placeholder="请输入银行卡开户行" maxlength="64"></li>
                        <li><span>银行卡号</span><input type="text" placeholder="请输入银行卡号" maxlength="32"></li>
                    </ul>
                    <div v-if='currModalKind == 3'>
                    </div>
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
            currModalTitle:'充值',
            currModaldus:'',
            currModalKind:1,
            modal:false,
            userName:'未登录',
            pageData:[],
            noCard:true
        }
    },
    mounted(){
        this.$emit('getNum',0);
        var username = localStorage.getItem('uname');
        var userid = localStorage.getItem('userid');
        this.userName = username;
        this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
            kind:'maininfo',
            userid:userid,
            username:username,
        },{emulateJSON:true}).then((res)=>{
            if(res.body.code == 200){
                this.pageData = res.body.data;
                if(this.pageData[5] == 0){
                    this.noCard = true;
                }
            }
        },(err)=>{
            console.log(err);
        })
    },
    methods:{
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
                    break;
                case 1:
                    this.currModalTitle = '余额充值';
                    this.currModaldus = '请首先使用绑定的银行卡转账到商家账户';
                    this.currModalKind = 1;
                    break;
                case 2:
                    this.currModalTitle = '提现';
                    this.currModaldus = '请保证提现金额小于账户余额';
                    this.currModalKind = 2;
                    break;
                case 3:
                    this.currModalTitle = '银行卡绑定';
                    this.currModaldus = '填写完整的银行卡信息';
                    this.currModalKind = 3;
                    break;
                case 4:
                    this.currModalTitle = '修改登录密码';
                    this.currModaldus = '修改登录密码可以提升账户安全,不少于6个字符';
                    this.currModalKind = 4;
                    break;
                case 5:
                    this.currModalTitle = '修改资金密码';
                    this.currModaldus = '修改资金密码可以提升账户安全,不少于6个字符';
                    this.currModalKind = 5;
                    break;
                case 6:
                    this.currModalTitle = '添加银行卡';
                    this.currModaldus = '请输入准确信息';
                    this.currModalKind = 6;
                    break;
            }
            this.modal = true;
        },
        confirmModal(kind){
            switch(kind){
                case 0:
                    this.currModalTitle = '修改昵称';
                    this.currModaldus = '昵称不低于3个字符';
                    this.currModalKind = 0;
                    break;
                case 1:
                    this.currModalTitle = '余额充值';
                    this.currModaldus = '请首先使用绑定的银行卡转账到商家账户';
                    this.currModalKind = 1;
                    break;
                case 2:
                    this.currModalTitle = '提现';
                    this.currModaldus = '请保证提现金额小于账户余额';
                    this.currModalKind = 2;
                    break;
                case 3:
                    this.currModalTitle = '银行卡绑定';
                    this.currModaldus = '填写完整的银行卡信息';
                    this.currModalKind = 3;
                    break;
                case 4:
                    this.currModalTitle = '修改登录密码';
                    this.currModaldus = '修改登录密码可以提升账户安全,不少于6个字符';
                    this.currModalKind = 4;
                    break;
                case 5:
                    this.currModalTitle = '修改资金密码';
                    this.currModaldus = '修改资金密码可以提升账户安全,不少于6个字符';
                    this.currModalKind = 5;
                    break;
                case 6:
                    this.currModalTitle = '添加银行卡';
                    this.currModaldus = '请输入准确信息';
                    this.currModalKind = 6;
                    break;
            }
            this.modal = false;
        }
    }
}
</script>

