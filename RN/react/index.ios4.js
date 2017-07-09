/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */
import React, { Component , PropTypes } from 'react';
import {
    AppRegistry,
    StyleSheet,
    NavigatorIOS,
    TouchableHighlight,
    Text,
} from 'react-native';
// var Index = require('./pagaes/Index');

export default class RN extends Component {
    render() {
        return (
            <NavigatorIOS
                style = {styles.container}
                initialRoute={{
                    title:'首页',
                    component:MyScene,
                }}
            />
        );
    }
}

class MyScene extends Component{
    static propTypes = {
        title:PropTypes.string.isRequired,
        navigator:PropTypes.object.isRequired,
    }
    constructor(props , context)
    {
        super(props , context);
        this._onForward = this._onForward.bind(this);
    }
    _onForward(){
        this.props.navigator.push({
            title:'Scene' + nextIndex,
        })
    }

    render(){
        return (
            <View>
                <Text>Current Scene:{this.props.title}</Text>
                <TouchableHighlight onPress = {this._onForward()}>
                    <Text>Tap me to load the next scene</Text>
                </TouchableHighlight>
            </View>
        )
    }
}


var styles = StyleSheet.create({
    container:{
        flex:1,
    },
});

AppRegistry.registerComponent('RN', () => RN);