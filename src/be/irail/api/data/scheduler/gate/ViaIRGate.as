package be.irail.api.data.scheduler.gate {
	import be.irail.api.data.stations.IRStation;
	import be.irail.api.data.stations.IRStationPlatform;
	import be.irail.api.data.vehicle.IRVehicle;
	import be.irail.api.data.scheduler.gate.via.ViaDepartArrival;

	public class ViaIRGate {
		// ----------------------------
		// id
		// ----------------------------

		private var _id:int;

		/**
		 * Via connect gate no.
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
		// station
		// ----------------------------

		private var _station:IRStation;

		/**
		 * Station
		 * @see be.irail.api.data.stations.IRailStation
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
		// vehicle
		// ----------------------------

		private var _vehicle:IRVehicle;

		/**
		 * Vehicle
		 **/
		public function get vehicle():IRVehicle {
			return _vehicle;
		}

		public function set vehicle(value:IRVehicle):void {
			if (value != _vehicle) {
				_vehicle = value;
			}
		}

		// ----------------------------
		// timeBetween
		// ----------------------------

		private var _timeBetween:Number;

		/**
		 * Time between
		 */
		public function get timeBetween():Number {
			return _timeBetween;
		}

		public function set timeBetween(value:Number):void {
			if (value != _timeBetween) {
				_timeBetween = value;
			}
		}

		// ----------------------------
		// arrival
		// ----------------------------

		private var _arrival:ViaDepartArrival;

		/**
		 * Arrival data of this Via station (date/time platform)
		 */
		public function get arrival():ViaDepartArrival {
			return _arrival;
		}

		public function set arrival(value:ViaDepartArrival):void {
			if (value != _arrival) {
				_arrival = value;
			}
		}

		// ----------------------------
		// depart
		// ----------------------------

		private var _depart:ViaDepartArrival;

		/**
		 * Depart data of this Via station (date/time platform)
		 */
		public function get depart():ViaDepartArrival {
			return _depart;
		}

		public function set depart(value:ViaDepartArrival):void {
			if (value !== _depart) {
				_depart = value;
			}
		}

	}
}