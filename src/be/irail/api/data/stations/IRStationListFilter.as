package be.irail.api.data.stations {

	public class IRStationListFilter {
		// ----------------------------
		// type
		// ----------------------------

		private var _type:String;

		/**
		 * Filter Type
		 * a filter type and the value of such a filter. Possible filters:
		 * 	country = obviously the name of a supported country
		 * 	typeOfTransport = type of supported transport by the station. For instance: taxi, train, boat, bus, ...
		 * 	geoloc = a semicolon separated list: long;lat;long;lat which defines a rectangle. All stations in this rectangle are returned
		 * see <pre> StationFilterType </pre> for possible values
		 * @see StationFilterType
		 */
		public function get type():String {
			return _type;
		}

		public function set type(value:String):void {
			if (value !== _type) {
				_type = value;
			}
		}

		// ----------------------------
		// value
		// ----------------------------

		private var _value:Object;

		public function get value():Object {
			return _value;
		}

		public function set value(value:Object):void {
			if (value !== _value) {
				_value = value;
			}
		}

		public function IRStationListFilter(type:String = "", value:Object = null):void {
			this.type = type;
			this.value = value;
		}
	}
}