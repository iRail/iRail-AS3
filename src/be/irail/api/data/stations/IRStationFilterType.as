package be.irail.api.data.stations {

	public class IRStationFilterType {
		/**
		 * Filter on country
		 */
		public static const COUNTRY:String = "country";
		/**
		 * Filter on type of supported transport by the station. For instance: taxi, train, boat, bus, ...
		 */
		public static const TYPE_OF_TRANSPORT:String = "typeOfTransport";
		/**
		 * Filter on a semicolon separated list: long;lat;long;lat which defines a rectangle. All stations in this rectangle are returned
		 */
		public static const GEOLOC:String = "geoloc";
	}
}