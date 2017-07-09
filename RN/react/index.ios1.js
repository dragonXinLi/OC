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

//自定义组件
class CustomUI extends Component {
    render(){
        return(
        <View>
            {/*//定义了一个自定义属性*/}
            <Text>hello {this.props.text}</Text>
            <Text>hello2 {this.props.name}</Text>
        </View>
        );
    }
}

class RN extends Component {
  render() { 
    return (
        <View style={{alignItems:'center'}}>
            {/*<Text style={styles.welcome}>*/}
                {/*图片22*/}
            {/*</Text>*/}
            {/*<Image style={styles.pic} source={{url: 'https://avatars3.githubusercontent.com/u/6133685?v=3&s=460'}}>*/}
            {/*</Image>*/}

            <CustomUI text = '1111' name = '22222'/>
            <CustomUI name = '222'/>
            <CustomUI text = '333'/>
        </View>
    );
  }
}

AppRegistry.registerComponent('RN', () => RN); 