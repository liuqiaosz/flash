package components
{
	import flare.core.*;
	import flare.modifiers.*;
	import flash.display3D.*;
	import flash.events.*;
	import flash.geom.*;
	
	/**
	 * Sample component.
	 * Draw skinned bones as lines.
	 * 
	 * @author Ariel Nehmad.
	 */
	public class DrawBones implements IComponent
	{
		private var _target:Pivot3D;
		private var _mesh:Mesh3D;
		private var _skin:Vector.<SkinModifier>;
		private var _lines:Lines3D;
		private var _matrix:Matrix3D;
		private var _thickness:Number;
		private var _color:uint;
		
		public function DrawBones( color:uint = 0xff0000, thickness:Number = 1 )
		{
			_color = color;
			_thickness = thickness;
		}
		
		/* INTERFACE flare.components.IComponent */
		
		public function added( target:Pivot3D ):Boolean
		{
			_target = target;
			
			// find down for the skinned mesh.
			target.forEach( findSkin, Mesh3D );
			
			if ( _skin ) 
			{
				// initialize.
				_mesh.addEventListener( Pivot3D.EXIT_DRAW_EVENT, exitDrawEvent, false, 0, true );
				_matrix = new Matrix3D();
				_lines = new Lines3D();
				_lines.upload( _mesh.scene );
				
				// succesfully added.
				return true;
			}
			else 
				throw "No skinned meshes found in " + target.name;
			
			return false;
		}
		
		public function removed():Boolean
		{
			// free resources.
			_mesh.removeEventListener( Pivot3D.EXIT_DRAW_EVENT, exitDrawEvent );
			_mesh = null;
			_skin = null;
			_lines = null;
			_matrix = null;
			_target = null;
			
			// succesfully removed.
			return true;
		}
		
		/* PRIVATE METHODS. */
		
		private function exitDrawEvent(e:Event):void 
		{
			// setup line style.
			_lines.clear();
			_lines.lineStyle( _thickness, _color );
			
			// create lines.
			for each ( var s:SkinModifier in _skin )
				for each ( var b:Pivot3D in s.bones ) drawBone( s.mesh, b );
			
			// draw lines to screen. 
			// we draw the lines manually because our lines object it is not added to the mesh or scene hierarchy...it could.
			_mesh.scene.context.setDepthTest( false, Context3DCompareMode.ALWAYS );
			_lines.draw();
			_mesh.scene.context.setDepthTest( true, Context3DCompareMode.LESS_EQUAL );
		}
		
		private function drawBone( mesh:Mesh3D, bone:Pivot3D ):void
		{
			if ( bone.children.length == 0 || bone.parent == null ) return;
			
			// get the bone matrix transform. ( bone transform + mesh transform )
			_matrix.copyFrom( bone.global ); 
			_matrix.append( mesh.global );
			
			// result bone position.
			var from:Vector3D = _matrix.position;
			
			for each ( var child:Pivot3D in bone.children )
			{
				_lines.moveTo( from.x, from.y, from.z );
				
				// get the child bone matrix transform. ( bone transform + mesh transform )
				_matrix.copyFrom( child.global ); 
				_matrix.append( mesh.global );
				
				// result bone children position.
				var to:Vector3D = _matrix.position;
				
				// draw bone line.
				_lines.lineTo( to.x, to.y, to.z );
			}
		}
		
		/**
		 * Find a skinned mesh recursively down in the hierarchy.
		 */
		private function findSkin( mesh:Mesh3D ):void
		{
			if ( mesh.modifier is SkinModifier )
			{
				if ( !_skin ) _skin = new Vector.<SkinModifier>();
				
				_mesh = mesh;
				
				_skin.push( mesh.modifier );
			}
		}
	}
}