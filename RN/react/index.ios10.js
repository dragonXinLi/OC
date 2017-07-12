/**
 * Created by sangfor on 2017/7/11.
 */

import React, { PureComponent } from 'react'
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    TouchableOpacity,
    TouchableHighlight,
    TabBarIOS,
} from 'react-native';
import { Navigator } from 'react-native-deprecated-custom-components';

class NavButton extends PureComponent{
    render() {
        return (
            <TouchableHighlight
                style={styles.button}
                underlayColor="#B5B5B5"
                onPress={this.props.onPress}>
                <Text style={styles.buttonText}>{this.props.text}</Text>
            </TouchableHighlight>
        );
    }
}

class NavMenu extends PureComponent {
    render() {
        return (
            <View style={styles.scene}>
                <Text style={styles.messageText}>{this.props.message}</Text>
                <NavButton
                    onPress={() => {
                        this.props.navigator.push({
                            message: '向右拖拽关闭页面',
                            sceneConfig: Navigator.SceneConfigs.FloatFromRight,

                            // component: SecondPage,
                            // passProps:{
                            //     message:this.props.message
                            // },
                            // onPress:this.onPress,
                        });
                    }}
                    text="从右边向左切入页面(带有透明度变化)"
                />
                <NavButton
                    onPress={() => {
                        // push(route)     导航切换到一个新的页面中，新的页面进行压入栈
                        this.props.navigator.push({
                            message: '向下拖拽关闭页面',
                            sceneConfig: Navigator.SceneConfigs.FloatFromBottom,
                        });
                    }}
                    text="从下往上切入页面(带有透明度变化)"
                />
                <NavButton
                    onPress={() => {
                        // pop()   当前页面弹出来，跳转到栈中下一个页面，并且卸载删除掉当前的页面
                        this.props.navigator.pop();
                    }}
                    text="页面弹出(回退一页)"
                />
                <NavButton
                    onPress={() => {
                        // popToTop()  进行弹出页面，导航到栈中的第一个页面，弹出来的所有页面会被卸载删除
                        this.props.navigator.popToTop();
                    }}
                    text="页面弹出(回退到最后一页)"
                />
            </View>
        );
    }
}

class SecondPage extends PureComponent {
    render() {
        return (
            <View style={styles.container}>
                <TouchableOpacity
                    style={styles.button}
                    onPress={()=>this.props.navigator.pop()}>
                    <Text style={styles.buttonText}>
                        返回上一页, 来源: {this.props.message}
                    </Text>
                </TouchableOpacity>
            </View>
        );
    }
}

class TabBar extends PureComponent{
    constructor(props){
        super(props);
        this.state={
            selectedTab: '历史',
            notifCount: 0,
            presses: 0,
            custom: 0,
        };
    }
    //进行渲染页面内容
    _renderContent(color, pageText, num) {
        return (
            <View style={[styles.tabContent, {backgroundColor:color}]}>
            <Text style={styles.tabText}>{pageText}</Text>
            <Text style={styles.tabText}>第 {num} 次重复渲染{pageText}</Text>
            </View>
            );
    }
    render() {
        return (
            <View style={{flex:1}}>

                <Text style={styles.welcome}>
                    TabBarIOS
                </Text>
                <TabBarIOS
                    style={{flex:1,alignItems:"flex-end"}}
                    // tintColor  当前被选中图标的颜色
                    tintColor="white"
                    translucent = {true}
                    // barTintColor  color  设置tab条的背景颜色
                    barTintColor="red"
                >
                    <TabBarIOS.Item
                        // title   string    在Tab按钮图标下面显示的标题信息，如果你设置了SystemIcon属性，那么该属性会被忽略
                        title="自定义"
                        // icon  Image.propTypes.source    Tab按钮自定义的图标，如果systemicon属性被定义了，那么该属性会被忽略
                        // icon={require('./scene/Img/01.png')}

                        // 'bookmarks','contacts','downloads','favorites','featured','history','more','most-recent','most-viewed','recents','search','top-rated'
                        systemIcon="contacts"
                        // selected  bool    该属性标志子页面是否可见，
                        selected={this.state.selectedTab === '自定义'}
                        // onPress  function   当Tab按钮被选中的时候进行回调，你可以设置selected={true}来设置组件被选中
                        onPress={() => {
                            this.setState({
                                selectedTab: '自定义',
                                custom: this.state.custom + 1,
                            });
                        }}
                    >
                        {this._renderContent('#414A8C', '自定义界面',this.state.custom)}
                    </TabBarIOS.Item>
                    <TabBarIOS.Item
                        systemIcon="history"
                        selected={this.state.selectedTab === '历史'}
                        // badge   string,number  在图标的右上方显示小红色气泡，显示信息
                        badge={this.state.notifCount > 0 ? this.state.notifCount : undefined}
                        onPress={() => {
                            this.setState({
                                selectedTab: '历史',
                                notifCount: this.state.notifCount + 1,
                            });
                        }}
                    >
                        {this._renderContent('#783E33', '历史记录', this.state.notifCount)}
                    </TabBarIOS.Item>
                    <TabBarIOS.Item
                        systemIcon="downloads"
                        selected={this.state.selectedTab === '下载'}
                        onPress={() => {
                            this.setState({
                                selectedTab: '下载',
                                presses: this.state.presses + 1
                            });
                        }}>
                        {this._renderContent('#21551C', '下载页面', this.state.presses)}
                    </TabBarIOS.Item>

                </TabBarIOS>
            </View>
        );
}
}

export default class RN extends PureComponent{
    render() {
        return (
            <View style = {{flex:1}}>

                {/*<Navigator*/}
                    {/*style={styles.container}*/}
                    {/*initialRoute={{ message: '初始页面', }}*/}
                    {/*// Navaigator根据指定的路由进行渲染指定的界面*/}
                    {/*renderScene={ (route, navigator) => <NavMenu*/}
                        {/*message={route.message}*/}
                        {/*navigator={navigator}*/}
                    {/*/>}*/}
                    {/*// 改变页面切换的动画或者页面的手势*/}
                    {/*configureScene={(route) => {*/}
                        {/*if (route.sceneConfig) {*/}
                            {/*return route.sceneConfig;*/}
                        {/*}*/}
                        {/*return Navigator.SceneConfigs.FloatFromBottom;*/}
                    {/*}}*/}
                {/*/>*/}

            <TabBar/>

            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    messageText: {
        fontSize: 17,
        fontWeight: '500',
        padding: 15,
        marginTop: 50,
        marginLeft: 15,
    },
    button: {
        backgroundColor: 'white',
        padding: 15,
        borderBottomWidth: StyleSheet.hairlineWidth,
        borderBottomColor: '#CDCDCD',
    },

    //TabBar
    tabContent: {
        flex: 1,
        alignItems: 'center',
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        // marginTop: 20,
    },
    tabText: {
        color: 'white',
        margin: 50,
    },
});

AppRegistry.registerComponent('RN',()=>RN);