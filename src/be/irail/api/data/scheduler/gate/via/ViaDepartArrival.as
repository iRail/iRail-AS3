package be.irail.api.data.scheduler.gate.via {
	import be.irail.api.data.stations.IRStationPlatform;

	public class ViaDepartArrival {
		// ----------------------------
		// arrivalTime
		// ----------------------------

		private var _arrivalTime:Date;

		/**
		 * Date &amp; Time of arrival
		 */
		public function get dateTime():Date {
			return _arrivalTime;
		}

		public function set dateTime(value:Date):void {
			if (value != _arrivalTime) {
				_arrivalTime = value;
			}
		}

		// ----------------------------
		// departAtPlatform
		// ----------------------------

		private var _departAtPlatform:IRStationPlatform;

		/**
		 * Departure platform
		 */
		public function get platform():IRStationPlatform {
			return _departAtPlatform;
		}

		public function set platform(value:IRStationPlatform):void {
			if (value != _departAtPlatform) {
				_departAtPlatform = value;
			}
		}
	}
}