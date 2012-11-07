package mapassistant.map.world
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import game.sdk.map.layer.GenericLayer;
	import game.sdk.map.layer.LayerMode;
	import game.sdk.map.tile.TileData;
	import game.sdk.map.tile.TileMode;
	
	import mapassistant.data.table.TableSymbol;
	import mapassistant.event.EventConstant;
	import mapassistant.event.NotifyEvent;
	import mapassistant.resource.ResourceItem;
	import mapassistant.symbol.GenericSymbol;
	import mapassistant.ui.SymbolTile;
	
	import utility.ColorCode;

	public class TileWorld extends Tile2DWorld
	{
		
		public function TileWorld(Row:int = 0,Column:int = 0,Size:int = 0)
		{
			super(Row,Column,Size);
			this.addEventListener(MouseEvent.MOUSE_MOVE,OnMouseMove);
			//设置数据层渲染可行走Tile的颜色为绿色
			//this.DataGridLayer.WalkFillColor = ColorCode.GREEN;
		}
		
		private var CreatorPoint:Sprite = null;
		private var _RoleCreator:TileData = null;
		
		protected function OnMouseMove(event:MouseEvent):void
		{
			//var _Layer:Tile2DWorldLayer = this.GetTopLayer() as Tile2DWorldLayer;
			var _Layer:TileLayer = null;
			if(NORMAL == _EditMode)
			{
				return;
			}
			switch(_EditMode)
			{
				case EDIT_WALK:
					_Layer = this.DataGridLayer as TileLayer;
				case EDIT_CREATOR:
					_Layer = this.DataGridLayer as TileLayer;
					break;
				case EDIT_SYMBOL:
					_Layer = this.TerrainLayer as TileLayer;
				
					break;
			}
			
			if(_Layer)
			{
				var GridSize:int = _Layer.GridTileWidth;
				var Pos:Point = this.globalToLocal(new Point(event.stageX,event.stageY));
				AtColumn = Pos.x / _Layer.GridTileWidth;
				//Col--;
				AtRow = Pos.y / _Layer.GridTileWidth;
				//Row--;
				if(AtColumn < 0)
				{
					AtColumn = 0;
				}
				if(AtRow < 0)
				{
					AtRow = 0;
				}
				var Color:uint = 0;
				switch(_EditMode)
				{
					case EDIT_WALK:
						_Layer = this.DataGridLayer as TileLayer;
						Color = ColorCode.GREEN;
						if(!WalkFocusPoint)
						{
							WalkFocusPoint = new Sprite();
							_OperateLayer.addChild(WalkFocusPoint);
							WalkFocusPoint.graphics.beginFill(Color,1);
							WalkFocusPoint.graphics.drawRect(0,0,GridSize,GridSize);
							WalkFocusPoint.graphics.endFill();
						}
						WalkFocusPoint.x = AtColumn * GridSize;
						WalkFocusPoint.y = AtRow * GridSize;
						
//						if(_EditWalkRoll && !_DataGridLayer.Grid[AtRow][AtColumn].State == TileMode.TILE_STATE_LOCK)
//						{
//							DataGridLayer.ChangeTileState(AtRow,AtColumn,TileMode.TILE_STATE_FREE);
//							
//						}
						if(_EditWalkRoll)
						{
							_Layer.ChangeTileState(AtRow,AtColumn,TileMode.TILE_STATE_FREE);
						}
						break;
					case EDIT_CREATOR:
						_Layer = this.DataGridLayer  as TileLayer;
						Color = ColorCode.PINK;
						
						if(CreatorPoint == null)
						{
							CreatorPoint = new Sprite();
							_OperateLayer.addChild(CreatorPoint);
							CreatorPoint.graphics.beginFill(Color,1);
							CreatorPoint.graphics.drawRect(0,0,GridSize,GridSize);
							CreatorPoint.graphics.endFill();
						}
						CreatorPoint.x = AtColumn * GridSize;
						CreatorPoint.y = AtRow * GridSize;
						break;
					case EDIT_SYMBOL:
						_Layer = this.TerrainLayer  as TileLayer;
						var Lock:Boolean = false;
						if(_SymbolTile)
						{
							var GridState:Vector.<Vector.<TileData>> = _Layer.Grid;
							for(var C:int=0; C<SymbolWidth; C++)
							{
								for(var R:int=0; R<SymbolHeight; R++)
								{
									if(AtColumn + C < GridState.length && AtRow + R < GridState[0].length)
									{
										if(GridState[AtColumn + C][AtRow + R].Lock)
										{
											Lock = true;
											break;
										}
									}
								}
							}
							
							_SymbolTile.x = AtColumn * GridSize;
							_SymbolTile.y = AtRow * GridSize;
							AcceptDrop = !Lock;
							if(!AcceptDrop)
							{
								Color = ColorCode.RED;
							}
							_SymbolTile.graphics.clear();
							_SymbolTile.graphics.beginFill(Color,0.5);
							_SymbolTile.graphics.drawRect(0,0,SymbolWidth * GridSize,SymbolHeight * GridSize);
							_SymbolTile.graphics.endFill();
						}
						break;
				}
			}
			
			
			if(_Layer)
			{
				
				
//				if(_EditWalkRoll)
//				{
//					DataGridLayer.SetWalkPoint(AtColumn,AtRow);
//				}
//				var Lock:Boolean = false;
//				if(_SymbolTile)
//				{
//					var GridState:Vector.<Vector.<TileData>> = _Layer.Grid;
//					for(var C:int=0; C<SymbolWidth; C++)
//					{
//						for(var R:int=0; R<SymbolHeight; R++)
//						{
//							if(AtColumn + C < GridState.length && AtRow + R < GridState[0].length)
//							{
//								if(GridState[AtColumn + C][AtRow + R].Lock)
//								{
//									Lock = true;
//									break;
//								}
//							}
//						}
//					}
//					
//					_SymbolTile.x = AtColumn * GridSize;
//					_SymbolTile.y = AtRow * GridSize;
//					AcceptDrop = !Lock;
//					if(!AcceptDrop)
//					{
//						Color = ColorCode.RED;
//					}
//					_SymbolTile.graphics.clear();
//					_SymbolTile.graphics.beginFill(Color,0.5);
//					_SymbolTile.graphics.drawRect(0,0,SymbolWidth * GridSize,SymbolHeight * GridSize);
//					_SymbolTile.graphics.endFill();
//				}
//				
//				var Color:uint = ColorCode.GREEN;
//				if(WalkPointEditEnable)
//				{
//					if(!WalkFocusPoint)
//					{
//						WalkFocusPoint = new Sprite();
//						_OperateLayer.addChild(WalkFocusPoint);
//						WalkFocusPoint.graphics.beginFill(Color,1);
//						WalkFocusPoint.graphics.drawRect(0,0,GridSize,GridSize);
//						WalkFocusPoint.graphics.endFill();
//					}
//					WalkFocusPoint.x = AtColumn * GridSize;
//					WalkFocusPoint.y = AtRow * GridSize;
//					
//					if(_EditWalkRoll && !_DataGridLayer.Grid[AtColumn][AtRow].Walk)
//					{
//						DataGridLayer.SetWalkPoint(AtColumn,AtRow);
//						
//					}
//					//WalkFocusPoint.graphics.clear();
////					if(Lock)
////					{
////						Color = ColorCode.RED;
////					}
////					WalkFocusPoint.graphics.beginFill(Color,1);
////					WalkFocusPoint.graphics.drawRect(0,0,GridSize,GridSize);
////					WalkFocusPoint.graphics.endFill();
//					
//				}
//				if(_SymbolTile)
//				{
//					
//					
//					//				for(var C:int=0; C<SymbolWidth; C++)
//					//				{
//					//					for(var R:int=0; R<SymbolHeight; R++)
//					//					{
//					//						if(GridState[AtColumn + C][AtRow + R])
//					//						{
//					//							Symbol.graphics.clear();
//					//							Symbol.graphics.beginFill(ColorCode.RED,0.5);
//					//							Symbol.graphics.drawRect(0,0,SymbolWidth * GridSize,SymbolHeight * GridSize);
//					//							Symbol.graphics.endFill();
//					//							AcceptDrop = false;
//					//							return;
//					//						}
//					//					}
//					//				}
//					//				AcceptDrop = true;
//				}
			}
		}
		
		public function ChangeMode(Value:uint):void
		{
			this.ResetOperate();
			if(_SymbolTile)
			{
				_SymbolTile = null;
			}
			if(WalkPointEditEnable)
			{
				this.DisableWalkPointEditMode();
			}
			_EditMode = Value;
		}
		
		private var _SymbolTile:SymbolTile = null;
		//当前元件占用列数
		private var SymbolWidth:int = 0;
		//当前元件占用行数
		private var SymbolHeight:int = 0;
		//是否允许放置
		private var AcceptDrop:Boolean = true;
		
		private var AtRow:int = 0;
		private var AtColumn:int = 0;
		/**
		 * 更新元件信息
		 * 
		 **/
		override public function UpdateSymbolSprite(Symbol:GenericSymbol,Resource:ResourceItem):void
		{
			this.ResetOperate();
			
			var _Layer:TileLayer = this.GetTopLayer() as TileLayer;
			if(_Layer)
			{
				if(_SymbolTile)
				{
					_OperateLayer.removeChild(_SymbolTile);
					_SymbolTile = null;
				}
				if(WalkPointEditEnable)
				{
					this.DisableWalkPointEditMode();
				}
				var GridSize:int = _Layer.GridTileWidth;
				_SymbolTile = new SymbolTile(Symbol,Resource);
				_SymbolTile.alpha = 0.4;
				_OperateLayer.addChild(_SymbolTile);
				addEventListener(MouseEvent.CLICK,AddSymbol);
				
				if(_SymbolTile.width > this.GridSize || _SymbolTile.height > GridSize)
				{
					SymbolWidth = _SymbolTile.width / GridSize;
					SymbolWidth += (_SymbolTile.width % GridSize > 0 ? 1:0);
					SymbolHeight = _SymbolTile.height / GridSize;
					SymbolHeight += (_SymbolTile.height % GridSize > 0 ? 1:0);
					//Symbol.graphics.clear();
					//Symbol.graphics.beginFill(0x00FFFF,0.5);
					//Symbol.graphics.drawRect(0,0,Col * GridSize,Row * GridSize);
				}
				this._EditMode = EDIT_SYMBOL;
			}
			
		}
		
		protected function AddSymbol(event:MouseEvent):void
		{
			if(AcceptDrop)
			{
				var TopLayer:TileLayer = this.GetTopLayer() as TileLayer;
				if(TopLayer)
				{
					//TopLayer.addChild(_SymbolTile);
				}
				var AnchorTile:TileData = TopLayer.Grid[AtColumn][AtRow];
				AnchorTile.ResourceId = _SymbolTile.Symbol.Swf;
				AnchorTile.ResourceClass = _SymbolTile.Symbol.Class;
				AnchorTile.Resource = _SymbolTile.Img.bitmapData;
				removeEventListener(MouseEvent.CLICK,AddSymbol);
				_OperateLayer.removeChild(_SymbolTile);
				_SymbolTile = null;
				AcceptDrop = false;
				var GridState:Vector.<Vector.<TileData>> = TopLayer.Grid;
				for(var C:int=0; C<SymbolWidth; C++)
				{
					for(var R:int=0; R<SymbolHeight; R++)
					{
						GridState[AtColumn + C][AtRow + R].Lock = true;
					}
				}
				
				TopLayer.Render();
			}
		}
		
		/**
		 * 开启角色生成点编辑模式
		 **/
		public function RoleCreatorEditEnabled():void
		{
			this.ResetOperate();
			this._EditMode = EDIT_CREATOR;
			this.addEventListener(MouseEvent.CLICK,ChangeRoleCreatorPoint);
		}
		public function RoleCreatorEditDisabled():void
		{
			this.ResetOperate();
			this.removeEventListener(MouseEvent.CLICK,ChangeRoleCreatorPoint);
		}
		
		private var WalkFocusPoint:Sprite = null;
		private var WalkPointEditEnable:Boolean = false;
		/**
		 * 开启路点编辑模式
		 **/
		public function EnableWalkPointEditMode():void
		{
			this.ResetOperate();
			
			WalkPointEditEnable = true;
			
			//this._ItemLock = true;
			//this._TerrainLock = true;
			addEventListener(MouseEvent.MOUSE_DOWN,EditWalkPoint);
			addEventListener(MouseEvent.MOUSE_UP,DisableWalkRollEdit);
			this._EditMode = EDIT_WALK;
		}
		
		private var _EditWalkRoll:Boolean = false;
		
		/**
		 * 关闭路点编辑模式
		 **/
		public function DisableWalkPointEditMode():void
		{
			this.ResetOperate();
//			removeEventListener(MouseEvent.MOUSE_DOWN,EditWalkPoint);
//			removeEventListener(MouseEvent.MOUSE_UP,DisableWalkRollEdit);
//			//this.removeChild(WalkFocusPoint);
//			WalkPointEditEnable = false;
//			//this.ResetOperate();
//			//this._ItemLock = false;
//			//this._TerrainLock = false;
//			WalkFocusPoint = null;
//			this._EditMode = TileWorld.NORMAL;
		}
		
		private function DisableWalkRollEdit(event:MouseEvent):void
		{
			_EditWalkRoll = false;
			//DataGridLayer.SetWalkPoint(AtColumn,AtRow);
		}
		
		override public function ResetOperate():void
		{
			super.ResetOperate();
			if(_SymbolTile)
			{
				//_OperateLayer.removeChild(_SymbolTile);
				removeEventListener(MouseEvent.CLICK,AddSymbol);
				_SymbolTile = null;
				AcceptDrop = false;
			}
			if(WalkPointEditEnable)
			{
				addEventListener(MouseEvent.MOUSE_DOWN,EditWalkPoint);
				addEventListener(MouseEvent.MOUSE_UP,DisableWalkRollEdit);
				WalkPointEditEnable = false;
				WalkFocusPoint = null;
			}
			this._EditMode = NORMAL;
		}
		
		/**
		 * 设定当前路点格为可行走状态
		 **/
		private function EditWalkPoint(event:MouseEvent):void
		{
			_EditWalkRoll = true;
			//var Local:Point = this.globalToLocal(new Point(event.stageX,event.stageY));
			
			TileLayer(DataGridLayer).ChangeTileState(AtRow,AtColumn,TileMode.TILE_STATE_FREE);
			
			//DataGridLayer.Grid[AtColumn][AtRow].Walk = !this.DataGridLayer.Grid[AtColumn][AtRow].Walk;
			//DataGridLayer.Update();
			//DataGridLayer.GridLineSwitch();
		}
		
		private var OldCreator:TileData = null;
		private function ChangeRoleCreatorPoint(event:MouseEvent):void
		{
			if(null != OldCreator)
			{
				OldCreator.Mode = TileMode.TILE_EMPTY;
				//DataGridLayer.ChangeTileMode(OldCreator.Row,OldCreator.Column,TileMode.TILE_EMPTY);
			}
			OldCreator = TileLayer(DataGridLayer).ChangeTileMode(AtRow,AtColumn,TileMode.TILE_ROLECREATOR);
			DataGridLayer.Update();
		}
		
//		override public function WorldToMapFile():ByteArray
//		{
//			//速出DataGrid层数据
//			return null;
//		}
	}
}