package be.irail.api.data.vehicle {

	import be.irail.api.data.stations.IRStation;

	/**
	 * Vehicle Stop
	 * RemoteClass alias: irail.VehicleStop
	 * @author Joris Timmerman
	 */
	[RemoteClass(alias="irail.VehicleStop")]
	public class VehicleStop {

		// ----------------------------
		// id
		// ----------------------------

		private var _id:int;

		/**
		 * Stop ID
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
		// delay
		// ----------------------------

		private var _delay:Number;

		/**
		 * Delay in seconds in stop
		 */
		public function get delay():Number {
			return _delay;
		}

		public function set delay(value:Number):void {
			if (value !== _delay) {
				_delay = value;
			}
		}

		// ----------------------------
		// station
		// ----------------------------

		private var _station:IRStation;

		/**
		 * Stop station
		 */
		public function get station():IRStation {
			return _station;
		}

		public function set station(value:IRStation):void {
			if (value != _station) {
				_station = value;
			}
		}

		// ----------------------------
		// dateTime
		// ----------------------------

		private var _dateTime:Date;

		/**
		 * Date time of arrival in station
		 */
		public function get dateTime():Date {
			return _dateTime;
		}

		public function set dateTime(value:Date):void {
			if (value !== _dateTime) {
				_dateTime = value;
			}
		}

	}
}