/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */
/*

    Node.js
    JSX
    Flexbox

*/
import React, { Component } from 'react'; //引入其他模块
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Image
} from 'react-native'; //批量定义组件
// var StyleShee = React.StyleSheet;
// var AppRegistry = React.AppRegistry;

export default class RN extends Component { //创建一个入口类
  // render() { //render方法就是渲染视图用的
  //   return ( //return返回的是视图的模板代码,jsx语法  //container是样式表中的一个样式  //style是视图的一个属性 styles是我们定义的样式表
  //   );
  // }
    render() {
        return (
            <View style={{marginLeft:5,marginTop:10,marginRight:5}}>

              <View style={{flexDirection:'row'}}>
                <View style={{width:70}}>
                  <Image source={require('./scene/Img/01.png')} style={{alignSelf:'center',width:45,height:45}} />
                  {/*//内联样式不会报类型错*/}
                  <Text style={[{marginTop:5,textAlign:'center',color:'#555555'} , styles.fontss]}>美食</Text>
                </View>
                <View style={{width:70}}>
                  <Image source={require('./scene/Img/02.png')} style={{alignSelf:'center',width:45,height:45}} />
                  <Text style={{marginTop:5,alignSelf:'center',fontSize:11,color:'#555555',textAlign:'center'}}>电影</Text>
                </View>
                <View style={{width:70}}>
                  <Image source={require('./scene/Img/03.png')} style={{alignSelf:'center',width:45,height:45}} />
                  <Text style={{marginTop:5,alignSelf:'center',fontSize:11,color:'#555555',textAlign:'center'}}>酒店</Text>
                </View>
                <View style={{width:70}}>
                  <Image source={require('./scene/Img/04.png')} style={{alignSelf:'center',width:45,height:45}} />
                  <Text style={{marginTop:5,alignSelf:'center',fontSize:11,color:'#555555',textAlign:'center'}}>KTV</Text>
                </View>
                <View style={{width:70}}>
                  <Image source={require('./scene/Img/05.png')} style={{alignSelf:'center',width:45,height:45}} />
                  <Text style={{marginTop:5,alignSelf:'center',fontSize:11,color:'#555555',textAlign:'center'}}>外卖</Text>
                </View>
              </View>
              <View style={{flexDirection:'row',marginTop:10}}>
                <View style={{width:70}}>
                  <Image source={require('./scene/Img/06.png')} style={{alignSelf:'center',width:45,height:45}} />
                  <Text style={{marginTop:5,textAlign:'center',fontSize:11,color:'#555555'}}>优惠买单</Text>
                </View>
                <View style={{width:70}}>
                  <Image source={require('./scene/Img/07.png')} style={{alignSelf:'center',width:45,height:45}} />
                  <Text style={{marginTop:5,alignSelf:'center',fontSize:11,color:'#555555',textAlign:'center'}}>周边游</Text>
                </View>
                <View style={{width:70}}>
                  <Image source={require('./scene/Img/08.png')} style={{alignSelf:'center',width:45,height:45}} />
                  <Text style={{marginTop:5,alignSelf:'center',fontSize:11,color:'#555555',textAlign:'center'}}>休闲娱乐</Text>
                </View>
                <View style={{width:70}}>
                  <Image source={require('./scene/Img/09.png')} style={{alignSelf:'center',width:45,height:45}} />
                  <Text style={{marginTop:5,alignSelf:'center',fontSize:11,color:'#555555',textAlign:'center'}}>今日新单</Text>
                </View>
                <View style={{width:70}}>
                  <Image source={{uri:'https://facebook.github.io/react/img/logo_og.png'}} style={{alignSelf:'center',width:45,height:45 }} />
                  <Text style={{marginTop:5,alignSelf:'center',fontSize:11,color:'#555555',textAlign:'center'}}>丽人</Text>
                </View>
              </View>
            </View>
        );
    }
}


const styles = StyleSheet.create({//提供视图的样式
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    // backgroundColor: '#F5FCFF',
    backgroundColor: 'red',
  },
  welcome: {
    fontSize: 40,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
    fontss:{
      fontSize : 12,
    }
});

AppRegistry.registerComponent('RN', () => RN); //注册应用入口，这个一定不能少，否则模拟器会提示报错：