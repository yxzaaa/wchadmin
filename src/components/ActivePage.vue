<template>
    <div class='active-box page-box'>
        <div class='top-message panel-box panel'>
            <div class='page-logo'>
                <div class='page-name'>
                    <img src="../assets/images/page.png" alt="">
                    <span>{{pageName}}</span>
                </div>
                <div class='page-time'>
                    <p>第<span>{{expect}}</span>期</p>
                    <p>投注倒计时</p>
                    <div class='time-box'>
                        <span>{{currHour}}</span>:
                        <span>{{currMin}}</span>:
                        <span>{{currSec}}</span>
                    </div>
                </div>
            </div>
            <div class='page-num'>
                <p>第<span>{{hisList[0].expect}}</span>期开奖号码</p>
                <div class='time-box'>
                    <span v-for='(item,index) in hisOpenCode' :key='index'>{{item}}</span>
                </div>
            </div>
            <div class='page-his'>
                <p>历史开奖<span class='icon icon-repeat'></span></p>
                <ul class='time-box'>
                    <li>第 {{hisList[1].expect}} 期<span>{{hisList[1].opencode}}</span></li>
                    <li>第 {{hisList[2].expect}} 期<span>{{hisList[2].opencode}}</span></li>
                </ul>
            </div>
        </div>
        <div class='top-message panel-box'>
            <div class='page-content panel'>
                <ul class='center-tab'>
                    <li :class="['center-tab-item',{'active':toggleTab == 1}]" @click='changeTab(1)'>数字盘</li>
                    <li :class="['center-tab-item',{'active':toggleTab == 2}]" @click='changeTab(2)'>双面盘</li>
                    <li :class="['center-tab-item',{'active':toggleTab == 3}]" @click='changeTab(3)'>前三</li>
                    <li :class="['center-tab-item',{'active':toggleTab == 4}]" @click='changeTab(4)'>中三</li>
                    <li :class="['center-tab-item',{'active':toggleTab == 5}]" @click='changeTab(5)'>后三</li>
                </ul>  
                <!-- 数字盘 -->
                <div class='center-item-box' v-if='toggleTab == 1'>
                    <div class='play-rule'>
                        <h3>玩法简介</h3>
                        <div>
                            <p><span class='icon icon-circle'></span>从万、千、百、十、个位各选一个或多个号码组成一注</p>
                        </div>
                    </div>
                    <div class='choose-box'>
                        <ul class='choose-list'>
                            <li v-for='(item,index) in numPageData.pagenums' :key="index">
                                <div>{{item.itemname}}</div>
                                <div>
                                    <span :class="{'active':isInData(0,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(0,item.itemdata),0)'>0</span>
                                    <span :class="{'active':isInData(1,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(1,item.itemdata),1)'>1</span>
                                    <span :class="{'active':isInData(2,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(2,item.itemdata),2)'>2</span>
                                    <span :class="{'active':isInData(3,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(3,item.itemdata),3)'>3</span>
                                    <span :class="{'active':isInData(4,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(4,item.itemdata),4)'>4</span>
                                    <span :class="{'active':isInData(5,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(5,item.itemdata),5)'>5</span>
                                    <span :class="{'active':isInData(6,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(6,item.itemdata),6)'>6</span>
                                    <span :class="{'active':isInData(7,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(7,item.itemdata),7)'>7</span>
                                    <span :class="{'active':isInData(8,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(8,item.itemdata),8)'>8</span>
                                    <span :class="{'active':isInData(9,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(9,item.itemdata),9)'>9</span>
                                </div>
                                <div>
                                    <span @click='setPageData(numPageData,numPageData.kind,"全",index)'>全</span>
                                    <span @click='setPageData(numPageData,numPageData.kind,"大",index)'>大</span>
                                    <span @click='setPageData(numPageData,numPageData.kind,"小",index)'>小</span>
                                    <span @click='setPageData(numPageData,numPageData.kind,"单",index)'>单</span>
                                    <span @click='setPageData(numPageData,numPageData.kind,"双",index)'>双</span>
                                    <span @click='setPageData(numPageData,numPageData.kind,"清",index)'>清</span>
                                </div>
                            </li>
                        </ul>
                        <div class='choose-add-box panel'>
                            <div class='choose-bei'>
                                <span class='icon icon-minus' @click='downBei(numPageData)'></span>
                                <span class='text'>{{numPageData.pagebei}}</span>
                                <span class='icon icon-plus' @click='upBei(numPageData)'></span>
                                <span class='text'>倍</span>
                            </div>
                            <div>
                                <span :class="{'active':numPageData.playkind==1}" @click="changekind(1,numPageData)">元</span>
                                <span :class="{'active':numPageData.playkind==0.1}" @click="changekind(0.1,numPageData)">角</span>
                                <span :class="{'active':numPageData.playkind==0.01}" @click="changekind(0.01,numPageData)">分</span>
                            </div>
                            <div>
                                <span>累计 {{numPageData.pagecount}} 注</span>
                                <span>共 {{(numPageData.pagecount*numPageData.pagebei*numPageData.playkind).toFixed(2)}} 元</span>
                            </div>
                            <div class='mybtn' @click='addPageList(numPageData,1)'>
                                选好了
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 双面盘 -->
                <div class='center-item-box' v-if='toggleTab == 2'>
                    <div class='play-rule'>
                        <h3>玩法简介</h3>
                        <div>
                            <p><span class='icon icon-circle'></span>从万、千、百、十、个位各选一个或多个号码组成一注。</p>
                            <p><span class='icon icon-circle'></span>只能选择大数，小数，单数，或双数。</p>
                        </div>
                    </div>
                    <div class='choose-box'>
                        <ul class='choose-list'>
                            <li v-for='(item,index) in doubleData.pagenums' :key="index">
                                <div>{{item.itemname}}</div>
                                <div>
                                    <span :class="{'active':isInData(0,item.itemdata)}">0</span>
                                    <span :class="{'active':isInData(1,item.itemdata)}">1</span>
                                    <span :class="{'active':isInData(2,item.itemdata)}">2</span>
                                    <span :class="{'active':isInData(3,item.itemdata)}">3</span>
                                    <span :class="{'active':isInData(4,item.itemdata)}">4</span>
                                    <span :class="{'active':isInData(5,item.itemdata)}">5</span>
                                    <span :class="{'active':isInData(6,item.itemdata)}">6</span>
                                    <span :class="{'active':isInData(7,item.itemdata)}">7</span>
                                    <span :class="{'active':isInData(8,item.itemdata)}">8</span>
                                    <span :class="{'active':isInData(9,item.itemdata)}">9</span>
                                </div>
                                <div>
                                    <span @click='setPageData(doubleData,doubleData.kind,"大",index)'>大</span>
                                    <span @click='setPageData(doubleData,doubleData.kind,"小",index)'>小</span>
                                    <span @click='setPageData(doubleData,doubleData.kind,"单",index)'>单</span>
                                    <span @click='setPageData(doubleData,doubleData.kind,"双",index)'>双</span>
                                    <span @click='setPageData(doubleData,doubleData.kind,"清",index)'>清</span>
                                </div>
                            </li>
                        </ul>
                        <div class='choose-add-box panel'>
                            <div class='choose-bei'>
                                <span class='icon icon-minus' @click='downBei(doubleData)'></span>
                                <span class='text'>{{doubleData.pagebei}}</span>
                                <span class='icon icon-plus' @click='upBei(doubleData)'></span>
                                <span class='text'>倍</span>
                            </div>
                            <div>
                                <span :class="{'active':doubleData.playkind==1}" @click="changekind(1,doubleData)">元</span>
                                <span :class="{'active':doubleData.playkind==0.1}" @click="changekind(0.1,doubleData)">角</span>
                                <span :class="{'active':doubleData.playkind==0.01}" @click="changekind(0.01,doubleData)">分</span>
                            </div>
                            <div>
                                <span>累计 {{doubleData.pagecount}} 注</span>
                                <span>共 {{(doubleData.pagecount*doubleData.pagebei*doubleData.playkind).toFixed(2)}} 元</span>
                            </div>
                            <div class='mybtn' @click='addPageList(doubleData,1)'>
                                选好了
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 前三 -->
                <div class='center-item-box' v-if='toggleTab == 3'>
                    <div class='play-rule'>
                        <h3>玩法简介</h3>
                        <div>
                            <p><span class='icon icon-circle'></span>手动输入号码，至少输入1个三位数号码组成一注。</p>
                            <p><span class='icon icon-circle'></span>所输入的三位数中含有与开奖号码万，千，百位均相同的，视为中奖。</p>
                            <p><span class='icon icon-circle'></span>在下方的输入框内输入或粘贴投注内容，每注请使用逗号、空格或';'分割开。</p>
                        </div>
                    </div>
                    <div class='choose-box'>
                        <div class='choose-area'>
                            <textarea name="" id="" cols="30" rows="10" v-model="beforeData.textinfo" @input="setNumList(beforeData,2)"></textarea>
                        </div>
                        <div class='choose-add-box panel'>
                            <div class='choose-bei'>
                                <span class='icon icon-minus' @click='downBei(beforeData)'></span>
                                <span class='text'>{{beforeData.pagebei}}</span>
                                <span class='icon icon-plus' @click='upBei(beforeData)'></span>
                                <span class='text'>倍</span>
                            </div>
                            <div>
                                <span :class="{'active':beforeData.playkind==1}" @click="changekind(1,beforeData)">元</span>
                                <span :class="{'active':beforeData.playkind==0.1}" @click="changekind(0.1,beforeData)">角</span>
                                <span :class="{'active':beforeData.playkind==0.01}" @click="changekind(0.01,beforeData)">分</span>
                            </div>
                            <div>
                                <span>累计 {{beforeData.pagecount}} 注</span>
                                <span>共 {{(beforeData.pagecount*beforeData.pagebei*beforeData.playkind).toFixed(2)}} 元</span>
                            </div>
                            <div class='mybtn' @click='addPageList(beforeData,2)'>
                                选好了
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 中三 -->
                <div class='center-item-box' v-if='toggleTab == 4'>
                    <div class='play-rule'>
                        <h3>玩法简介</h3>
                        <div>
                            <p><span class='icon icon-circle'></span>手动输入号码，至少输入1个三位数号码组成一注。</p>
                            <p><span class='icon icon-circle'></span>所输入的三位数中含有与开奖号码千，百，十位均相同的，视为中奖。</p>
                            <p><span class='icon icon-circle'></span>在下方的输入框内输入或粘贴投注内容，每注请使用逗号、空格或';'分割开。</p>
                        </div>
                    </div>
                    <div class='choose-box'>
                        <div class='choose-area'>
                            <textarea name="" id="" cols="30" rows="10" v-model="centerData.textinfo" @input="setNumList(centerData,2)"></textarea>
                        </div>
                        <div class='choose-add-box panel'>
                            <div class='choose-bei'>
                                <span class='icon icon-minus' @click='downBei(centerData)'></span>
                                <span class='text'>{{centerData.pagebei}}</span>
                                <span class='icon icon-plus' @click='upBei(centerData)'></span>
                                <span class='text'>倍</span>
                            </div>
                            <div>
                                <span :class="{'active':centerData.playkind==1}" @click="changekind(1,centerData)">元</span>
                                <span :class="{'active':centerData.playkind==0.1}" @click="changekind(0.1,centerData)">角</span>
                                <span :class="{'active':centerData.playkind==0.01}" @click="changekind(0.01,centerData)">分</span>
                            </div>
                            <div>
                                <span>累计 {{centerData.pagecount}} 注</span>
                                <span>共 {{(centerData.pagecount*centerData.pagebei*centerData.playkind).toFixed(2)}} 元</span>
                            </div>
                            <div class='mybtn' @click='addPageList(centerData,2)'>
                                选好了
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 后三 -->
                <div class='center-item-box' v-if='toggleTab == 5'>
                    <div class='play-rule'>
                        <h3>玩法简介</h3>
                        <div>
                            <p><span class='icon icon-circle'></span>手动输入号码，至少输入1个三位数号码组成一注。</p>
                            <p><span class='icon icon-circle'></span>所输入的三位数中含有与开奖号码百，十，个位均相同的，视为中奖。</p>
                            <p><span class='icon icon-circle'></span>在下方的输入框内输入或粘贴投注内容，每注请使用逗号、空格或';'分割开。</p>
                        </div>
                    </div>
                    <div class='choose-box'>
                        <div class='choose-area'>
                            <textarea name="" id="" cols="30" rows="10" v-model="afterData.textinfo" @input="setNumList(afterData,2)"></textarea>
                        </div>
                        <div class='choose-add-box panel'>
                            <div class='choose-bei'>
                                <span class='icon icon-minus' @click='downBei(afterData)'></span>
                                <span class='text'>{{afterData.pagebei}}</span>
                                <span class='icon icon-plus' @click='upBei(afterData)'></span>
                                <span class='text'>倍</span>
                            </div>
                            <div>
                                <span :class="{'active':afterData.playkind==1}" @click="changekind(1,afterData)">元</span>
                                <span :class="{'active':afterData.playkind==0.1}" @click="changekind(0.1,afterData)">角</span>
                                <span :class="{'active':afterData.playkind==0.01}" @click="changekind(0.01,afterData)">分</span>
                            </div>
                            <div>
                                <span>累计 {{afterData.pagecount}} 注</span>
                                <span>共 {{(afterData.pagecount*afterData.pagebei*afterData.playkind).toFixed(2)}} 元</span>
                            </div>
                            <div class='mybtn' @click='addPageList(afterData,2)'>
                                选好了
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class='user-content panel'>
                <h3 class='panel-title'>中奖名单</h3>
                <div class='user-list-box'>
                    <ul class='user-list'>
                        <li>XXX<span>奖金:34.21</span></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class='choose-res-box panel-box'>
            <div class='choose-res-list panel'>
                <div class='panel-title'>共选择了 {{resList.length}} 注</div>
                <div class='res-box'>
                    <ul class='res-list'>
                        <li v-for="(item,index) in resList" :key='index'>
                            <div>
                                <span>{{item.playname}}</span>
                                <span>{{item.pagenums}}</span>
                            </div>
                            <div>
                                <span>{{item.pagecount}} 注</span>
                                <span>{{item.pagebei}} 倍</span>
                                <span>{{item.pagepay}} 元</span>
                                <span class='icon icon-remove' @click="removeRes(index)"></span>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class='confirm-choose panel'>
                <div>总注数<span>{{totalCount}} 注</span></div>
                <div>总金额<span>{{totalPay}} 元</span></div>
                <div :class="['mybtn',{'no-confirm':resList.length==0}]" id='confirmChoose' @click='confirmChoose()'>确认投注</div>
            </div>
        </div>
    </div>
</template>
<script>
import '../assets/css/activepage.css';
export default {
    data(){
        return{
            toggleTab:1,
            //数字盘
            numPageData:{
                playname:'数字盘',
                kind:1,
                pagenums:[
                    {
                        itemname:'万位',
                        itemdata:[]
                    },
                    {
                        itemname:'千位',
                        itemdata:[]
                    },
                    {
                        itemname:'百位',
                        itemdata:[]
                    },
                    {
                        itemname:'十位',
                        itemdata:[]
                    },
                    {
                        itemname:'个位',
                        itemdata:[]
                    },
                ],
                numlist:[],
                playkind:1,
                pagecount:0,
                pagebei:1,
                pagepay:0
            },
            //双面盘
            doubleData:{
                playname:'双面盘',
                kind:1,
                pagenums:[
                    {
                        itemname:'万位',
                        itemdata:[]
                    },
                    {
                        itemname:'千位',
                        itemdata:[]
                    },
                    {
                        itemname:'百位',
                        itemdata:[]
                    },
                    {
                        itemname:'十位',
                        itemdata:[]
                    },
                    {
                        itemname:'个位',
                        itemdata:[]
                    },
                ],
                numlist:[],
                playkind:1,
                pagecount:0,
                pagebei:1,
                pagepay:0
            },
            //前三
            beforeData:{
                playname:'前三',
                kind:2,
                textinfo:'',
                numlist:[],
                playkind:1,
                pagecount:0,
                pagebei:1,
                pagepay:0
            },
            //中三
            centerData:{
                playname:'中三',
                kind:2,
                textinfo:'',
                numlist:[],
                playkind:1,
                pagecount:0,
                pagebei:1,
                pagepay:0
            },
            //后三
            afterData:{
                playname:'后三',
                kind:2,
                textinfo:'',
                numlist:[],
                playkind:1,
                pagecount:0,
                pagebei:1,
                pagepay:0
            },
            resList:[],
            hisList:[
                {expect:'000',opencode:'0,0,0,0,0'},
                {expect:'000',opencode:'0,0,0,0,0'},
                {expect:'000',opencode:'0,0,0,0,0'}
            ],
            totalCount:0,
            totalPay:0,
            currOpenTime:1536506909768,
            currHour:'',
            currMin:'',
            currSec:'',
            expect:'',
            opencode:'',
            timer:null,
            timeout:null,
            scrollTimer:null,
            pageId:0,
            pageName:'',
            hisOpenCode:[]
        }
    },
    mounted(){
        this.$emit('getNum',sessionStorage.getItem('pagenum'));
        this.getPageData();
    },
    watch: {
        //监听路由，只要路由有变化(路径，参数等变化)都有执行下面的函数，你可以
        $route: {
            handler: function (val, oldVal) {
                this.clearAllData();
                this.getPageData();
                //created事件触发的函数可以在这里写...  
                //都是componentA组件，声明周期还在，改变不了
            },
            deep: true
        }
    },
    methods:{
        getPageData(){
            this.pageId = this.$route.query.pageid;
            this.pageName = this.$route.query.pagename;
            this.$http.post('http://lgkj.chuangkegf.com/wuchuang/getpageinfo.php',{
                kind:'initpageinfo',
                pageid:this.pageId,
                pagename:this.pageName
            },{emulateJSON:true}).then((res)=>{
                if(res.body.code == 200){
                    var data = res.body.data;
                    if(this.expect != data[1]){
                        this.currOpenTime = data[2];
                        this.expect = data[1];
                        this.getHisData();
                        clearInterval(this.timer);
                        this.timer = null;
                        this.setTime();
                    }else{
                        this.timeout = setTimeout(()=>{
                            this.getPageData();
                        },1000)
                    }
                }
            })
        },
        getHisData(){
            this.pageId = this.$route.query.pageid;
            this.pageName = this.$route.query.pagename;
            this.$http.post('http://lgkj.chuangkegf.com/wuchuang/getpageinfo.php',{
                kind:'gethisinfo',
                pageid:this.pageId,
                pagename:this.pageName
            },{emulateJSON:true}).then((res)=>{
                if(res.body.code == 200){
                    var data = res.body.data;
                    var len = data.length;
                    if(len == 1){
                        this.hisList = [
                            data[0],{expect:'000',opencode:'0,0,0,0,0'},{expect:'000',opencode:'0,0,0,0,0'}
                        ];
                    }else if(len == 2){
                        this.hisList = [
                            data[0],data[1],{expect:'000',opencode:'0,0,0,0,0'}
                        ];
                    }else{
                        this.hisList = data;
                    }
                    var count = 0;
                    this.scrollTimer = setInterval(()=>{
                        count ++;
                        this.hisOpenCode = this.getRandomCode();
                        if(count>30){
                            clearInterval(this.scrollTimer);
                            this.scrollTimer = null;
                            this.hisOpenCode = this.hisList[0].opencode.split(',');
                        }
                    },100)
                }
            })
        },
        getRandomCode(){
            return [
                parseInt(Math.random() * 9) + 1,
                parseInt(Math.random() * 9) + 1,
                parseInt(Math.random() * 9) + 1,
                parseInt(Math.random() * 9) + 1,
                parseInt(Math.random() * 9) + 1
            ]
        },
        setTime(){
            this.timer = setInterval(()=>{
                var date = new Date();
                var delayTime = parseInt(this.currOpenTime - date.getTime()/1000);
                var hour = Math.floor(delayTime/3600);
                var min = Math.floor((delayTime-hour*3600)/60);
                var second = Math.floor(delayTime - hour*3600 - min*60);
                if(delayTime <= 0){
                    this.currHour = '00';
                    this.currMin = '00';
                    this.currSec = '00';
                    clearInterval(this.timer);
                    this.timer = null;
                    this.$emit('showNotice',this.pageName+','+this.expect+'期已开奖，投注时请注意倒计时！');
                    this.getPageData();
                }else{
                    this.currHour = hour>=10?hour:'0'+hour;
                    this.currMin = min>=10?min:'0'+min;
                    this.currSec = second>=10?second:'0'+second;
                }
            },1000)
        },
        addPageList(data,kind){
            var tcount = 0;
            var tpay = 0;
            data.pagepay = (data.pagecount*data.pagebei*data.playkind).toFixed(2);
            if(data.pagecount>0){
                this.resList.push({
                    pageid:this.pageId,
                    pagename:this.pageName,
                    userid:localStorage.getItem('userid'),
                    username:localStorage.getItem('uname'),
                    playname:data.playname,
                    playkind:data.playkind,
                    pagenums:this.transPage(data.numlist,kind),
                    pagecount:data.pagecount,
                    pagebei:data.pagebei,
                    pagepay:data.pagepay,
                })
            }else{
                alert('号码不完整，请重新选择！');
            }
            this.resList.map(function(item,index){
                tcount += parseInt(item.pagecount);
                tpay += parseFloat(item.pagepay);
            });
            this.totalCount = tcount;
            this.totalPay = tpay.toFixed(2);
        },
        confirmChoose(){
            var reslist = this.resList;
            this.$http.post('http://lgkj.chuangkegf.com/wuchuang/userinfo.php',{
                kind:'changerest',
                userid:localStorage.getItem("userid"),
                username:localStorage.getItem("uname"),
                pay:this.totalPay
            },{emulateJSON:true}).then((res)=>{
                console.log(res.body);
                if(res.body.code == 200){
                    var that = this;
                    var allSucc = true;
                    that.resList.map(function(item,index){
                        console.log(item.pagenums);
                        that.$http.post('http://lgkj.chuangkegf.com/wuchuang/addplaylist.php',{
                            userid:item.userid,
                            username:item.username,
                            pageid:item.pageid,
                            pagename:item.pagename,
                            expect:that.expect,
                            playname:item.playname,
                            playkind:item.playkind,
                            pagenums:item.pagenums,
                            pagecount:item.pagecount,
                            pagebei:item.pagebei,
                            pagepay:item.pagepay
                        },{emulateJSON:true}).then((res)=>{
                            if(res.body.code == 400){
                                allSucc = false;
                            }
                        })
                    });
                    if(allSucc == true){
                        this.$emit('showNotice','投注成功');
                        this.clearAllData();
                    }
                }else if(res.body.code == 300){
                    this.$emit('showNotice','您的余额不足，请及时充值');
                }
            })
        },
        removeRes(index){
            var tcount = 0;
            var tpay = 0;
            this.resList.splice(index,1);
            this.resList.map(function(item,index){
                tcount += parseFloat(item.pagecount);
                tpay += parseFloat(item.pagepay);
            });
            this.totalCount = tcount;
            this.totalPay = tpay;
        },
        changeTab(index){
            this.toggleTab = index;
        },
        transPage(pagenums,kind){
            var str = '';
            if(kind == 1){
                for(var i=0;i<pagenums.length;i++){
                    for(var j=0;j<pagenums[i].length;j++){
                        if(j == pagenums[i].length -1){
                            str += pagenums[i][j];
                        }else{
                            str += pagenums[i][j]+','
                        }
                    }
                    if(i != pagenums.length - 1){
                        str += '|';
                    }
                }
            }else if(kind == 2){
                for(var i=0;i<pagenums.length;i++){
                    if(i<pagenums.length-1){
                        str += pagenums[i]+'|';
                    }else{
                        str += pagenums[i];
                    }
                }
            }
            return str;
        },
        isInData(item,arr){
            var isIn = false;
            for(var i=0;i<arr.length;i++){
                if(item == arr[i]){
                    isIn = true;
                }
            }
            return isIn;
        },
        changeData(data,kind,index,isIn,num){
            var that = this;
            if(isIn == true){
                data.pagenums[index].itemdata.map(function(item,index1){
                    if(item == num){
                        data.pagenums[index].itemdata.splice(index1,1);
                    };
                })
            }else{
                data.pagenums[index].itemdata.push(num);
            }
            data.pagenums[index].itemdata.sort();
            that.setNumList(data,kind);
        },
        setPageData(data,kind,str,index){
            switch(str){
                case '全':
                    data.pagenums[index].itemdata = [0,1,2,3,4,5,6,7,8,9];
                    break;
                case '大':
                    data.pagenums[index].itemdata = [5,6,7,8,9];
                    break;
                case '小':
                    data.pagenums[index].itemdata = [0,1,2,3,4];
                    break;
                case '单':
                    data.pagenums[index].itemdata = [1,3,5,7,9];
                    break;
                case '双':
                    data.pagenums[index].itemdata = [0,2,4,6,8];
                    break;
                case '清':
                    data.pagenums[index].itemdata = [];
                    break;
            }
            this.setNumList(data,kind);
        },
        setNumList(data,kind){
            var list = [];
            var count = 0;
            if(kind == 1){
                data.pagenums.map(function(item,index){
                    list.push(item.itemdata);
                });
                data.numlist = list;
                list.map(function(item,index){
                    count += parseInt(item.length);
                });
                data.pagecount = count;
            }else if(kind == 2){
                list = data.textinfo.split(/[,; ]/);
                var isucc = true;
                list.map(function(item,index){
                    if(item.length != 3){
                        isucc = false;
                    }
                })
                if(isucc == true){
                    data.numlist = list;
                    data.pagecount = list.length;
                }else if(list[0].length<3 && list.length == 1){
                    data.pagecount = 0;
                }
            }
        },
        changekind(str,data){
            data.playkind = str;
        },
        downBei(data){
            if(data.pagebei>1){
                data.pagebei --;
            }
        },
        upBei(data){
            data.pagebei ++;
        },
        clearAllData(){
            this.numPageData = {
                playname:'数字盘',
                kind:1,
                pagenums:[
                    {
                        itemname:'万位',
                        itemdata:[]
                    },
                    {
                        itemname:'千位',
                        itemdata:[]
                    },
                    {
                        itemname:'百位',
                        itemdata:[]
                    },
                    {
                        itemname:'十位',
                        itemdata:[]
                    },
                    {
                        itemname:'个位',
                        itemdata:[]
                    },
                ],
                numlist:[],
                playkind:1,
                pagecount:0,
                pagebei:1,
                pagepay:0
            };
            //双面盘
            this.doubleData={
                playname:'双面盘',
                kind:1,
                pagenums:[
                    {
                        itemname:'万位',
                        itemdata:[]
                    },
                    {
                        itemname:'千位',
                        itemdata:[]
                    },
                    {
                        itemname:'百位',
                        itemdata:[]
                    },
                    {
                        itemname:'十位',
                        itemdata:[]
                    },
                    {
                        itemname:'个位',
                        itemdata:[]
                    },
                ],
                numlist:[],
                playkind:1,
                pagecount:0,
                pagebei:1,
                pagepay:0
            };
            //前三
            this.beforeData={
                playname:'前三',
                kind:2,
                textinfo:'',
                numlist:[],
                playkind:1,
                pagecount:0,
                pagebei:1,
                pagepay:0
            };
            //中三
            this.centerData={
                playname:'中三',
                kind:2,
                textinfo:'',
                numlist:[],
                playkind:1,
                pagecount:0,
                pagebei:1,
                pagepay:0
            };
            //后三
            this.afterData={
                playname:'后三',
                kind:2,
                textinfo:'',
                numlist:[],
                playkind:1,
                pagecount:0,
                pagebei:1,
                pagepay:0
            };
            this.resList=[];
            this.totalCount = 0;
            this.totalPay = 0;
        },
    }
}
</script>

