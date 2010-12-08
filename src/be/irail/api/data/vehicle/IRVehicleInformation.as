package be.irail.api.data.vehicle {
	
	/**
	 * Vehicle Information
	 * RemoteClass alias: irail.IRVehicleInformation
	 * @author Joris Timmerman
	 */
	[RemoteClass(alias="irail.IRVehicleInformation")]
	public class IRVehicleInformation {
		// ----------------------------
		// vehicle
		// ----------------------------

		private var _vehicle:IRVehicle;

		public function get vehicle():IRVehicle {
			return _vehicle;
		}

		public function set vehicle(value:IRVehicle):void {
			if (value != _vehicle) {
				_vehicle = value;
			}
		}

		// ----------------------------
		// stops
		// ----------------------------

		private var _stops:Array;

		public function get stops():Array {
			return _stops;
		}

		public function set stops(value:Array):void {
			if (value != _stops) {
				_stops = value;
			}
		}
	}
}