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

//flex

export default class RN extends Component {
    render() {
        return (
            <View style={styles.style_0}>
               <View style={styles.style_1}>
                   <Text>1/4高</Text>
                   <Text>1/4高</Text>
               </View>
                <View style={[styles.style_1 , {flexDirection:'column'}]}>
                    <Text>1/4高</Text>
                    <Text>1/4高</Text>
                </View>
                <View style={{flex:10}}></View>
            </View>
        );
    }
}

var styles = StyleSheet.create({
    style_0 : {
        flex:1,
        borderWidth:1,
        borderColor:'red',
    },
    style_1:{
        flex:5,
        height:40,
        flexDirection : 'row',
        borderWidth:1,
        borderColor:'red',
    },
    text14:{
        fontSize:14,
    },
});


AppRegistry.registerComponent('RN', () => RN);