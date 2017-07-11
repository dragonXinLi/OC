import React, { Component , PropTypes } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    ListView,
    Image,
    TouchableOpacity,
    Platform,
    AsyncStorage,
} from 'react-native';

class NetUitl extends React.Component{
    static get(url,params,callback){
        if(params)
        {
            let paramsArray = [];
            Object.keys(params).forEach(key=>paramsArray.push(key + '=' + params[key]));
            if(url.search(/\?/) === -1)
            {
                url += '?' + paramsArray.join('&');
            }else
            {
                url += '&' +paramsArray.join('&');
            }
        }
        fetch(url,{
            method:'GET',
        }).then((response)=>{
            callback(response);
        }).done();
    }

    static post(url,params,headers,callback){
        fetch(url,{
            method:'POST',
            headers:{
                'token' : headers
            },
            body:JSON.stringify(params)
        }).then((response)=>response.json())
            .then((responseJSON)=>{
                callback(responseJSON)
            }).done();
    }
}

//自定义组件
class CustomUI extends Component {
    constructor(props){
        super(props);
        this.state = {
            text:null
        }
    }
    render(){
        let string = this.state.text ? this.state.text : this.props.text;
        return(
            <View>
                {/*//定义了一个自定义属性*/}
                <Text>{string}</Text>
                {/*<Text>hello2 {this.props.name}</Text>*/}
            </View>
        );
    }
}


export default class RN extends Component{
    render(){
        return(
            <View style={{flex:1}}>
                <TouchableOpacity onPress={this.ssss}>
                    <CustomUI text="访问" style={{}}></CustomUI>
                </TouchableOpacity>
            </View>
        );
    }
    ssss(){
        // let params = {'start':'0',limit:'20','isNeedCategory': true, 'lastRefreshTime': '2016-09-25 09:45:12'};
        // NetUitl.post('http://www.pintasty.cn/home/homedynamic',params,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiJVLTliZGJhNjBjMjZiMDQwZGJiMTMwYWRhYWVlN2FkYTg2IiwiZXhwaXJhdGlvblRpbWUiOjE0NzUxMTg4ODU4NTd9.ImbjXRFYDNYFPtK2_Q2jffb2rc5DhTZSZopHG_DAuNU',function (set) {
        //     //下面的就是请求来的数据
        //     console.log(set)
        // })
        //get请求,以百度为例,没有参数,没有header
        NetUitl.get('https://www.baidu.com','',function (set) {
            //下面是请求下来的数据
            console.log(set)

        })

    }
}

AppRegistry.registerComponent('RN' , ()=>RN);