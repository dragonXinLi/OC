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
    ScrollView,
} from 'react-native';

class RN extends Component{
    render(){
        return(
            <ScrollView>
                <Text style={{fontSize:50}}>Scroll me</Text>
                <Text style={{fontSize:50}}>Scroll me</Text>
                <Text style={{fontSize:50}}>Scroll me</Text>
                <Text style={{fontSize:50}}>Scroll me</Text>
                <Text style={{fontSize:50}}>Scroll me</Text>
                <Text style={{fontSize:50}}>Scroll me</Text>
                <Text style={{fontSize:50}}>Scroll me</Text><Text style={{fontSize:96}}>Scroll me</Text>
                <Text style={{fontSize:50}}>Scroll me</Text>
                <Text style={{fontSize:50}}>Scroll me</Text>
                <Text style={{fontSize:50}}>Scroll me</Text><Text style={{fontSize:96}}>Scroll me</Text>
                <Text style={{fontSize:50}}>Scroll me</Text>
                <Text style={{fontSize:50}}>Scroll me</Text>
            </ScrollView>
        );
    }
}

var styles = StyleSheet.create({
    sss:{
        // rotation:'horizontal',
    },
}
);

AppRegistry.registerComponent('RN' , ()=>RN);