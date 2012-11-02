package game.sdk.math.astar
{
	import game.sdk.map.layer.LayerMode;
	import game.sdk.map.tile.TileData;
	import game.sdk.math.astar.AstarNode;

	public class Astar
	{
		private var Open:Array = null;
		private var Close:Array = null;
		private var DataGrid:Vector.<Vector.<TileData>> = null;
		private var StartNode:AstarNode = null;
		private var TargetNode:AstarNode = null;
		private var CurrentNode:AstarNode = null;
		public function Astar(Grid:Vector.<Vector.<TileData>>,Mode:uint = LayerMode.LAYER_2D)
		{
			DataGrid = Grid;
		}
		
		public function Search(StartColumn:uint,StartRow:uint,EndColumn:uint,EndRow:uint):Array
		{
			var Result:Array = [];
			Open = [];
			Close = [];
			StartNode = DataGrid[StartRow][StartColumn].Node;
			TargetNode = DataGrid[EndRow][EndColumn].Node;
			
			if(StartNode != TargetNode && TargetNode.walk)
			{
				Open.push(StartNode);
				while(Open.length > 0)
				{
					CurrentNode = Open.shift();
					if(CurrentNode == TargetNode)
					{
						while (CurrentNode.parent != StartNode.parent) 
						{
							Result.push(CurrentNode);
							CurrentNode = CurrentNode.parent;
						}
						break;
					}
					
					Close.push(CurrentNode);
					FindBestNode();
				}
			}
			return Result;	
		}
		private var lineG:int = 10;
		private var corG:int = 14;
		private function FindBestNode():void
		{
			var node:AstarNode = getRoundNode(CurrentNode.pr,CurrentNode.pc - 1,lineG);
			node = getRoundNode(CurrentNode.pr,CurrentNode.pc + 1,lineG);
			node = getRoundNode(CurrentNode.pr - 1,CurrentNode.pc,lineG);
			node = getRoundNode(CurrentNode.pr + 1,CurrentNode.pc,lineG);
			
			node = getRoundNode(CurrentNode.pr - 1,CurrentNode.pc - 1,corG);
			node = getRoundNode(CurrentNode.pr - 1,CurrentNode.pc + 1,corG);
			node = getRoundNode(CurrentNode.pr + 1,CurrentNode.pc + 1,corG);
			node = getRoundNode(CurrentNode.pr + 1,CurrentNode.pc - 1,corG);
			Open.sortOn("F",Array.NUMERIC);
		}
		
		private function getRoundNode(row:int,col:int,g:int):AstarNode
		{
			var node:AstarNode = findNodeByPos(row,col);
			if(node && node.walk)
			{
				if(Open.indexOf(node) < 0)
				{
					var mg:int = CurrentNode.G + g;
					node.G = mg < node.G? mg + g:mg;
					node.H = (Math.abs((node.pc * TargetNode.width - TargetNode.pc * TargetNode.width)) + (Math.abs((node.pr * TargetNode.height - TargetNode.pr * TargetNode.height))));
					node.F = node.G + node.H;	
					node.parent = CurrentNode;
					Open.push(node);
					return node;
				}
			}
			return null;
		}
		
		private function findNodeByPos(row:int,col:int):AstarNode
		{
			if(col >= DataGrid.length || col < 0 || row >= DataGrid[0].length || row < 0)
			{
				return null;
			}
			var node:AstarNode = DataGrid[row][col].Node;
			if(Close.indexOf(node) >= 0)
			{
				return null;
			}
			return node;
		}
		
		private function FindRound():void
		{
			
		}
	}
}