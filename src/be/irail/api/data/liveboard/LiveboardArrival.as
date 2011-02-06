package be.irail.api.data.liveboard {
	import be.irail.api.data.stations.IRStation;
	import be.irail.api.data.stations.IRStationPlatform;
	import be.irail.api.data.vehicle.IRVehicle;

	/**
	 * Arrival data in Liveboard
	 * RemoteClass alias: irail.LiveboardArrival
	 * @author Joris Timmerman
	 */
	[RemoteClass(alias="irail.LiveboardArrival")]
	public class LiveboardArrival {
		// ----------------------------
		// id
		// ----------------------------

		private var _id:int;

		/**
		 * Arrival id (in list)
		 */
		public function get id():int {
			return _id;
		}

		public function set id(value:int):void {
			if (value != _id) {
				_id = value;
			}
		}
		// ----------------------------
		// dateTime
		// ----------------------------

		private var _dateTime:Date;

		/**
		 * Date/Time of arrival
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
		 * Vehicle arriving
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
		 * Arriving at platform
		 */
		public function get platform():IRStationPlatform {
			return _platform;
		}

		public function set platform(value:IRStationPlatform):void {
			if (value != _platform) {
				_platform = value;
			}
		}

		// ----------------------------
		// destination
		// ----------------------------

		private var _destination:IRStation;

		/**
		 * Train destination
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