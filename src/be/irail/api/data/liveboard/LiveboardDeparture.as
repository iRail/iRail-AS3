package be.irail.api.data.liveboard {
	import be.irail.api.data.vehicle.IRVehicle;
	import be.irail.api.data.stations.IRStation;
	import be.irail.api.data.stations.IRStationPlatform;

	public class LiveboardDeparture {
		// ----------------------------
		// id
		// ----------------------------

		private var _id:int;

		/**
		 * Departure id (in list)
		 */
		public function get id():int {
			return _id;
		}

		public function set id(value:int):void {
			if (value !== _id) {
				_id = value;
			}
		}

		// ----------------------------
		// dateTime
		// ----------------------------

		private var _dateTime:Date;

		/**
		 * Date/Time of departure
		 */
		public function get dateTime():Date {
			return _dateTime;
		}

		public function set dateTime(value:Date):void {
			if (value != _dateTime) {
				_dateTime = value;
			}
		}

		// ----------------------------
		// vehicle
		// ----------------------------

		private var _vehicle:IRVehicle;

		/**
		 * Vehicle departing
		 */
		public function get vehicle():IRVehicle {
			return _vehicle;
		}

		public function set vehicle(value:IRVehicle):void {
			if (value != _vehicle) {
				_vehicle = value;
			}
		}

		// ----------------------------
		// platform
		// ----------------------------

		private var _platform:IRStationPlatform;

		/**
		 * Platform where train departs
		 */
		public function get platform():IRStationPlatform {
			return _platform;
		}

		public function set platform(value:IRStationPlatform):void {
			if (value !== _platform) {
				_platform = value;
			}
		}

		// ----------------------------
		// destination
		// ----------------------------

		private var _destination:IRStation;

		/**
		 * Train destination (endpoint)
		 */
		public function get station():IRStation {
			return _destination;
		}

		public function set station(value:IRStation):void {
			if (value != _destination) {
				_destination = value;
			}
		}

		// ----------------------------
		// delay
		// ----------------------------

		private var _delay:Number;

		/**
		 * Train delay
		 */
		public function get delay():Number {
			return _delay;
		}

		public function set delay(value:Number):void {
			if (value != _delay) {
				_delay = value;
			}
		}
	}
}