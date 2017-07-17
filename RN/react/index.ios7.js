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
        <View>
            <TextInput
                style={{marginLeft:0,marginRight:10 , height:40,}}
                // autoFocus bool  设置是否默认获取到焦点默认为关闭(false)
                autoFocus={true}
                defaultValue='默认信息2'/>
            <ScrollView showsVerticalScrollIndicator={true}
                        contentContainerStyle={styles.contentContainer}
                // horizontal = {false}
                        keyboardDismissMode = 'none'
                >
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
        </View>
        );
    }
}

var styles = StyleSheet.create({
        container: {
            height:400,
            justifyContent: 'center',
            alignItems: 'center',
            backgroundColor: '#F5FCFF',
        },
        contentContainer: {
            margin:10,
            backgroundColor:"#ff0000",
        }
}
);

AppRegistry.registerComponent('RN' , ()=>RN);