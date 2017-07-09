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

//fontsize
export default class RN extends Component { 
  render() { 
    return (
        //内联样式不会报类型错
        /*//<View style={styles.container}>*/
      <View style={{top:64,height:100, borderWidth: 1, borderColor: 'red'}}>
      </View>
    );
  }
}

var styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        // justifyContents: 'center',
        alignItems: 'center',
        backgroundColor: '#F5FCFF',
    },
});


AppRegistry.registerComponent('RN', () => RN); 