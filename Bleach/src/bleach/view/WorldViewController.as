package bleach.view
{
	import bleach.communicator.CommMarshal;
	import bleach.event.BleachDefenseEvent;
	import bleach.scene.vo.WorldNodeVO;
	import bleach.scene.vo.WorldVO;
	
	import flash.utils.Dictionary;

	public class WorldViewController extends ViewController implements IWorldViewController
	{
		private var _currentWorld:WorldVO = null;
		public function WorldViewController()
		{
			super();
		}
		
		public function changeWorld(world:WorldVO):void
		{
			if(world)
			{
				_currentWorld = world;
				initWorld(_currentWorld);
			}
		}
		
		protected function initWorld(value:WorldVO):void
		{
			clearNodes();
			
			var nodes:Vector.<WorldNodeVO> = value.nodes;
			var node:WorldNodeVO = null;
			for each(node in nodes)
			{
				var worldNode:WorldNode = new WorldNode(node);
				addNode(worldNode);
			}
		}
	}
}
import bleach.event.BleachDefenseEvent;
import bleach.message.BleachMessage;
import bleach.scene.IWorldNode;
import bleach.scene.vo.WorldNodeVO;
import bleach.texture.TextureManager;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import pixel.core.PixelSprite;
import pixel.message.IPixelMessage;
import pixel.texture.PixelTextureFactory;
import pixel.texture.vo.PixelTexture;

class WorldNode extends PixelSprite implements IWorldNode
{
	private var _node:WorldNodeVO = null;
	private var _image:PixelTexture = null;
	public function WorldNode(node:WorldNodeVO)
	{
		_node = node;
		x = node.position.x;
		y = node.position.y;
		_image = TextureManager.instance.findTextureById(node.portraitImageId);
		if(_image)
		{
			super(_image.bitmap);
		}
		this.addEventListener(MouseEvent.MOUSE_DOWN,eventMousePressed);
		this.addEventListener(MouseEvent.MOUSE_OVER,eventMouseOver);
		this.addEventListener(MouseEvent.MOUSE_UP,eventMouseRelease);
	}
	
	override public function dispose():void
	{
		this.removeEventListener(MouseEvent.MOUSE_DOWN,eventMousePressed);
		this.removeEventListener(MouseEvent.MOUSE_OVER,eventMouseOver);
		this.removeEventListener(MouseEvent.MOUSE_UP,eventMouseRelease);
	}
	
	public function get id():int
	{
		return _node.id;
	}
	public function get desc():String
	{
		return _node.desc;
	}
	
	private function eventMousePressed(event:MouseEvent):void
	{
		//var notify:BleachDefenseEvent = null;
		var msg:IPixelMessage = null;
		msg = new BleachMessage(BleachMessage.BLEACH_WORLD_REDIRECT,this);
		msg.value = _node;
		dispatchMessage(msg);
//		if(notify)
//		{
//			notify.value = _node.redirectId;
//			dispatchEvent(notify);
//		}
	}
	
	private function eventMouseRelease(event:MouseEvent):void
	{}
	private function eventMouseOver(event:MouseEvent):void
	{}
}