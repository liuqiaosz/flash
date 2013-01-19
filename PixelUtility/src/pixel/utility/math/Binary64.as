package pixel.utility.math
{
	public class Binary64 {
		public var low:uint;
		/**
		 * @private
		 */
		internal var internalHigh:uint;
		public function Binary64(low:uint = 0, high:uint = 0) {
			this.low = low
			this.internalHigh = high
		}
		/**
		 * Division by n.
		 * @return The remainder after division.
		 */
		internal final function div(n:uint):uint {
			const modHigh:uint = internalHigh % n
			const mod:uint = (low % n + modHigh * 6) % n
			internalHigh /= n
			const newLow:Number = (modHigh * Number(0x100000000) + low) / n
			internalHigh += newLow / 0x100000000
			low = newLow
			return mod
		}
		internal final function mul(n:uint):void {
			const newLow:Number = Number(low) * n
			internalHigh = newLow / 0x100000000 + Number(internalHigh) * n
			low = newLow
		}
		internal final function add(n:uint):void {
			const newLow:Number = Number(low) + n
			internalHigh = newLow / 0x100000000 + internalHigh
			low = newLow
		}
		internal final function bitwiseNot():void {
			low = ~low
				internalHigh = ~internalHigh
		}
	}
}