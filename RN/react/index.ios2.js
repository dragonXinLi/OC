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
  View, TextInput,
} from 'react-native';

//fontsize,TextInput
export default class RN extends Component {
    constructor(props){
        super(props);
        this.state = {text : ''};
    }

  render() { 
    return (
      <View >
          <Text style={{fontSize:24}}>
              !!!!!!!!!!!!!!!
          </Text>
          <TextInput id = '2' style={{height:40,borderColor:'red',borderWidth:1}}
          multiline={true}
          // defaultValue  string 给文本输入设置一个默认初始值。
          defaultValue='默认信息1'
          />
          <TextInput
              style={{marginLeft:0,marginRight:10 , height:40,}}
              // autoFocus bool  设置是否默认获取到焦点默认为关闭(false)
              autoFocus={true}
              defaultValue='默认信息2'/>
          <TextInput
              style={{height:40,}}
              // editable bool  设置文本框是否可以编辑 默认值为true,可以进行编辑
              editable={false}
              defaultValue='默认信息3'/>


          <TextInput
              style={{height:40}}
              // placeholder string 当文本输入框还没有任何输入的时候，默认显示信息，当有输入的时候该值会被清除
              placeholder='Type here to translate !'
              onChangeText={(text) => this.setState({text})}
          />
          <Text style={{padding:10 , fontSize:42}}>
              {this.state.text.split(' ').map((word) => word && '🎂').join(' ')}
          </Text>
     </View>
    );
  }
}

var styles = StyleSheet.create({
    container: {
        flex: 1,
        // justifyContent: 'center',
        // // justifyContents: 'center',
        // alignItems: 'center',
        // backgroundColor: '#F5FCFF',
        height:200,
    },
});


AppRegistry.registerComponent('RN', () => RN); 