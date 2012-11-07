package mapassistant.map.world
{
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import game.sdk.map.layer.GenericLayer;
	
	import mapassistant.data.table.TableSymbol;
	import mapassistant.resource.ResourceItem;
	import mapassistant.symbol.GenericSymbol;
	
	import utility.IDispose;
	import utility.ISerializable;

	public interface IWorld extends IEventDispatcher,IDispose,ISerializable
	{
		//function UpdateSymbolSprite(SymbolData:TableSymbol,Resource:ResourceItem):void;
		function WorldToXML():String;
		
		function get WorldWidth():uint;
		function get WorldHeight():uint;
		function get AreaWidth():uint;
		function get AreaHeight():uint;
		function AreaPartition(AreaWidth:uint,AreaHeight:uint):void;
		function SetArea(Column:uint,Row:uint):void
		function get WorldName():String;
		function set WorldName(Value:String):void;
		function get HasPartition():Boolean;
		function get DataGridLayer():GenericLayer;
		function get TerrainLayer():GenericLayer;
		
		function DataGridShowSwitch():void;
		function TerrainShowSwitch():void;
		function ItemShowSwitch():void;
		
		function CreateTerrain(Row:uint,Column:uint,TileWidth:uint,TileHeight:uint):void;
		
		function get width():Number;
		function get height():Number;
		
		/**
		 * 开启路点编辑
		 **/
		function EnableWalkEidt():void;
		
		/**
		 * 开启角色创建点编辑模式
		 **/
		function EnableRoleCreatorEdit():void;
		/**
		 * 开启元件编辑模式
		 **/
		function EnableSymbolEdit(Class:String):void;
		
		/**
		 * 复位当前编辑状态
		 **/
		function ResetEditMode():void;
		
		function UpdateSymbolSprite(Symbol:GenericSymbol,Resource:ResourceItem):void;
		
		function AddWalk(PosX:uint,PosY:uint):void;
	}
}