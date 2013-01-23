package editor.ui
{
	import editor.code.ClassFactory;
	import editor.code.ComponentClass;
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
	import pixel.ui.control.SimpleTabPanel;
	import pixel.ui.control.Tab;
	import pixel.ui.control.TabBar;
	import pixel.ui.control.TabContent;
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
		//private var CurrentActived:Sprite = null;
		private var _Children:Vector.<IUIControl> = new Vector.<IUIControl>();
		//新创建组件的基本信息
		private var _ComponentProfile:ComponentProfile = null;
		//private var _Container:Container = null;
		//private var _ContainerControl:UIControl = null;
		
		//是否复合组件
		//private var IsComplex:Boolean = false;
		
		//private var _ConstructTree:Array = [];
		
		//private var _ContainerNode:TreeNode = null;
		
		//当前选择的控件
		private var _FocusControl:UIControl = null;
		
		//private var _NodeMap:Dictionary = new Dictionary();
		//		public function Workspace(Profile:ComponentProfile = null)
		//		{
		////			if(Profile)
		////			{
		////				BuildWorkspace(Profile);
		////			}
		//			
		//			//this.addEventListener(ControlEditModeEvent.CHILDSELECTED,OnControlChildSelect);
		//			
		//		}
		
		public function WorkspacePlus()
		{
			//			if(Profile)
			//			{
			//				BuildWorkspace(Profile);
			//			}
			
			//this.addEventListener(ControlEditModeEvent.CHILDSELECTED,OnControlChildSelect);
			addEventListener(MouseEvent.MOUSE_DOWN,DragStart);
			addEventListener(UIControlEvent.EDIT_LOADRES_OUTSIDE,function(event:UIControlEvent):void{
				
			});
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
		
		//		public function BuildWorkspace(Profile:ComponentProfile):void
		//		{
		//			if(Profile)
		//			{
		//				_ComponentProfile = Profile;
		//				if(_ComponentProfile.Category == 1)
		//				{
		//					IsComplex = true;
		//					//复合组件
		//					switch(_ComponentProfile.Container)
		//					{
		//						case 0:
		//							_Container = addChild(new UIPanel()) as Container;
		//							_Container.width = 500;
		//							_Container.height = 500;
		//							break;
		//					}
		//					
		//					_Container.addEventListener(MouseEvent.MOUSE_DOWN,function(event:MouseEvent):void{
		//						OnComponentChoice(event.target);
		//
		//					});
		//				}
		//				else
		//				{
		//					var Prototype:Class = Utils.GetPrototypeByType(_ComponentProfile.Component);
		//					var Control:UIControl = new Prototype() as UIControl;
		//					Control.width = 200;
		//					Control.height = 80;
		//					if(Prototype)
		//					{
		//						if(Control is SimpleTabPanel)
		//						{
		//							SimpleTabPanel(Control).CreateTab();
		//						}
		//					}
		//					addChild(Control);
		//					var ChoiceNotify:NotifyEvent = new NotifyEvent(NotifyEvent.COMPONENT_SELECTED);
		//					ChoiceNotify.Params.push(Control);
		//					dispatchEvent(ChoiceNotify);
		//					Control.FrameFocus();
		//				}
		//			}
		//		}
		
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
				if(_FocusControl is Tab)
				{
					_FocusControl = Tab(_FocusControl).parent.parent as UIControl;
				}
				else if(_FocusControl is TabBar)
				{
					_FocusControl = TabBar(_FocusControl).Owner;
				}
				else if(_FocusControl is TabContent)
				{
					_FocusControl = TabContent(_FocusControl).Owner;
				}
				
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
		
		//		public function get Component():UIControl
		//		{
		//			if(IsComplex)
		//			{
		//				return _Container as UIControl;
		//			}
		//			else
		//			{
		//				return _Children[0] as UIControl;
		//			}
		//		}
		//		
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
		
		
		
		/**
		 * 自定义组件添加
		 **/
		//		public function AddComponent(child:ComponentModel):void
		//		{
		//			
		//			ComponentModel(child).Control.EnableEditMode();
		//			
		//			addChild(child.Control);
		//		}
		
		
		//		override public function addChild(child:DisplayObject):DisplayObject
		//		{
		//			UIControl(child).EnableEditMode();
		//			if(_Container)
		//			{
		//				var Drag:Boolean = IsComplex && _ComponentProfile.Container == 0 ? true:false;
		//				child = _Container.addChild(child);
		//			}
		//			else
		//			{
		//				child = super.addChild(child);
		//				_Children.push(child);
		//			}
		//			return child;
		//		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			_Children.push(child);
			return super.addChild(child);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			if(_Children.indexOf(child) >= 0)
			{
				_Children.splice(_Children.indexOf(child),1);
			}
			return super.removeChild(child);
		}
		
		private var OffsetX:int = 0;
		private var OffsetY:int = 0;
		private var DragTarget:DisplayObject = null;
		
		private function DragStart(event:MouseEvent):void
		{
			OnComponentChoice(event.target);
			
			if(_Children.indexOf(event.target) >= 0 )
			{
				DragTarget = event.target as DisplayObject;
				var Offset:Point = new Point(event.stageX,event.stageY);
				Offset = DragTarget.globalToLocal(Offset);
				OffsetX = Offset.x;
				OffsetY = Offset.y;
				stage.addEventListener(MouseEvent.MOUSE_MOVE,DragMove);
				stage.addEventListener(MouseEvent.MOUSE_UP,DragEnd);
			}
		}
		
		public function DeleteCurrentShell():void
		{
			if(_FocusControl)
			{
				if(_Children.indexOf(_FocusControl) >= 0)
				{
					removeChild(_FocusControl);
					_FocusControl = null;
				}
				else
				{
					_FocusControl.Owner.removeChild(_FocusControl);
					_FocusControl = null;
				}
			}
		}
		
		
		private var TransPoint:Point = new Point();
		private var PosX:int = 0;
		private var PosY:int = 0;
		private function DragMove(Event:MouseEvent):void
		{
			TransPoint.x = Event.stageX;
			TransPoint.y = Event.stageY;
			TransPoint = globalToLocal(TransPoint);
			PosX = TransPoint.x - OffsetX;
			PosY = TransPoint.y - OffsetY;
			if(PosX + DragTarget.width > (width))
			{
				PosX = width - DragTarget.width;
			}
			if(PosY + DragTarget.height > height)
			{
				PosY = height - DragTarget.height;
			}
			if(PosX < 0)
			{
				PosX = 0;
			}
			if(PosY < 0)
			{
				PosY = 0;
			}
			DragTarget.x = PosX;
			DragTarget.y = PosY;;
		}
		
		private function DragEnd(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,DragMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP,DragEnd);
			DragTarget = null;
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
			InlineStyle.clear();
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