package be.irail.api.data.scheduler {

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

		private var _departure:IRGate;

		/**
		 * Departure information
		 */
		public function get departure():IRGate {
			return _departure;
		}

		public function set departure(value:IRGate):void {
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

		private var _arrival:IRGate;

		/**
		 * Arrival information
		 */
		public function get arrival():IRGate {
			return _arrival;
		}

		public function set arrival(value:IRGate):void {
			if (value !== _arrival) {
				_arrival = value;
			}
		}

		// ----------------------------
		// durationInMinutes
		// ----------------------------
		/**
		 * Returns the duration in minutes
		 */
		public function get durationInMinutes():Number {
			if (_formattedDuration.indexOf(":") > -1) {
				var hours:Number = _formattedDuration.split(":")[0];
				var minutes:Number = _formattedDuration.split(":")[1];
				return (hours * 60) + minutes;
			}

			if (!isNaN(Number(_formattedDuration))) {
				return Number(_formattedDuration);
			}

			return 0;
		}


		// ----------------------------
		// formattedDuration
		// ----------------------------

		private var _formattedDuration:String = "";

		/**
		 * Trip duration string
		 */
		public function get formattedDuration():String {
			return _formattedDuration;
		}

		public function set formattedDuration(value:String):void {
			if (value != _formattedDuration) {
				_formattedDuration = value;
			}
		}

		// ----------------------------
		// delay
		// ----------------------------

		private var _delay:Number = 0;

		/**
		 * Trains is delayed
		 */
		public function get delay():Number {
			return _delay;
		}

		public function set delay(value:Number):void {
			if (value != _delay) {
				_delay = value;
			}
		}


		public function IRConnection() {
		}
	}
}