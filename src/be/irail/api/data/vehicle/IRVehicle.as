package be.irail.api.data.vehicle {

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

		private var _longitude:Number;

		/**
		 * vehicle position: longitude
		 */
		public function get longitude():Number {
			return _longitude;
		}

		public function set longitude(value:Number):void {
			if (value != _longitude) {
				_longitude = value;
			}
		}


		private var _latitude:Number;

		/**
		 * vehicle position: latitude
		 */
		public function get latitude():Number {
			return _latitude;
		}

		public function set latitude(value:Number):void {
			if (value !== _latitude) {
				_latitude = value;
			}
		}


		public function IRVehicle(vehicleCode:String = "") {
			this.vehicleCode = vehicleCode;
		}
	}
}