/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */
import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    Image,
} from 'react-native';

//flex Direction

export default class Index extends Component {
    render() {
        // return (
        //     <View style={[styles.height160, styles.row]}>
        //         <View style={[styles.height160,styles.part_1_left]}>
        //             <Text style={[styles.font30]}>1</Text>
        //         </View>
        //         <View style={[styles.height160,styles.part_1_right]}>
        //             <Text style={[styles.font30]}>2</Text>
        //         </View>
        //     </View>
        // );
        return(
            <View>
                {/*<NavigatorIOS initialRoute="title : 首页"/>*/}
                <View style={[styles.height160 , styles.row,]}>
                    <View style={[styles.height160 , styles.part_1_left]}>
                        <Text style={[styles.font14,styles.marTop18 , styles.marLeft10 , styles.green]}>我们约吧</Text>
                        <Text style={[styles.font10,styles.marTop14 , styles.marLeft10]}>恋爱家人好朋友 </Text>
                        <Image style={[styles.yue]} source={{url:''}}/>
                    </View>

                    <View style={[styles.height160 , styles.part_1_right]}>
                        <View style={[styles.row , {flex : 1}]}>
                            <View style={{flex : 1}}>
                                <Text style={[styles.font14 , {marginLeft:30} , styles.red]}>超低价值</Text>
                                <Text style={[styles.font14 , {fontSize : 12 , marginTop : 14 , marginLeft : 30 , color : 'red'}]}>十元惠生活</Text>
                            </View>
                            <View style={{flex : 1 ,marginTop : -13}}>
                                <Image style={[styles.hanbao]} source={{url:''}}/>
                            </View>
                        </View>
                        <View style={{flex:1, flexDirection:'row' , borderTopWidth:0.5 , borderColor:'#DDD8CE'}}>
                            <View style={{flex:1,borderRightWidth:1,borderColor:'#DDD8CE'}}>
                                <Text style={{color:'#F742AB' , marginLeft:5 , fontWeight : 'bold' , fontSize:15 , marginTop : 8}}>聚餐宴请</Text>
                                <Text style={{color:'red' , fontSize:12,marginTop: 14 , marginLeft: 5}}>朋友家人聚餐</Text>
                                <Image style={{height:25,width:25,alignSelf:'center' }} source={{url:''}}/>
                            </View>
                            <View style={{flex:1}}>
                                <Text style={[{color:'#F742AB' , marginTop:8 , marginLeft:5 ,} , styles.font14]}>名店抢购</Text>
                                <Text style={[{marginLeft : 5 , fontSize:12 , marginTop:4}]}>还有</Text>
                                <Text style={[{marginLeft : 5 , fontSize:12 , marginTop: 4}]}>12:06:12分</Text>
                            </View>
                        </View>
                    </View>
                </View>
                <View style={[{borderBottomWidth:1 , borderTopWidth:1 , borderColor:'#DDD8CE' , marginTop:40 , height:65 , flexDirection:'row' , paddingTop:10}]}>
                    <View style={[{flex:1}]}>
                        <Text style={[{fontSize:17 , color:'#FF7F60' , fontWeight:'900' , marginLeft:7}]}>医院吃大餐</Text>
                        <Text style={[{marginLeft:7 , fontSize:12 , marginTop:3 ,}]}>新用户专享</Text>
                    </View>
                    <View style={[{flex:1}]}>
                        <Image style={[{height:50 , width:120 ,}]} source={{url:''}}/>
                    </View>
                </View>
                <View >
                    {/*<Text style={[{fontSize:12 , color:'#97979A' , marginTop:3 , marginLeft:7}]}>烧烤6.6元起</Text>*/}
                    <View style={{flexDirection:'row',}}>
                        <View style={[styles.row , {flex:1 , borderColor:'#DDD8CE' , borderRightWidth:1} ]}>
                            <View style={{flex:2}}>
                                <Text style={{fontSize:17 , color:'#EA6644' , fontWeight:'bold' , marginLeft:7}}>撸串节狂欢</Text>
                                <Text style={[{fontSize:12 , color:'#97979A' , marginTop:3 , marginLeft:7}]}>烧烤6.6元起</Text>
                            </View>
                            <View style={[{flex:1 ,}]}>
                                <Image style={[{width:60 , height:55}]} source={{url:''}}/>
                            </View>
                        </View>
                        <View style={[{flex:1} , styles.row]}>
                            <View style={{flex:2}}>
                                <Text style={{fontSize:17 , color:'#EA6644' , fontWeight:'bold' , marginLeft:7}}>毕业旅行</Text>
                                <Text style={[{fontSize:12 , color:'#97979A' , marginTop:3 , marginLeft:7}]}>选好酒店才安心</Text>
                            </View>
                            <View style={{flex:1}}>
                                <Image style={{width:60 , height:55}} source={{url:''}}/>
                            </View>
                        </View>
                    </View>
                    <View style={{flexDirection:'row',}}>
                        <View style={[styles.row , {flex:1 , borderColor:'#DDD8CE' , borderRightWidth:1} ]}>
                            <View style={{flex:2}}>
                                <Text style={{fontSize:17 , color:'#EA6644' , fontWeight:'bold' , marginLeft:7}}>0元餐来袭</Text>
                                <Text style={[{fontSize:12 , color:'#97979A' , marginTop:3 , marginLeft:7}]}>免费吃喝玩乐购</Text>
                            </View>
                            <View style={[{flex:1 ,}]}>
                                <Image style={[{width:60 , height:55}]} source={{url:''}}/>
                            </View>
                        </View>
                        <View style={[{flex:1} , styles.row]}>
                            <View style={{flex:2}}>
                                <Text style={{fontSize:17 , color:'#EA6644' , fontWeight:'bold' , marginLeft:7}}>热门团购</Text>
                                <Text style={[{fontSize:12 , color:'#97979A' , marginTop:3 , marginLeft:7}]}>大家都在买什么</Text>
                            </View>
                            <View style={{flex:1}}>
                                <Image style={{width:60 , height:55}} source={{url:''}}/>
                            </View>
                        </View>
                    </View>
                </View>
            </View>
        );
    }
}

var styles = StyleSheet.create({
    row:{
        flexDirection : 'row',
        paddingTop:20,
    },
    marTop18:{
        marginTop:18,
    },
    marTop14:{
        marginTop:14,
    },
    font14:{
        fontSize:14,
    },
    font10:{
        fontSize:10,
    },
    height160:{
        height:160,
    },
    yue:{
        height:80,
    },
    green:{
        color:'#55A44B',
        fontWeight:'900',
    },
    red:{
        color:'#FF3F0D',
        fontWeight:'900',
    },
    marLeft10:{
        marginLeft:10,
    },
    part_1_left:{
        flex:1,
        borderColor:'#DCD7CD',
        borderRightWidth:0.5,
        borderBottomWidth:1,
    },
    part_1_right:{
        flex:2,
        borderColor:'#DCD7CD',
        borderBottomWidth:1,
    },
    hanbao:{
        height:55,
        width:55,
    },
});

// AppRegistry.registerComponent('Index', () => Index);
