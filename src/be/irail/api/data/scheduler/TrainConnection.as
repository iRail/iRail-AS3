package be.irail.api.data.scheduler {

	/**
	 * Contains data of a route between to stations.<br/>
	 * Used in scheduler result.
	 *<br/><br/>
	 * created 06/08/2010
	 * @author Joris Timmerman
	 */
	public class TrainConnection {

		// ----------------------------
		// departure
		// ----------------------------

		private var _departure:TrainGate;

		/**
		 * Departure information
		 */
		public function get departure():TrainGate {
			return _departure;
		}

		public function set departure(value:TrainGate):void {
			if (value !== _departure) {
				_departure = value;
			}
		}

		// ----------------------------
		// arrival
		// ----------------------------

		private var _arrival:TrainGate;

		/**
		 * Arrival information
		 */
		public function get arrival():TrainGate {
			return _arrival;
		}

		public function set arrival(value:TrainGate):void {
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

		private var _delay:String;

		/**
		 * Trains delay time
		 */
		public function get delay():String {
			return _delay;
		}

		public function set delay(value:String):void {
			if (value != _delay) {
				_delay = value;
			}
		}

		// ----------------------------
		// trains
		// ----------------------------

		private var _trains:Vector.<String>;

		/**
		 * Means of transport on route
		 */
		public function get trains():Vector.<String> {
			return _trains;
		}

		public function set trains(value:Vector.<String>):void {
			if (value != _trains) {
				_trains = value;
			}
		}

		public function TrainConnection() {
		}
	}
}