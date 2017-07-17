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
            // console.log(response);
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
            text:null,
            rs:null
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
                    <CustomUI text="访问网络" style={{}}></CustomUI>
                </TouchableOpacity>
            </View>
        );
    }
    ssss() {
        var REQUEST_URL = 'https://raw.githubusercontent.com/facebook/react-native/master/docs/MoviesExample.json';
        // // //get请求,
        // NetUitl.get(REQUEST_URL, '', function (set) {
        //
        //     //下面是请求下来的数据
        //     console.log(set);
        // });
        fetch(REQUEST_URL)
            .then((response) => response.json())// 把response转为json对象
            .then((responseData) => { //上面的转好的json
                 console.log(responseData.movies)
            })
            .done();
    }
}

AppRegistry.registerComponent('RN' , ()=>RN);