package be.irail.api.methodgroup {
	import be.irail.api.core.IRServiceURL;
	import be.irail.api.data.scheduler.IRConnection;
	import be.irail.api.data.scheduler.IRGate;
	import be.irail.api.data.scheduler.IRVehicle;
	import be.irail.api.data.scheduler.ViaIRGate;
	import be.irail.api.data.stations.IRStation;
	import be.irail.api.data.stations.IRStationPlatform;
	import be.irail.api.event.IRailResult;
	import be.irail.api.event.IRailResultEvent;
	import be.irail.api.util.DateUtil;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	/**
	 * Contains methods for scheduling train routes
	 *<br/><br/>
	 * created 06/08/2010
	 * @author Joris Timmerman
	 */
	public class Scheduler extends AbstractMethodGroup {

		/**
		 * Calculates possible routes from one station to another.
		 * @param from Departure station
		 * @param to Destination station
		 * @param dateTime (optional) Date and Time of departure
		 * @param includeTime (optional) If true, will include time in <code>dateTime</code> in query, else te query will only send a date
		 * @param dateTimeIndicator (optional) Indicate what the selected date and time indicates, arrival or departure. See <code>be.irail.api.core.DateTimeIndicator</code> for values. (default: departure)
		 * @param typesOfTransport array of values like train;bus;taxi
		 * @param numResults (optional) Number of results to return
		 * @param langCode (optional) Language code, see <code>be.irail.api.core.LanguageCode</code> for values
		 *
		 * @see be.irail.api.core.DateTimeIndicator
		 * @see be.irail.api.core.LanguageCode
		 */
		public function getRoutes(from:IRStation, to:IRStation, dateTime:Date = null, includeTime:Boolean = true, dateTimeIndicator:String = "depart", typesOfTransport:Array = null, numResults:int = -1, langCode:String = ""):void {
			var serviceURL:String = IRServiceURL.SCHEDULER_URL;
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest(serviceURL);

			var vars:URLVariables = new URLVariables();
			vars.from = from.name;
			vars.to = to.name;

			if (dateTime != null) {

				var formattedDateTime:Array = formatDate(dateTime);
				vars.date = formattedDateTime[0];

				if (includeTime) {
					vars.time = formattedDateTime[1];
				}

				vars.timesel = dateTimeIndicator;
			}

			if (langCode.length > 0) {
				vars.lang = langCode;
			}

			if (typesOfTransport) {
				if (typesOfTransport.length == 1 && typesOfTransport.indexOf("train") > -1) {
					vars.trainsonly = 1;
				} else {
					vars.trainsonly = 0;
					vars.typeOfTransport = typesOfTransport.join(";");
				}
			}

			if (numResults > 0) {
				vars.results = numResults;
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
				var connections:Array = [];
				var timestamp:String = data.@timestamp;
				var version:String = data.@version;

				for each (var connectionXML:XML in data..connection) {
					var connection:IRConnection = new IRConnection();
					connection.id = connectionXML.@id;

					// departure
					var departureGate:IRGate = new IRGate(),
						departureStation:IRStation = new IRStation(connectionXML.departure.station),
						departureStationLocationXML:String = "" + connectionXML.departure.station.@location,
						departureStationLocation:Array = departureStationLocationXML.split(" ");

					departureStation.longitude = departureStationLocation[0];
					departureStation.latitude = departureStationLocation[1];
					departureGate.station = departureStation;

					departureGate.dateTime = DateUtil.convertISO8601ToDate(connectionXML.departure.time.@formatted);
					departureGate.platform = new IRStationPlatform(connectionXML.departure.platform, connectionXML.departure.platform.@normal);
					departureGate.vehicule = new IRVehicle(connectionXML.departure.vehicle);
					connection.departure = departureGate;

					//vias
					connection.vias = [];
					for each (var viaXML:XML in connectionXML.vias.via) {
						var viaGate:ViaIRGate = new ViaIRGate(),
							viaStation:IRStation = new IRStation(viaXML.station),
							viaStationLocationXML:String = "" + viaXML.station.@location,
							viaStationLocation:Array = viaStationLocationXML.split(" ");

						viaGate.id = viaXML.@id;

						viaStation.longitude = viaStationLocation[0];
						viaStation.latitude = viaStationLocation[1];
						viaGate.station = viaStation;

						viaGate.arrivalDate = DateUtil.convertISO8601ToDate(viaXML.arrival.time.@formatted);
						viaGate.departTime = DateUtil.convertISO8601ToDate(viaXML.depart.time.@formatted);
						viaGate.arriveAtPlatform = new IRStationPlatform(viaXML.arrival.platform);
						viaGate.departAtPlatform = new IRStationPlatform(viaXML.depart.platform);

						viaGate.vehicule = new IRVehicle(viaXML.vehicle);

						viaGate.timeBetween = viaXML.timeBetween;

						connection.vias.push(viaGate);
					}

					//arrival
					var arrivalGate:IRGate = new IRGate(),
						arrivalGateStation:IRStation = new IRStation(connectionXML.arrival.station),
						arrivalStationXML:String = "" + connectionXML.arrival.station.@location,
						arrivalStationLocation:Array = arrivalStationXML.split(" ");

					arrivalGateStation.longitude = arrivalStationLocation[0];
					arrivalGateStation.latitude = arrivalStationLocation[1];
					arrivalGate.station = arrivalGateStation;

					arrivalGate.platform = new IRStationPlatform(connectionXML.arrival.platform, connectionXML.arrival.platform.@normal);
					arrivalGate.vehicule = new IRVehicle(connectionXML.arrival.vehicle);

					arrivalGate.dateTime = DateUtil.convertISO8601ToDate(connectionXML.arrival.time.@formatted)

					connection.arrival = arrivalGate;

					//duration
					connection.formattedDuration = connectionXML.duration;

					connection.delay = connectionXML.duration.@delay;

					connections.push(connection);
				}

				var iRailResultObject:IRailResult = new IRailResult(connections, timestamp, version);
				dispatchEvent(new IRailResultEvent(IRailResultEvent.SCHEDULER_RESULT, iRailResultObject));
			}
		}

		private function formatDate(dateObj:Date):Array {
			var day:String = String(dateObj.getDate());
			if (day.length == 1) {
				day = "0" + day;
			}

			var month:String = String(dateObj.getMonth() + 1);
			if (month.length == 1) {
				month = "0" + month;
			}

			var year:String = String(dateObj.getFullYear()).substring(2, 4);

			var date:String = day + month + year;
			var time:String = dateObj.hours + ":" + dateObj.minutes;

			return [date, time];
		}

	}
}