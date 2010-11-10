package be.irail.api.data.scheduler {

	public class IRVehicle {
		// ----------------------------
		// typeOfTransport
		// ----------------------------

		private var _typeOfTransport:String;

		/**
		 * Type of transport.
		 */
		public function get typeOfTransport():String {
			return _typeOfTransport;
		}

		public function set typeOfTransport(value:String):void {
			if (value != _typeOfTransport) {
				_typeOfTransport = value;
			}
		}

		// ----------------------------
		// vehicleCode
		// ----------------------------

		private var _vehicleCode:String;

		/**
		 * Specific vehicle code
		 * For example, Belgian NMBS P-Train 1234: Be.NMBS.P1234
		 */
		public function get vehicleCode():String {
			return _vehicleCode;
		}

		public function set vehicleCode(value:String):void {
			if (value != _vehicleCode) {
				_vehicleCode = value;
			}
		}

		public function IRVehicle(vehicleCode:String = "") {
			this.vehicleCode = vehicleCode;
		}
	}
}