/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */
/*

    Node.js基础
    JSX语法基础
    Flexbox布局

*/
import React, { Component } from 'react'; //可以引入其他模块
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
  render() { //render方法就是渲染视图用的
    return ( //return返回的是视图的模板代码,jsx语法  //container是样式表中的一个样式  //style是视图的一个属性 styles是我们定义的样式表
      <View style={styles.container}> 
        <Text style={styles.welcome}> 
          111111
        </Text>
        <Text style={styles.instructions}>
          22222
        </Text>
        <Text style={styles.instructions}>
          哈哈哈哈哈哈哈哈
        </Text>
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
});

AppRegistry.registerComponent('RN', () => RN); //注册应用入口，这个一定不能少，否则模拟器会提示报错：