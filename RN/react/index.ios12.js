/**
 * Created by sangfor on 2017/7/12.
 */

import React, { PureComponent } from 'react'
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    ScrollView,
    RefreshControl,
} from 'react-native';


const styles = StyleSheet.create({
    row: {
        borderColor: 'red',
        borderWidth: 5,
        padding: 20,
        backgroundColor: '#3a5795',
        margin: 5,
    },
    text: {
        alignSelf: 'center',
        color: '#fff',
    },
    scrollview: {
        flex: 1,
    },
});

class Row extends PureComponent{
    _onClick() {
    this.props.onClick(this.props.data);
    }
    render() {
    return (
        <View style={styles.row}>
            <Text style={styles.text}>
                {this.props.data.text}
            </Text>
        </View>
    );
    }
}

class RefreshControlXY extends PureComponent
{
    constructor(props)
    {
        super(props);
        this.state = {
            isRefreshing: false,
            loaded: 0,
            rowData: Array.from(new Array(20)).map(
                (val, i) => ({text: '初始行 ' + i})),
        }
    }
    render() {
        const rows = this.state.rowData.map((row, ii) => {
            return <Row key={ii} data={row}/>;
        });
        return (
            <ScrollView
                style={styles.scrollview}
                refreshControl={
                    <RefreshControl
                        // refreshing  bool  决定加载进去指示器是否为活跃状态，也表明当前是否在刷新中
                        refreshing={this.state.isRefreshing}
                        // onRefresh  function方法 当视图开始刷新的时候调用
                        onRefresh={this._onRefresh}
                        // progressBackgroundColor ColorPropType  设置加载进度指示器的背景颜色
                        progressBackgroundColor="#ffffff"
                    />
                }>
                {rows}
            </ScrollView>
        );
    }

    _onRefresh() {
        this.setState({isRefreshing: true});
        setTimeout(() => {
            // 准备下拉刷新的5条数据
            const rowData = Array.from(new Array(5))
                .map((val, i) => ({
                    text: '刷新行 ' + (+this.state.loaded + i)
                }))
                .concat(this.state.rowData);

            this.setState({
                loaded: this.state.loaded + 5,
                isRefreshing: false,
                rowData: rowData,
            });
        }, 5000);
    }

}

AppRegistry.registerComponent('RN',()=>RN);