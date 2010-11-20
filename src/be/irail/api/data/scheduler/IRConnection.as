package be.irail.api.data.scheduler {
	import be.irail.api.data.scheduler.gate.ArrivalIRGate;
	import be.irail.api.data.scheduler.gate.DepartureIRGate;

	/**
	 * Contains data of a route between to stations.<br/>
	 * Used in scheduler result.
	 *<br/><br/>
	 * created 06/08/2010
	 * @author Joris Timmerman
	 */
	public class IRConnection {

		// ----------------------------
		// id
		// ----------------------------

		private var _id:int;

		public function get id():int {
			return _id;
		}

		public function set id(value:int):void {
			if (value != _id) {
				_id = value;
			}
		}

		// ----------------------------
		// departure
		// ----------------------------

		private var _departure:DepartureIRGate;

		/**
		 * Departure information
		 */
		public function get departure():DepartureIRGate {
			return _departure;
		}

		public function set departure(value:DepartureIRGate):void {
			if (value !== _departure) {
				_departure = value;
			}
		}

		// ----------------------------
		// via
		// ----------------------------

		private var _via:Array = [];

		/**
		 * Information about all via-stations between departure and arrival
		 */
		public function get vias():Array {
			return _via;
		}

		public function set vias(value:Array):void {
			if (value !== _via) {
				_via = value;
			}
		}

		/**
		 * Number of vias
		 */
		public function get numVias():int {
			if (!vias) {
				return 0;
			}
			return _via.length;
		}
		// ----------------------------
		// arrival
		// ----------------------------

		private var _arrival:ArrivalIRGate;

		/**
		 * Arrival information
		 */
		public function get arrival():ArrivalIRGate {
			return _arrival;
		}

		public function set arrival(value:ArrivalIRGate):void {
			if (value !== _arrival) {
				_arrival = value;
			}
		}

		// ----------------------------
		// duration
		// ----------------------------

		private var _duration:Number;

		/**
		 * Trip duration in seconds
		 */
		public function get duration():Number {
			return _duration;
		}

		public function set duration(value:Number):void {
			if (value != _duration) {
				_duration = value;
			}
		}

		// ----------------------------
		// isDelayed
		// ----------------------------

		private var _isDelayed:Boolean;

		/**
		 * Train is delayed
		 */
		public function get isDelayed():Boolean {
			return _isDelayed;
		}

		public function set isDelayed(value:Boolean):void {
			if (value !== _isDelayed) {
				_isDelayed = value;
			}
		}


		public function IRConnection() {
		}
	}
}