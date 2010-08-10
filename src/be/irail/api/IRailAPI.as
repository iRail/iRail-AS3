package be.irail.api {
	import be.irail.api.methodgroup.Stations;
	import be.irail.api.methodgroup.TrainScheduler;

	/**
	 * Main class containing all methodgroups.
	 * Use of this class is optional, methodgroups can be used separately.
	 *
	 * created 06/08/2010
	 * @author Joris Timmerman
	 */
	public class IRailAPI {
		private var _stations:Stations;
		private var _scheduler:TrainScheduler;

		public function IRailAPI() {
			_stations = new Stations();
			_scheduler = new TrainScheduler();
		}

		/**
		 * Train scheduler
		 */
		public function get scheduler():TrainScheduler {
			return _scheduler;
		}

		/**
		 * Stations
		 */
		public function get stations():Stations {
			return _stations;
		}

	}
}