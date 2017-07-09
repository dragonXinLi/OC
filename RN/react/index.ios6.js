/**
 * Created by LL on 2017/7/10.
 */
import React, { Component , PropTypes } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    TextInput,
} from 'react-native';

//TextInput
class RN extends Component{
    constructor(props){
        super(props);
        this.state = {text : ''};
    }

    render(){
        return(
            <View style={{padding:10}}>
                <TextInput
                    style={{height:40}}
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

AppRegistry.registerComponent('RN' , ()=>RN);