package be.irail.api.core {

	/**
	 * Class holding API service endpoint URLs.<br/>
	 * This makes updating URLs easier.<br/>
	 *<br/><br/>
	 * created 06/08/2010
	 * @author Joris Timmerman
	 */
	public class IRServiceURL {

		// DEVELOPMENT
		public static const ALL_STATIONS_URL:String = "http://dev.api.irail.be/stations/";
		public static const SCHEDULER_URL:String = "http://dev.api.irail.be/connections/";
		public static const LIVEBOARD_URL:String = "http://dev.api.irail.be/liveboard.php";
		public static const VEHICLE_URL:String = "http://dev.api.irail.be/vehicle.php";

		// PRODUCTION
	/*	public static const ALL_STATIONS_URL:String = "http://api.irail.be/stations/";
		public static const SCHEDULER_URL:String = "http://api.irail.be/connections/";
		public static const LIVEBOARD_URL:String = "http://api.irail.be/liveboard.php";
		public static const VEHICLE_URL:String = "http://api.irail.be/vehicle/";*/
	}
}