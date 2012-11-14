package pixel.core
{
	import flash.events.IEventDispatcher;
	
	import pixel.scene.IPixelScene;
	
	import spark.core.IDisplayText;

	/**
	 * 
	 * 主控接口
	 * 
	 * 比如实现该接口来实现自定义逻辑部分，核心模块接受该模块的逻辑调度
	 * 
	 **/
	public interface IPixelDirector extends IEventDispatcher
	{
		//开始
		function action():void;
		//更新状态
		function update():void;
		//暂停
		function pause():void;
		//结束
		function end():void;
		
		function switchScene(prototype:Class,transition:int = -1,duration:Number = 1):IPixelScene;
	}
}