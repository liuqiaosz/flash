package editor.ui
{
	import editor.event.NotifyEvent;
	import editor.model.ComponentModel;
	import editor.model.ModelFactory;
	import editor.model.ModelFactoryBAJK;
	import editor.uitility.ui.event.UIEvent;
	import editor.utils.Globals;
	import editor.utils.InlineStyle;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.EventPhase;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.text.engine.TextLine;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.controls.Alert;
	import mx.core.UIComponent;
	import mx.events.DragEvent;
	import mx.utils.StringUtil;
	
	import pixel.ui.control.IUIControl;
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UIContainer;
	import pixel.ui.control.UIControl;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.UIPanel;
	import pixel.ui.control.asset.AssetImage;
	import pixel.ui.control.asset.IAsset;
	import pixel.ui.control.event.ControlEditModeEvent;
	import pixel.ui.control.event.EditModeEvent;
	import pixel.ui.control.event.UIControlEvent;
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.control.utility.Utils;
	import pixel.ui.control.vo.UIControlMod;
	import pixel.ui.control.vo.UIMod;
	import pixel.ui.control.vo.UIStyleMod;
	import pixel.utility.IDispose;
	import pixel.utility.Tools;
	
	import spark.components.Group;
	
	/**
	 * 
	 * 工作区容器
	 * 因为要用到sprite的组件,所以增加一个容器进行组件管理
	 * 
	 **/
	public class WorkspacePlus extends UIComponent implements IDispose
	{
		private var _Children:Vector.<IUIControl> = new Vector.<IUIControl>();
		//新创建组件的基本信息
		private var _ComponentProfile:ComponentProfile = null;
		//当前选择的控件
		private var _focus:UIControl = null;
		//控件层
		private var _controlLayer:Sprite = null;
		//编辑器效果层
		private var _effectLayer:Sprite = null;
		
		private var _focusBox:FocusBox = null;
		
		public function WorkspacePlus()
		{
			_controlLayer = new Sprite();
			_effectLayer = new Sprite();
			_focusBox = new FocusBox();
			super.addChild(_controlLayer);
			super.addChild(_effectLayer);
			
			_effectLayer.addChild(_focusBox);
			//			if(Profile)
			//			{
			//				BuildWorkspace(Profile);
			//			}
			
			//this.addEventListener(ControlEditModeEvent.CHILDSELECTED,OnControlChildSelect);
			_controlLayer.addEventListener(MouseEvent.MOUSE_DOWN,DragStart,true);
			/*
			_controlLayer.addEventListener(UIControlEvent.EDIT_LOADRES_OUTSIDE,function(event:UIControlEvent):void{
				
			});
			*/
		}
		
		//		public function IsContainer(Item:UIControl):Boolean
		//		{
		//			return Item == _Container;
		//			
		//		}
		
		public function get Children():Vector.<IUIControl>
		{
			return _Children;
		}
		/*
		public function OnComponentChoice(Obj:Object):void
		{
			if(Obj == this)
			{
				return;
			}
			var Choice:UIControl = null;
			if(Obj is TextLine)
			{
				Choice = TextLine(Obj).parent as UIControl;
			}
			else
			{
				Choice = Obj as UIControl;
			}
			if(Choice)
			{
				if(_FocusControl)
				{
					_FocusControl.FrameUnfocus();
				}
				
				_FocusControl = Choice;
				if(_FocusControl)
				{
					_FocusControl.FrameFocus();
					
					var ChoiceNotify:NotifyEvent = new NotifyEvent(NotifyEvent.COMPONENT_SELECTED);
					ChoiceNotify.Params.push(_FocusControl);
					dispatchEvent(ChoiceNotify);
					
					if(_Children.indexOf(_FocusControl) >= 0)
					{
						_FocusControl.dispatchEvent(new NotifyEvent(NotifyEvent.COMPONENT_DRAG_START));
					}
				}
			}
		}
		*/
				public function dispose():void
				{
					
					if(_Children && _Children.length > 0)
					{
						var Obj:DisplayObject = null;
						
						while(Obj = _Children.pop())
						{
							if(contains(Obj))
							{
								removeChild(Obj);
							}
						}
					}
				}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			_Children.push(child);
			return _controlLayer.addChild(child);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			if(_Children.indexOf(child) >= 0)
			{
				_Children.splice(_Children.indexOf(child),1);
			}
			return _controlLayer.removeChild(child);
		}
		
		private var OffsetX:int = 0;
		private var OffsetY:int = 0;
		//private var dragControl:UIControl = null;
		//private var pos:Point = new Point();
		private function DragStart(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			
			if(event.target is UIControl)
			{
				_focus = event.target as UIControl;
				//pos.x = _focus.x;
				//pos.y = _focus.y;
				
				//pos = stage.localToGlobal(pos);
				
				//pos = _effectLayer.globalToLocal(pos);
				
				_focusBox.x = _effectLayer.mouseX - event.localX;
				_focusBox.y = _effectLayer.mouseY - event.localY;
				_focusBox.control = _focus;
				var ChoiceNotify:NotifyEvent = new NotifyEvent(NotifyEvent.COMPONENT_SELECTED);
				ChoiceNotify.Params.push(_focus);
				dispatchEvent(ChoiceNotify);
				
				if(_Children.indexOf(_focus) >= 0)
				{
					//_FocusControl.dispatchEvent(new NotifyEvent(NotifyEvent.COMPONENT_DRAG_START));
				}
				
				//OnComponentChoice(event.target);
				/*
				if(_Children.indexOf(_focus) >= 0 )
				{
					
				}
				*/
				//var Offset:Point = new Point(event.stageX,event.stageY);
				//Offset = DragTarget.globalToLocal(Offset);
				OffsetX = _focus.mouseX;
				OffsetY = _focus.mouseY;
				stage.addEventListener(MouseEvent.MOUSE_MOVE,dragControlMove);
				stage.addEventListener(MouseEvent.MOUSE_UP,DragEnd);
			}
			else
			{
				_focus = null;
				_focusBox.close();
			}
		}
		
		public function DeleteCurrentShell():void
		{
			if(_focus)
			{
				if(_Children.indexOf(_focus) >= 0)
				{
					removeChild(_focus);
					_focus = null;
				}
				else
				{
					_focus.owner.removeChild(_focus);
					_focus = null;
					_focusBox.close();
				}
			}
		}
		
		
		private var TransPoint:Point = new Point();
		private var PosX:int = 0;
		private var PosY:int = 0;
		private function dragControlMove(Event:MouseEvent):void
		{
			TransPoint.x = _focus && _focus.owner ? _focus.owner.mouseX:_controlLayer.mouseX;
			TransPoint.y = _focus && _focus.owner ? _focus.owner.mouseY:_controlLayer.mouseY;
			//TransPoint = globalToLocal(TransPoint);
			PosX = TransPoint.x - OffsetX;
			PosY = TransPoint.y - OffsetY;
			
			var w:int = _focus && _focus.owner is UIControl ? _focus.owner.width:width;
			var h:int = _focus && _focus.owner is UIControl ? _focus.owner.height:height;
			if(PosX + _focus.width > (w))
			{
				PosX = w - _focus.width;
			}
			if(PosY + _focus.height > h)
			{
				PosY = h - _focus.height;
			}
			if(PosX < 0)
			{
				PosX = 0;
			}
			if(PosY < 0)
			{
				PosY = 0;
			}
			_focus.x = PosX;
			_focus.y = PosY;
			
			var t:Point = new Point();
			t.x = PosX;
			t.y = PosY;
			
			_focusBox.x = _effectLayer.mouseX - _focus.mouseX;
			_focusBox.y = _effectLayer.mouseY - _focus.mouseY;
			/*
			if(_focusBox.parent && _focusBox.parent is UIControl)
			{
				if(_focusBox.x + _focusBox.width > _focusBox.parent.x + _focusBox.parent.width)
				{
					_focusBox.x = (_focusBox.parent.x + _focusBox.parent.width) - _focusBox.width;
				}
				
				if(_focusBox.y + _focusBox.height > _focusBox.parent.y + _focusBox.parent.height)
				{
					_focusBox.y = (_focusBox.parent.y + _focusBox.parent.height) - _focusBox.height;
				}
			}
			*/
		}
		
		private function DragEnd(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,dragControlMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP,DragEnd);
			//_focus = null;
		}
		
		
		/**
		 * 
		 * 
		 * 
		 **/
		public function GenerateControlModel():ByteArray
		{
			var controls:Vector.<UIControlMod> = new Vector.<UIControlMod>();
			for each(var control:IUIControl in _Children)
			{
				controls.push(new UIControlMod(control));
			}
			var mod:UIMod = new UIMod(controls,InlineStyle.styles);
			var data:ByteArray = UIControlFactory.instance.encode(mod);
			//InlineStyle.clear();
			return data;
			
//			var Data:ByteArray = new ByteArray();
//			
//			//Control count
//			var Count:int = _Children.length;
//			Data.writeShort(Count);
//			
//			for each(var Child:UIControl in _Children)
//			{
//				var ChildModel:ByteArray = Child.Encode();
//				Data.writeInt(ChildModel.length);
//				Data.writeBytes(ChildModel,0,ChildModel.length);
//			}
//			//return ModelFactory.Instance.Encode(_Container ?_Container:_Children[0],_Children,Componenet);
//			return Data;
		}
		private var _originalData:ByteArray = null;
		private var _originalNav:String = "";
		public function get originalModel():ByteArray
		{
			return _originalData;
		}
		public function get originalNav():String
		{
			return _originalNav;
		}
		
		public function DecodeWorkspaceByModel(Model:ByteArray,fileNav:String = ""):void
		{
			dispose();
			_originalData = Tools.byteArrayClone(Model);
			_originalNav = fileNav;
			Model.position = 0;

			var mod:UIMod = UIControlFactory.instance.decode(Model,false);
			
			var controls:Vector.<IUIControl> = new Vector.<IUIControl>();
			for each(var controlMod:UIControlMod in mod.controls)
			{
				controls.push(controlMod.control);
			}
			//var controls:Vector.<IUIControl> = mod.controls;
			//var styles:Vector.<UIStyleMod> = mod.styles;
			InlineStyle.styles = mod.styles;
			for each(var child:UIControl in controls)
			{
				child.EnableEditMode();
				addChild(child);
			}
//			var Count:int = Model.readShort();
//			var Len:int = 0;
//			var Child:ByteArray = new ByteArray();
//			var Type:int = 0;
//			var Cls:Object = null;
//			var Control:UIControl = null;
//			for(var Idx:int = 0; Idx<Count; Idx++)
//			{
//				Len = Model.readInt();
//				Model.readBytes(Child,0,Len);
//				
//				Type = Child.readByte();
//
//				Cls = Utils.GetPrototypeByType(Type);
//				
//				if(Cls)
//				{
//					Control = new Cls() as UIControl;
//					if(Control)
//					{
//						Control.addEventListener(UIControlEvent.EDIT_LOADRES_OUTSIDE,function(event:UIControlEvent):void{
//							var AssetItem:IAsset = Globals.FindAssetByAssetId(event.Message) as IAsset;
//							if(null != AssetItem && AssetItem is AssetImage)
//							{
//								UIControl(event.target).BackgroundImage = AssetImage(AssetItem).image;
//							}
//							
//						},false,0);
//						Control.Decode(Child);
//						Control.EnableEditMode();
//						addChild(Control);
//					}
//				}
//				Child.position = 0;
//			}
		}
		
		public function DecodeModelByByteOld(Model:ByteArray):void
		{
			Model.position = 0;
			dispose();
			var Component:ComponentModel = ModelFactory.Instance.Decode(Model);
			Component.Control.EnableEditMode();
			addChild(Component.Control);
		}
		
//		public function BuildComponent(Component:ComponentModel):void
//		{
//			if(_ComponentProfile.Category == 1)
//			{
//				IsComplex = true;
//				_Container = addChild(Component.Control) as Container;
//				_ContainerControl = _Container;
//				_Container.EnableEditMode();
//				_Container.addEventListener(MouseEvent.MOUSE_DOWN,function(event:MouseEvent):void{
//					OnComponentChoice(event.target);
//					}
//				});
//				var Child:UIControl = null;
//				for(var Idx:int=0; Idx<Component.Children.length; Idx++)
//					//for each(Child in _Container.Children)
//				{
//					//Child.EnableEditMode();
//					//addChild(Child);
//					if(Component.Symbol[Idx] != null)
//					{
//						var CustomerComponent:ComponentModel = new ComponentModel();
//						CustomerComponent.PackageName = StringUtil.trim(String(Component.Symbol[Idx]).substr(0,50));
//						CustomerComponent.ClassName = StringUtil.trim(String(Component.Symbol[Idx]).substr(50));
//						var a:ComponentModel = ModelFactory.Instance.FindModelByFullName(CustomerComponent.PackageName,CustomerComponent.ClassName);
//						CustomerComponent.ModelByte = a.ModelByte;
//						CustomerComponent.Category = a.Category;
//						CustomerComponent.Control = Component.Children[Idx];
//						AddComponent(CustomerComponent);
//					}
//					else
//					{
//						Child = Component.Children[Idx] as UIControl;
//						Child.EnableEditMode();
//						addChild(Component.Children[Idx]);
//					}
//				}
//			}
//			else
//			{
//				Component.Control.EnableEditMode();
//				var ChoiceNotify:NotifyEvent = new NotifyEvent(NotifyEvent.COMPONENT_SELECTED);
//				ChoiceNotify.Params.push(Component.Control);
//				dispatchEvent(ChoiceNotify);
//				Component.Control.FrameFocus();
//				addChild(Component.Control);
//			}
//		}
		
		/**
		 * 模型数据解码
		 **/
//		public function DecodeModel(ModelFile:File):void
//		{
//			var Reader:FileStream = new FileStream();
//			if(ModelFile && ModelFile.exists)
//			{
//				Reader.open(ModelFile,FileMode.READ);
//				var ModelData:ByteArray = new ByteArray();
//				Reader.readBytes(ModelData,0,Reader.bytesAvailable);
//				ModelData.position = 0;
//				
//				var Component:ComponentModel = ModelFactory.Instance.Decode(ModelData);
//				_ComponentProfile = Component;
//				dispose();
//				if(_ComponentProfile.Category == 1)
//				{
//					IsComplex = true;
//					_Container = addChild(Component.Control) as Container;
//					_ContainerControl = _Container as UIControl;
//					for(var Idx:int=0; Idx<Component.Children.length; Idx++)
//					{
//						if(Component.Symbol[Idx] != null)
//						{
//							var CustomerComponent:ComponentModel = new ComponentModel();
//							CustomerComponent.PackageName = String(Component.Symbol[Idx]).substr(0,50);
//							CustomerComponent.ClassName = String(Component.Symbol[Idx]).substr(50);
//							CustomerComponent.ModelByte = Component.Children[Idx].Encode();
//							CustomerComponent.Control = Component.Children[Idx];
//							this.AddComponent(CustomerComponent);
//						}
//						else
//						{
//							addChild(Component.Children[Idx]);
//						}
//					}
//				}
//				else
//				{
//					Component.Control.EnableEditMode();
//					Component.Control.FrameFocus();
//					addChild(Component.Control);
//				}
//			}
//		}
	}
}