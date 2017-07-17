/**
 * Created by LL on 2017/7/9.
 */

import React, { Component , PropTypes } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
} from 'react-native';

class Blink extends Component { //自定义组件名称大写
    constructor(props){
        super(props);
        this.state = {showText: 'i dont love you'};

        setInterval(() => {
            this.setState(previousState =>{
                // return {showText: !previousState.showText};
                return {showText: 'i donttttt love you'};
            });
        } , 1000);
    }

    render(){
        // let display = this.state.showText ? this.props.text : '';
        return(
            <Text>{this.state.showText}</Text>
        );
    }
}

class RN extends Component{
    render(){
        return(
            <View>
                <Blink time='ss'/>
                <Blink time='2000'/>
                <Blink time='3000'/>
            </View>
        );
    }
}

AppRegistry.registerComponent('RN' , ()=>RN);