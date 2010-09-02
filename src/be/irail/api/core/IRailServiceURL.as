package be.irail.api.core {

	/**
	 * Class holding API service endpoint URLs.<br/>
	 * This makes updating URLs easier.<br/>
	 *<br/><br/>
	 * created 06/08/2010
	 * @author Joris Timmerman
	 */
	public class IRailServiceURL {

		// DEVELOPMENT
		/*public static const ALL_STATIONS_URL:String = "http://dev.irail.be/api/stations.php";
		 public static const SCHEDULER_URL:String = "http://dev.irail.be/api/trains.php";*/

		// PRODUCTION
		public static const ALL_STATIONS_URL:String = "http://api.irail.be/stations.php";
		public static const SCHEDULER_URL:String = "http://api.irail.be/trains.php";
	}
}