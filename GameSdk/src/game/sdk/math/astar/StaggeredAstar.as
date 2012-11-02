package game.sdk.math.astar
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.sensors.Accelerometer;
	import flash.utils.getTimer;
	
	import game.sdk.map.tile.TileData;
	import game.sdk.net.event.NetEvent;
	
	import utility.IDispose;
	
	public class StaggeredAstar implements IDispose
	{
		private const COST_HORIZONTAL : int = 20;
		private const COST_VERTICAL : int = 5;
		private const COST_DIAGONAL : int = 12;
		private var Open:Array = new Array();
		private var Close:Array = new Array();
		
		private var DataGrid:Vector.<Vector.<TileData>> = null;
		
		private var CurrentNode:AstarNode = null;
		private var EndNode:AstarNode = null;
		private var StartNode:AstarNode = null;
		public function StaggeredAstar(DataGrid:Vector.<Vector.<TileData>>)
		{
			this.DataGrid = DataGrid;
		}
		
		public function Search(StartTile:TileData, EndTile:TileData):Vector.<TileData>
		{
			Open = [];
			Close = [];
			var Path:Vector.<TileData> = new Vector.<TileData>();
			EndNode = EndTile.Node;
			StartNode = StartTile.Node;
			CurrentNode = StartNode;
			Open.push(CurrentNode);
			while(Open.length > 0)
			{
				CurrentNode = Open.shift();
				if(CurrentNode == EndNode)
				{
					while (CurrentNode != StartNode) 
					{
						Path.push(DataGrid[CurrentNode.pr][CurrentNode.pc]);
						CurrentNode = CurrentNode.parent;
					}
					break;
				}
				Close.push(CurrentNode);
				FindBestNode(CurrentNode.pr,CurrentNode.pc);
			}
			return Path;
		}
		
		private function FindBestNode(Row:uint,Column:uint):void
		{
			//左
			GetRoundNode(Row,Column - 1);
			//右
			GetRoundNode(Row,Column + 1);
			//上
			GetRoundNode(Row - 2,Column);
			//下
			GetRoundNode(Row + 2,Column);
			//左上
			GetRoundNode(Row - 1,(Column - 1 + (Row&1)));
			//左下
			GetRoundNode(Row + 1,(Column - 1 + (Row&1)));
			//右上
			GetRoundNode(Row - 1,(Column + (Row&1)));
			//右下
			GetRoundNode(Row + 1,(Column + (Row&1)));
			Open.sortOn("F",Array.NUMERIC);
		}
		
		private function GetRoundNode(Row:uint,Column:uint):AstarNode
		{
			var Node:AstarNode = FindNodeByPos(Row,Column);
			
			if((Node && Node.walk))
			{
				if(Open.indexOf(Node) < 0)
				{
					var G:uint = this.GetG(Node);
					var H:uint = this.GetH(Node);
					Node.G = G;
					Node.H = H;
					Node.F = Node.G + Node.H;	
					Node.parent = CurrentNode;
					Open.push(Node);
					return Node;
				}
			}
			return null;
		}
		
		private function FindNodeByPos(Row:uint,Col:uint):AstarNode
		{
			if(Row >= DataGrid.length || Row < 0 || Col >= DataGrid[0].length || Col < 0)
			{
				return null;
			}
			var Node:AstarNode = DataGrid[Row][Col].Node;
			if(Close.indexOf(Node) >= 0)
			{
				return null;
			}
			return Node;
		}

		/**
		 * 计算G值
		 */
		private function GetG(Node:AstarNode):uint
		{
			var G:uint = 0;
			if(Node.pr == CurrentNode.pr)
			{
				G = CurrentNode.G + COST_HORIZONTAL;
			}
			else if(CurrentNode.pr + 2 == Node.pr || CurrentNode.pr - 2 == Node.pr)
			{
				G = CurrentNode.G + this.COST_VERTICAL * 2;
			}
			else
			{
				G = CurrentNode.G + this.COST_DIAGONAL;
			}
			
			return G;
		}
		
		/**
		 * 计算H值
		 */
		private function GetH(Node:AstarNode):uint
		{
			var Dx:uint = 0;
			var Dy:uint = 0;
			//节点到0，0点的x轴距离
			var dxNodeTo0:uint = Node.pc * this.COST_HORIZONTAL + (Node.pr&1) * this.COST_HORIZONTAL/2;
			//终止节点到0，0点的x轴距离
			var dxEndNodeTo0:uint = EndNode.pc * this.COST_HORIZONTAL + (EndNode.pr&1) * this.COST_HORIZONTAL/2; 
			Dx = Math.abs(dxEndNodeTo0 - dxNodeTo0);
			Dy = Math.abs(EndNode.pr - Node.pr) * this.COST_VERTICAL;
			return Dx + Dy;
		}
		
//		private function FindTile(Row:uint,Column:uint):TileData
//		{
//			if(Row >= 0 && Row < DataGrid.length && Column >=0 && Column < DataGrid[0].length)
//			{
//				return DataGrid[Row][Column];
//			}
//			return null;
//		}
		
		public function Dispose():void
		{
			Open = null;
			Close = null;
			DataGrid = null;
			CurrentNode = null;
			EndNode = null;
			StartNode = null;
		}
		
	}
}
