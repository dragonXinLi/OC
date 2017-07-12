/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */
import React, { Component , PropTypes } from 'react';
import {
    AppRegistry,
    View,
} from 'react-native';

import HomeScene from './pagaes/index'

export default class RN extends Component {
    render() {
        return (
            <View>
                <HomeScene/>
            </View>
        );
    }
}

AppRegistry.registerComponent('RN', () => RN);