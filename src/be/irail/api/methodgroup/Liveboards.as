package be.irail.api.methodgroup {
	import be.irail.api.core.IRServiceURL;
	import be.irail.api.data.liveboard.Liveboard;
	import be.irail.api.data.scheduler.IRVehicle;
	import be.irail.api.data.stations.IRStation;
	import be.irail.api.event.IRailResult;
	import be.irail.api.event.IRailResultEvent;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	/**
	 * Contains methods to consult Station Lifeboards
	 *<br/><br/>
	 * created 19/09/2010
	 * @author Joris Timmerman
	 */
	public class Liveboards extends AbstractMethodGroup {

		public function getStationLiveboard(station:IRStation):void {
			var serviceURL:String = IRServiceURL.LIVEBOARD_URL,
				loader:URLLoader = new URLLoader(),
				request:URLRequest = new URLRequest(serviceURL),
				vars:URLVariables = new URLVariables();

			vars.station = station.name;

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
				var liveboard:Liveboard = new Liveboard();
				var timestamp:String = data.@timestamp;
				var version:String = data.@version;

				var station:IRStation = new IRStation(data.station),
					stationLocationXML:String = "" + data.station.@location,
					stationLocation:Array = stationLocationXML.split(" ");

				station.longitude = stationLocation[0];
				station.latitude = stationLocation[1];

				liveboard.station = station;

				var iRailResultObject:IRailResult = new IRailResult(liveboard, timestamp, version);
				dispatchEvent(new IRailResultEvent(IRailResultEvent.LIVEBOARD_RESULT, iRailResultObject));
			}
		}
	}
}