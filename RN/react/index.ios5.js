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
        this.state = {showText: true};

        setInterval(() => {
            this.setState(previousState =>{
                return {showText: !previousState.showText};
            });
        } , 1000);
    }

    render(){
        let display = this.state.showText ? this.props.text : '';
        return(
            <Text>{display}</Text>
        );
    }
}

class RN extends Component{
    render(){
        return(
            <View>
                <Blink text = 'I lovve blink'/>
                <Blink text = 'Yes Blink is so great'/>

            </View>
        );
    }
}

AppRegistry.registerComponent('RN' , ()=>RN);