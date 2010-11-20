package be.irail.api.methodgroup {
	import be.irail.api.core.IRServiceURL;
	import be.irail.api.data.stations.IRStation;
	import be.irail.api.data.stations.IRStationListFilter;
	import be.irail.api.event.IRailResult;
	import be.irail.api.event.IRailResultEvent;
	import be.irail.api.util.ParserUtil;
	import be.irail.api.util.StringUtils;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	/**
	 * Contains methods for retreiving station lists.
	 *<br/><br/>
	 * created 06/08/2010
	 * @author Joris Timmerman
	 */
	public class Stations extends AbstractMethodGroup {

		/**
		 * Retreives a list of all stations in Belgium
		 */
		public function getAllStations():void {
			getFilteredStationList([]);
		}

		/**
		 * Returns a filtered list of stations
		 * @param filters Array of StationListFilter objects to filter station list.
		 * @see StationListFilter
		 */
		public function getFilteredStationList(filters:Array):void {
			var serviceURL:String = IRServiceURL.ALL_STATIONS_URL;

			var loader:URLLoader = new URLLoader(),
				request:URLRequest = new URLRequest(serviceURL),
				vars:URLVariables = new URLVariables();

			if (filters) {
				var filterLen:int = filters.length, i:int;
				for (i = 1; i <= filterLen; i++) {
					if (filters[i - 1] is IRStationListFilter) {
						var filter:IRStationListFilter = IRStationListFilter(filters[i - 1]);
						vars["type" + i] = filter.type;
						vars["value" + i] = filter.value;
					}
				}
			}

			request.data = vars;

			loader.addEventListener(Event.COMPLETE, onResponse);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(request);
		}

		private function onResponse(event:Event):void {
			var data:XML = XML(event.target.data);
			if ("error" in data) {
				onAPIError(data.error);
			} else {
				var timestamp:String = data.@timestamp;
				var version:String = data.@version;

				var result:Array = [];
				for each (var station:XML in data..station) {
					result.push(ParserUtil.parseStationXML(station));
				}

				var iRailResultObject:IRailResult = new IRailResult(result, timestamp, version);
				dispatchEvent(new IRailResultEvent(IRailResultEvent.STATION_LIST_RESULT, iRailResultObject));
			}
		}

	}
}