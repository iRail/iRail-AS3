package be.irail.api.methodgroup {
	import be.irail.api.core.IRailServiceURL;
	import be.irail.api.data.stations.IRailStation;
	import be.irail.api.event.IRailResult;
	import be.irail.api.event.IRailResultEvent;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * Contains method for retreiving station list.
	 *<br/><br/>
	 * created 06/08/2010
	 * @author Joris Timmerman
	 */
	public class Stations extends AbstractMethodGroup {

		/**
		 * Retreives a list of all stations in Belgium
		 */
		public function getAllStations():void {
			var serviceURL:String = IRailServiceURL.ALL_STATIONS_URL;

			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest(serviceURL);

			loader.addEventListener(Event.COMPLETE, onResponse);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(request);
		}

		private function onResponse(event:Event):void {
			var data:XML = XML(event.target.data);
			var timestamp:String = data.@timestamp;

			var result:Array = [];
			for each (var station:XML in data..station) {
				var irailStation:IRailStation = new IRailStation(station.text().toString());
				var location:String = station.@location;

				//Fixed issue #5 - Notice the . instead of , for the coordinates! 
				//location = location.split(",").join(".");

				var coordinates:Array = location.split(" ");
				irailStation.longitude = coordinates[0];
				irailStation.latitude = coordinates[1];

				result.push(irailStation);
			}

			var iRailResultObject:IRailResult = new IRailResult(timestamp, result);
			dispatchEvent(new IRailResultEvent(IRailResultEvent.ALL_STATIONS_RESULT, iRailResultObject));
		}

	}
}