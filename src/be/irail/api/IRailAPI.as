package be.irail.api {

	import be.irail.api.methodgroup.Liveboards;
	import be.irail.api.methodgroup.Scheduler;
	import be.irail.api.methodgroup.Stations;
	import be.irail.api.methodgroup.Vehicles;

	/**
	 * Main class containing all methodgroups.
	 * Use of this class is optional, methodgroups can be used separately.
	 *
	 * created 06/08/2010
	 * @author Joris Timmerman
	 */
	public class IRailAPI {
		private var _stations:Stations;

		private var _scheduler:Scheduler;

		private var _liveBoard:Liveboards;

		private var _vehicles:Vehicles;

		public function IRailAPI() {
			_stations = new Stations();
			_scheduler = new Scheduler();
			_liveBoard = new Liveboards();
			_vehicles = new Vehicles();
		}

		/**
		 * Scheduler
		 */
		public function get scheduler():Scheduler {
			return _scheduler;
		}

		/**
		 * Stations
		 */
		public function get stations():Stations {
			return _stations;
		}

		/**
		 * Lifeboards
		 */
		public function get liveboards():Liveboards {
			return _liveBoard;
		}

		/**
		 * vehicles
		 */
		public function get vehicles():Vehicles {
			return _vehicles;
		}
	}
}