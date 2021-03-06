
package be.irail.api.methodgroup {

	import be.irail.api.core.IRServiceURL;
	import be.irail.api.core.IRailAPISettings;
	import be.irail.api.data.scheduler.IRConnection;
	import be.irail.api.data.scheduler.gate.ArrivalIRGate;
	import be.irail.api.data.scheduler.gate.DepartureIRGate;
	import be.irail.api.data.scheduler.gate.ViaIRGate;
	import be.irail.api.data.scheduler.gate.via.ViaDepartArrival;
	import be.irail.api.data.stations.IRStation;
	import be.irail.api.data.stations.IRStationPlatform;
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
	 * Contains methods for scheduling train routes
	 *<br/><br/>
	 * created 06/08/2010
	 * @author Joris Timmerman
	 */
	[Event(name="schedulerResult", type="be.irail.api.event.IRailResultEvent")]
	[Event(name="ioError", type="be.irail.api.event.IRailErrorEvent")]
	[Event(name="apiError", type="be.irail.api.event.IRailErrorEvent")]
	public class Scheduler extends AbstractMethodGroup {

		/**
		 * Calculates possible routes from one station to another.
		 * @param from Departure station
		 * @param to Destination station
		 * @param dateTime (optional) Date and Time of departure
		 * @param includeTime (optional) If true, will include time in <code>dateTime</code> in query, else te query will only send a date
		 * @param dateTimeIndicator (optional) Indicate what the selected date and time indicates, arrival or departure. See <code>be.irail.api.core.DateTimeIndicator</code> for values. (default: departure)
		 * @param typesOfTransport array of values like train;bus;taxi
		 *
		 * @see be.irail.api.core.DateTimeIndicator
		 * @see be.irail.api.core.LanguageCode
		 */
		public function getRoutes(from:IRStation, to:IRStation, dateTime:Date = null, includeTime:Boolean = true, dateTimeIndicator:String = "depart", typesOfTransport:Array = null):void {
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

			if (IRailAPISettings.mainLanguage) {
				vars.lang = IRailAPISettings.mainLanguage;
			}

			if (typesOfTransport) {
				if (typesOfTransport.length == 1 && typesOfTransport.indexOf("train") > -1) {
					vars.trainsonly = 1;
				} else {
					vars.trainsonly = 0;
					vars.typeOfTransport = typesOfTransport.join(";");
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
				var connections:Array = [];
				var timestamp:String = data.@timestamp;
				var version:String = data.@version;

				for each (var connectionXML:XML in data..connection) {
					var connection:IRConnection = new IRConnection();
					connection.id = connectionXML.@id;

					// departure
					var departureGate:DepartureIRGate = new DepartureIRGate()
					departureGate.station = ParserUtil.parseStationXML(connectionXML.departure.station);

					departureGate.delay = connectionXML.departure.@delay;
					departureGate.dateTime = ParserUtil.getDateFromUnixTimestamp(connectionXML.departure.time);
					departureGate.platform = new IRStationPlatform(connectionXML.departure.platform, StringUtils.trim(connectionXML.departure.platform.@normal).toLowerCase() == "yes");
					departureGate.vehicle = ParserUtil.parseVehicle(connectionXML.departure.vehicle);
					connection.departure = departureGate;

					//vias
					connection.vias = [];
					for each (var viaXML:XML in connectionXML.vias.via) {
						var viaGate:ViaIRGate = new ViaIRGate();
						viaGate.id = viaXML.@id;
						viaGate.station = ParserUtil.parseStationXML(viaXML.station);

						var viaDepart:ViaDepartArrival = new ViaDepartArrival();
						viaDepart.dateTime = ParserUtil.getDateFromUnixTimestamp(viaXML.departure.time);
						viaDepart.platform = new IRStationPlatform(viaXML.departure.platform);
						viaGate.depart = viaDepart;

						var viaArrival:ViaDepartArrival = new ViaDepartArrival();
						viaArrival.dateTime = ParserUtil.getDateFromUnixTimestamp(viaXML.arrival.time);
						viaArrival.platform = new IRStationPlatform(viaXML.arrival.platform);
						viaGate.arrival = viaArrival;

						viaGate.vehicle = ParserUtil.parseVehicle(viaXML.vehicle);
						viaGate.timeBetween = viaXML.timeBetween;

						connection.vias.push(viaGate);
					}

					//arrival
					var arrivalGate:ArrivalIRGate = new ArrivalIRGate();
					arrivalGate.station = ParserUtil.parseStationXML(connectionXML.arrival.station);

					arrivalGate.platform = new IRStationPlatform(connectionXML.arrival.platform, StringUtils.trim(connectionXML.arrival.platform.@normal).toLowerCase() == "yes");
					arrivalGate.vehicle = ParserUtil.parseVehicle(connectionXML.arrival.vehicle);

					arrivalGate.dateTime = ParserUtil.getDateFromUnixTimestamp(connectionXML.arrival.time)

					connection.arrival = arrivalGate;

					//duration
					connection.duration = connectionXML.duration;
					connection.isDelayed = StringUtils.trim(connectionXML.duration.@delay).toLowerCase() == "yes";

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

			var year:String = String(dateObj.getFullYear()).substring(2, 4),
				date:String = day + month + year,
				hours:String = String(dateObj.hours),
				minutes:String = String(dateObj.minutes);

			if (hours.length == 1) {
				hours = "0" + hours;
			}
			if (minutes.length == 1) {
				minutes = "0" + minutes;
			}

			var time:String = "" + hours + minutes;

			return [date, time];
		}

	}
}