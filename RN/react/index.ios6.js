/**
 * Created by LL on 2017/7/10.
 */
import React, { Component , PropTypes } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    Picker,
    PickerIOS,
} from 'react-native';

var PickerItemIOS = PickerIOS.Item;
var COURSE_ITEMS=['C++','Java','Android','iOS','React Native','Swift','.Net'];
class RN extends Component{
    constructor(props){
        super(props);
        this.state = {language: ''};
    }

    render() {
        return (
            <View style={styles.container}>
                <Text >
                    Picker选择器实例
                </Text>
                <Picker
                    style={{width:200}}
                    // 选择器选中的item所对应的值，该可以是一个字符串或者一个数字
                    selectedValue={this.state.language}
                    onValueChange={(value) => this.setState({language: value})}>
                    <Picker.Item label="React" value='React' />
                    <Picker.Item label="React Native" value='React Native'/>
                    <Picker.Item label="React Native2" value='React Native'/>
                    <Picker.Item label="React Native3" value='React Native3'/>
                    <Picker.Item label="React Native4" value='React Native4'/>
                    <Picker.Item label="React Native5" value='React Native5'/>
                    <Picker.Item label="React Native6" value='React Native6'/>
                    <Picker.Item label="React Native7" value='React Native7'/>
                </Picker>
                <Text>当前选择的是:{this.state.language}</Text>

                <PickerIOS/>
            </View>
        );
    }
}

class PickerIOS extends Component
{
    constructor(props){
        super(props);
        this.state={
            selectedCourse:'Java',
            selectedIndex:1,
        };
    }
    render() {
        return (
            <View >
                <Text style={styles.welcome}>
                    PickerIOS
                </Text>
                <PickerIOS
                    // itemStyle itemStylePropType  选择器每一项数据显示的样式
                    itemStyle={{fontSize: 25, color: 'red', textAlign: 'center', fontWeight: 'bold'}}
                    // selectedValue  any 选中的值
                    selectedValue={this.state.selectedCourse}
                    // onValueChange    function 方法  当值发生变化的时候进行回调
                    onValueChange={(selectedCourse,selectedIndex)=> this.setState({selectedCourse,selectedIndex})}>
                    <PickerItemIOS
                        key='0'
                        value='C++'
                        label='C++'
                    />
                    <PickerItemIOS
                        key='1'
                        value='Java'
                        label='Java'
                    />
                    <PickerItemIOS
                        key='2'
                        value='Android'
                        label='Android'
                    />
                    <PickerItemIOS
                        key='3'
                        value='iOS'
                        label='iOS'
                    />
                    <PickerItemIOS
                        key='4'
                        value='React Native'
                        label='React Native'
                    />
                    <PickerItemIOS
                        key='5'
                        value='Swift'
                        label='Swift'
                    />
                    <PickerItemIOS
                        key='5'
                        value='.Net'
                        label='.Net'
                    />
                </PickerIOS>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        // justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#F5FCFF',
    },

    welcome: {
        fontSize: 20,
        textAlign: 'center',
        marginTop: 20,
    },
});

AppRegistry.registerComponent('RN' , ()=>RN);