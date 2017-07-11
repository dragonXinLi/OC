/**
 * Created by sangfor on 2017/7/11.
 */

import React, { PureComponent } from 'react'
import {AppRegistry} from 'react-native'

import RootScene from './scene/RootScene';

export default class RN extends PureComponent{
    render(){
        return(
          <RootScene/>
        );
    }
}

AppRegistry.registerComponent('RN',()=>RN);