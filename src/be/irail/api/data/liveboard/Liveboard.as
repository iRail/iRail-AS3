package be.irail.api.data.liveboard {
	import be.irail.api.data.stations.IRStation;

	public class Liveboard {
		public function Liveboard() {
		}

		// ----------------------------
		// station
		// ----------------------------

		private var _station:IRStation;

		public function get station():IRStation {
			return _station;
		}

		public function set station(value:IRStation):void {
			if (value != _station) {
				_station = value;
			}
		}
	}
}