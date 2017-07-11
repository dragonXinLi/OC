/**
 * Created by LL on 2017/7/10.
 */
import React, { Component , PropTypes } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    ListView,
} from 'react-native';

var styles = StyleSheet.create({
	container:{
		flex:1,
		paddingTop:22,
	},
});

class ListViewBasics extends Component{
	constructor(props){
		super(props);
		const ds = new ListView.DataSource({rowHasChanged:(r1,r2)=>r1 !== r2});
		this.state = {
			dataSource:ds.cloneWithRows([
				'John' , 'Joel' , 'James' , 'Jimmy' , 'Jackson' , 'Jillian' , 'Julie',
                'John' , 'Joel' , 'James' , 'Jimmy' , 'Jackson' , 'Jillian' , 'Julie',
                'John' , 'Joel' , 'James' , 'Jimmy' , 'Jackson' , 'Jillian' , 'Julie',
                'John' , 'Joel' , 'James' , 'Jimmy' , 'Jackson' , 'Jillian' , 'Julie',
                'John' , 'Joel' , 'James' , 'Jimmy' , 'Jackson' , 'Jillian' , 'Julie',
                'John' , 'Joel' , 'James' , 'Jimmy' , 'Jackson' , 'Jillian' , 'Julie',
                'John' , 'Joel' , 'James' , 'Jimmy' , 'Jackson' , 'Jillian' , 'Julie',
                'John' , 'Joel' , 'James' , 'Jimmy' , 'Jackson' , 'Jillian' , 'Julie',
                'John' , 'Joel' , 'James' , 'Jimmy' , 'Jackson' , 'Jillian' , 'Julie',
                'John' , 'Joel' , 'James' , 'Jimmy' , 'Jackson' , 'Jillian' , 'Julie',
                'John' , 'Joel' , 'James' , 'Jimmy' , 'Jackson' , 'Jillian' , 'Julie',
			])
		};
	}
	render(){
		return(
			<View style={{flex:1 , paddingTop:0 , borderWidth:1 , borderColor:'red'}}>
				<ListView style = {{flex:1}}
					dataSource = {this.state.dataSource}
					renderRow = {(rowData)=><Text>{rowData}</Text>}
				/>
			</View>
		);
	}
}

//自定义组件
class CustomUI extends Component {
    render(){
        return(
			<View>
                {/*//定义了一个自定义属性*/}
				<Text>hello {this.props.text}</Text>
				<Text>hello2 {this.props.name}</Text>
			</View>
        );
    }
}

export default class RN extends Component{
	render(){
		return(
			<View style={{flex:1}}>
				{/*<CustomUI style = {{flex:1}} text = '1111' name = '22222'/>*/}
				{/*<CustomUI style = {{flex:1}} name = '222'/>*/}
				{/*<CustomUI style = {{flex:1}} text = '333'/>*/}
				<ListViewBasics style = {{flex:1}}></ListViewBasics>
			</View>

		);
	}
}

AppRegistry.registerComponent('RN' , ()=>RN);
