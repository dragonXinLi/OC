/**
 * Created by sangfor on 2017/7/12.
 */
import React, { PureComponent } from 'react'
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    TouchableOpacity,
    TouchableHighlight,
} from 'react-native';

// Touchable*系列
// TouchableHighlight,TouchableNativeFeedback,TouchableOpacity,TouchableWithoutFeedback。

export default class RN extends PureComponent {
    constructor(props) {
        super(props);
        this.state = {
            eventLog: []
        }
    }

    render() {
        return (
            <View >
                <View style={[styles.row, {justifyContent: 'center'}]}>
                    <TouchableOpacity
                        style={[styles.wrapper, {}]}
                        // underlayColor  当触摸或者点击控件的时候显示出的颜色
                        underlayColor='red'
                        onPress={() => this._appendEvent('press')}
                        onPressIn={() => this._appendEvent('pressIn')}
                        onPressOut={() => this._appendEvent('pressOut')}
                        onLongPress={() => this._appendEvent('longPress')}>
                        <Text style={styles.button}>
                            Press Me
                        </Text>
                    </TouchableOpacity>
                </View>
                <View style={styles.eventLogBox}>
                    {/*箭头函数的 this 始终指向函数定义时的 this，而非执行时*/}
                    {this.state.eventLog.map((e, ii) => <Text key={ii}>{e}</Text>)}
                </View>
            </View>
        );
    }

    _appendEvent(eventName) {
        var limit = 6;
        var eventLog = this.state.eventLog.slice(0, limit - 1);
        // 插入到数组前面，所有的元素自动后移
        eventLog.unshift(eventName);
        this.setState({eventLog});
    }
}

const styles = StyleSheet.create({
    button: {
        color: '#007AFF',
    },
    wrapper: {
        borderRadius: 8,
    },
    eventLogBox: {
        padding: 10,
        margin: 10,
        height: 120,
        borderWidth: StyleSheet.hairlineWidth,
        borderColor: '#f0f0f0',
        backgroundColor: '#f9f9f9',
    },
});

AppRegistry.registerComponent('RN',()=>RN);