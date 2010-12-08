
package be.irail.api.methodgroup {

	import be.irail.api.core.IRServiceURL;
	import be.irail.api.core.IRailAPISettings;
	import be.irail.api.data.vehicle.IRVehicle;
	import be.irail.api.data.vehicle.IRVehicleInformation;
	import be.irail.api.data.vehicle.VehicleStop;
	import be.irail.api.event.IRailResult;
	import be.irail.api.event.IRailResultEvent;
	import be.irail.api.util.DateUtil;
	import be.irail.api.util.ParserUtil;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	/**
	 * Contains methods to retreive vehicle information
	 *<br/><br/>
	 * created 19/09/2010
	 * @author Joris Timmerman
	 */
	[Event(name="vehicleResult", type="be.irail.api.event.IRailResultEvent")]
	[Event(name="ioError", type="be.irail.api.event.IRailErrorEvent")]
	[Event(name="apiError", type="be.irail.api.event.IRailErrorEvent")]
	public class Vehicles extends AbstractMethodGroup {

		/**
		 * Retreive information about a certain vehicle.
		 * @param vehicle Specific vehicle to get info for.
		 */
		public function getVehicleInformation(vehicle:IRVehicle):void {
			getVehicleInformationByVehicleCode(vehicle.vehicleCode);
		}

		/**
		 * Retreive information about a certain vehicle.
		 * @param id vehicle ID (vehicle code) to get info for.
		 */
		public function getVehicleInformationByVehicleCode(id:String):void {
			var serviceURL:String = IRServiceURL.VEHICLE_URL,
				loader:URLLoader = new URLLoader(),
				request:URLRequest = new URLRequest(serviceURL),
				vars:URLVariables = new URLVariables();

			vars.id = id;

			if (IRailAPISettings.mainLanguage) {
				vars.lang = IRailAPISettings.mainLanguage;
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
				//TODO
				var timestamp:String = data.@timestamp;
				var version:String = data.@version;

				var info:IRVehicleInformation = new IRVehicleInformation();
				info.vehicle = ParserUtil.parseVehicle(data.vehicle);

				info.stops = [];
				for each (var stopXML:XML in data.stops.stop) {
					var stop:VehicleStop = new VehicleStop();
					stop.id = stopXML.@id;
					stop.delay = stopXML.@delay;
					stop.station = ParserUtil.parseStationXML(stopXML.station);
					stop.dateTime = DateUtil.convertISO8601ToDate(stopXML.time.@formatted);
					info.stops.push(stop);
				}

				var iRailResultObject:IRailResult = new IRailResult(info, timestamp, version);
				dispatchEvent(new IRailResultEvent(IRailResultEvent.VEHICLE_INFO_RESULT, iRailResultObject));
			}
		}

	}
}