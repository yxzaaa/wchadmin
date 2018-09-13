<template>
    <div class='active-box page-box'>
        <div class='top-message panel-box panel'>
            <div class='page-logo'>
                <div class='page-name'>
                    <img src="../assets/images/page.png" alt="">
                    <span>{{pageName}}</span>
                </div>
                <div class='page-time'>
                    <p>第<span>20180324</span>期</p>
                    <p>投注倒计时</p>
                    <div class='time-box'>
                        <span>{{currHour}}</span>:
                        <span>{{currMin}}</span>:
                        <span>{{currSec}}</span>
                    </div>
                </div>
            </div>
            <div class='page-num'>
                <p>第<span>20180324</span>期开奖号码</p>
                <div class='time-box beijing'>
                    <span>1</span>
                    <span>4</span>
                    <span>2</span>
                    <span>6</span>
                    <span>8</span>
                    <span>1</span>
                    <span>4</span>
                    <span>2</span>
                    <span>6</span>
                    <span>8</span>
                </div>
            </div>
            <div class='page-his'>
                <p>历史开奖<span class='icon icon-repeat'></span></p>
                <ul class='time-box'>
                    <li>12231212<span>1 4 2 6 9</span></li>
                    <li>12231212<span>1 4 2 6 9</span></li>
                </ul>
            </div>
        </div>
        <div class='top-message panel-box'>
            <div class='page-content panel'>
                <ul class='center-tab'>
                    <li :class="['center-tab-item',{'active':toggleTab == 1}]" @click='changeTab(1)'>数字盘</li>
                    <li :class="['center-tab-item',{'active':toggleTab == 2}]" @click='changeTab(2)'>双面盘</li>
                    <li :class="['center-tab-item',{'active':toggleTab == 3}]" @click='changeTab(3)'>冠亚军和</li>
                </ul>  
                <!-- 数字盘 -->
                <div class='center-item-box' v-if='toggleTab == 1'>
                    <div class='play-rule'>
                        <h3>玩法简介</h3>
                        <div>
                            <p><span class='icon icon-circle'></span>从十个名次中各选一个或多个选手号码组成一注</p>
                        </div>
                    </div>
                    <div class='choose-box'>
                        <ul class='choose-list'>
                            <li v-for='(item,index) in numPageData.pagenums' :key="index">
                                <div>{{item.itemname}}</div>
                                <div>
                                    <span :class="{'active':isInData(1,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(1,item.itemdata),1)'>1</span>
                                    <span :class="{'active':isInData(2,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(2,item.itemdata),2)'>2</span>
                                    <span :class="{'active':isInData(3,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(3,item.itemdata),3)'>3</span>
                                    <span :class="{'active':isInData(4,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(4,item.itemdata),4)'>4</span>
                                    <span :class="{'active':isInData(5,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(5,item.itemdata),5)'>5</span>
                                    <span :class="{'active':isInData(6,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(6,item.itemdata),6)'>6</span>
                                    <span :class="{'active':isInData(7,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(7,item.itemdata),7)'>7</span>
                                    <span :class="{'active':isInData(8,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(8,item.itemdata),8)'>8</span>
                                    <span :class="{'active':isInData(9,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(9,item.itemdata),9)'>9</span>
                                    <span :class="{'active':isInData(10,item.itemdata)}" @click='changeData(numPageData,numPageData.kind,index,isInData(10,item.itemdata),10)'>10</span>
                                </div>
                                <div>
                                    <span @click='beiPageData(numPageData,numPageData.kind,"全",index)'>全</span>
                                    <span @click='beiPageData(numPageData,numPageData.kind,"大",index)'>大</span>
                                    <span @click='beiPageData(numPageData,numPageData.kind,"小",index)'>小</span>
                                    <span @click='beiPageData(numPageData,numPageData.kind,"单",index)'>单</span>
                                    <span @click='beiPageData(numPageData,numPageData.kind,"双",index)'>双</span>
                                    <span @click='beiPageData(numPageData,numPageData.kind,"清",index)'>清</span>
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
                            <p><span class='icon icon-circle'></span>从十个名次中分别选择选手号码组成一注。</p>
                            <p><span class='icon icon-circle'></span>选择号码只能选择大数，小数，单数，或双数。</p>
                        </div>
                    </div>
                    <div class='choose-box'>
                        <ul class='choose-list'>
                            <li v-for='(item,index) in doubleData.pagenums' :key="index">
                                <div>{{item.itemname}}</div>
                                <div>
                                    <span :class="{'active':isInData(1,item.itemdata)}">1</span>
                                    <span :class="{'active':isInData(2,item.itemdata)}">2</span>
                                    <span :class="{'active':isInData(3,item.itemdata)}">3</span>
                                    <span :class="{'active':isInData(4,item.itemdata)}">4</span>
                                    <span :class="{'active':isInData(5,item.itemdata)}">5</span>
                                    <span :class="{'active':isInData(6,item.itemdata)}">6</span>
                                    <span :class="{'active':isInData(7,item.itemdata)}">7</span>
                                    <span :class="{'active':isInData(8,item.itemdata)}">8</span>
                                    <span :class="{'active':isInData(9,item.itemdata)}">9</span>
                                    <span :class="{'active':isInData(10,item.itemdata)}">10</span>
                                </div>
                                <div>
                                    <span @click='beiPageData(doubleData,doubleData.kind,"大",index)'>大</span>
                                    <span @click='beiPageData(doubleData,doubleData.kind,"小",index)'>小</span>
                                    <span @click='beiPageData(doubleData,doubleData.kind,"单",index)'>单</span>
                                    <span @click='beiPageData(doubleData,doubleData.kind,"双",index)'>双</span>
                                    <span @click='beiPageData(doubleData,doubleData.kind,"清",index)'>清</span>
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
                <!-- 冠亚军和 -->
                <div class='center-item-box' v-if='toggleTab == 3'>
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
                <div :class="['mybtn',{'no-confirm':resList.length==0}]" id='confirmChoose'>确认投注</div>
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
                        itemname:'冠 军',
                        itemdata:[]
                    },
                    {
                        itemname:'亚 军',
                        itemdata:[]
                    },
                    {
                        itemname:'季 军',
                        itemdata:[]
                    },
                    {
                        itemname:'第四名',
                        itemdata:[]
                    },
                    {
                        itemname:'第五名',
                        itemdata:[]
                    },
                     {
                        itemname:'第六名',
                        itemdata:[]
                    },
                    {
                        itemname:'第七名',
                        itemdata:[]
                    },
                    {
                        itemname:'第八名',
                        itemdata:[]
                    },
                    {
                        itemname:'第九名',
                        itemdata:[]
                    },
                    {
                        itemname:'第十名',
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
                        itemname:'冠 军',
                        itemdata:[]
                    },
                    {
                        itemname:'亚 军',
                        itemdata:[]
                    },
                    {
                        itemname:'季 军',
                        itemdata:[]
                    },
                    {
                        itemname:'第四名',
                        itemdata:[]
                    },
                    {
                        itemname:'第五名',
                        itemdata:[]
                    },
                     {
                        itemname:'第六名',
                        itemdata:[]
                    },
                    {
                        itemname:'第七名',
                        itemdata:[]
                    },
                    {
                        itemname:'第八名',
                        itemdata:[]
                    },
                    {
                        itemname:'第九名',
                        itemdata:[]
                    },
                    {
                        itemname:'第十名',
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
            totalCount:0,
            totalPay:0,
            currOpenTime:1536506909768,
            currHour:'',
            currMin:'',
            currSec:'',
            timer:null
        }
    },
    mounted(){
        this.$emit('getNum',sessionStorage.getItem('pagenum'));
        this.setTime();
    },
    methods:{
        setTime(){
            this.timer = setInterval(()=>{
                var date = new Date();
                var delayTime = Math.floor((this.currOpenTime - date.getTime())/1000);
                var hour = Math.floor(delayTime/3600);
                var min = Math.floor((delayTime-hour*3600)/60);
                var second = Math.floor(delayTime - hour*3600 - min*60);
                if(delayTime <= 0){
                    this.currHour = '00';
                    this.currMin = '00';
                    this.currSec = '00';
                    clearInterval(this.timer);
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
                        str += ' | ';
                    }
                }
            }else if(kind == 2){
                for(var i=0;i<pagenums.length;i++){
                    if(i<pagenums.length-1){
                        str += pagenums[i]+' | ';
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
            console.log(data.pagenums[index].itemdata);
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
        beiPageData(data,kind,str,index){
            switch(str){
                case '全':
                    data.pagenums[index].itemdata = [1,2,3,4,5,6,7,8,9,10];
                    break;
                case '大':
                    data.pagenums[index].itemdata = [6,7,8,9,10];
                    break;
                case '小':
                    data.pagenums[index].itemdata = [1,2,3,4,5];
                    break;
                case '单':
                    data.pagenums[index].itemdata = [1,3,5,7,9];
                    break;
                case '双':
                    data.pagenums[index].itemdata = [2,4,6,8,10];
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
        }
    }
}
</script>

