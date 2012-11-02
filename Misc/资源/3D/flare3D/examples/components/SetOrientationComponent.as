package components 
{
	import flare.core.*;
	import flash.events.*;
	
	/**
	 * ...
	 * @author Ariel Nehmad
	 */
	public class SetOrientationComponent implements IComponent 
	{
		private var _oritnetaion:Pivot3D;
		private var _target:Pivot3D;
		
		public function SetOrientationComponent( orientation:Pivot3D ) 
		{
			_oritnetaion = orientation;
		}
		
		/* INTERFACE flare.components.IComponent */
		
		public function added(target:Pivot3D):Boolean 
		{
			_target = target;
			
			target.addEventListener( Pivot3D.ENTER_FRAME_EVENT, enterFrameEvent );
			
			return true;
		}
		
		public function removed():Boolean 
		{
			_target.removeEventListener( Pivot3D.ENTER_FRAME_EVENT, enterFrameEvent );
			
			return true;
		}
		
		private function enterFrameEvent(e:Event):void 
		{
			_target.setOrientation( _oritnetaion.getDir(), _oritnetaion.getUp(), 0.6 );
		}
	}
}