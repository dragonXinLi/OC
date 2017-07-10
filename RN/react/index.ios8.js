/**
 * Created by LL on 2017/7/10.
 */
import React, { Component , PropTypes } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    FlatList,
} from 'react-native';

var styles = StyleSheet.create({
	container:{
		flex:1,
		paddingTop:22,
	},
});

export default class RN extends Component{
	render(){
		return(
			<View style = {[styles.container]}>
				
			</View>
		);
	}
}

AppRegistry.registerComponent('RN' , ()=>RN);
