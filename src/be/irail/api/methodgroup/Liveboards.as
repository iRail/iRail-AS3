package be.irail.api.methodgroup {

	import be.irail.api.core.IRServiceURL;
	import be.irail.api.core.IRailAPISettings;
	import be.irail.api.data.liveboard.Liveboard;
	import be.irail.api.data.liveboard.LiveboardArrival;
	import be.irail.api.data.liveboard.LiveboardDeparture;
	import be.irail.api.data.stations.IRStation;
	import be.irail.api.data.stations.IRStationPlatform;
	import be.irail.api.event.IRailResult;
	import be.irail.api.event.IRailResultEvent;
	import be.irail.api.util.ParserUtil;

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
	[Event(name="liveboardResult", type="be.irail.api.event.IRailResultEvent")]
	[Event(name="ioError", type="be.irail.api.event.IRailErrorEvent")]
	[Event(name="apiError", type="be.irail.api.event.IRailErrorEvent")]
	public class Liveboards extends AbstractMethodGroup {

		/**
		 * Get the Liveboard of the requested station
		 * @param dateTime date [and time] of depart/arrival
		 * @param useTime Search by time (if true) or search only by date
		 * @param arrivalOrDeparture Given date/time is arrival or departure (possible values: 'arrival' or 'departure')
		 *
		 */
		public function getStationLiveboard(station:IRStation, dateTime:Date = null, useTime:Boolean = false, arrivalOrDeparture:String = "arrival"):void {
			if (!station) {
				return;
			}

			if (station.id.length > 0) {
				getStationLiveboardByStationId(station.id, dateTime, useTime, arrivalOrDeparture);
			} else {
				getStationLiveboardByStationName(station.name, dateTime, useTime, arrivalOrDeparture);
			}
		}

		/**
		 * Get the Liveboard of the requested station
		 * @param id Station Id (Be.Nmbs.1)
		 * @param dateTime date [and time] of depart/arrival
		 * @param useTime Search by time (if true) or search only by date
		 * @param arrivalOrDeparture Given date/time is arrival or departure (possible values: 'arrival' or 'departure')
		 *
		 */
		public function getStationLiveboardByStationId(id:String, dateTime:Date = null, useTime:Boolean = false, arrivalOrDeparture:String = "departure"):void {
			if (!id) {
				return;
			}

			var serviceURL:String = IRServiceURL.LIVEBOARD_URL,
				loader:URLLoader = new URLLoader(),
				request:URLRequest = new URLRequest(serviceURL),
				vars:URLVariables = new URLVariables();

			vars.id = id;

			if (dateTime) {
				var formattedDate:Array = formatDate(dateTime);
				vars.date = formattedDate[0];

				if (useTime) {
					vars.time = formattedDate[1];
				}

				vars.arrdep = (arrivalOrDeparture == "arrival") ? "ARR" : "DEP";
			}

			if (IRailAPISettings.mainLanguage) {
				vars.lang = IRailAPISettings.mainLanguage;
			}

			request.data = vars;

			loader.addEventListener(Event.COMPLETE, onResponse);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(request);
		}

		/**
		 * Get the Liveboard of the requested station
		 * @param name Station name (approx.)
		 * @param dateTime date [and time] of depart/arrival
		 * @param useTime Search by time (if true) or search only by date
		 * @param arrivalOrDeparture Given date/time is arrival or departure (values: 'arrive' or 'depart')
		 *
		 */
		public function getStationLiveboardByStationName(name:String, dateTime:Date = null, useTime:Boolean = false, arrivalOrDeparture:String = "depart"):void {
			if (!name) {
				return;
			}

			var serviceURL:String = IRServiceURL.LIVEBOARD_URL,
				loader:URLLoader = new URLLoader(),
				request:URLRequest = new URLRequest(serviceURL),
				vars:URLVariables = new URLVariables();

			vars.station = name;

			if (dateTime) {
				var formattedDate:Array = formatDate(dateTime);
				vars.date = formattedDate[0];

				if (useTime) {
					vars.time = formattedDate[1];
				}

				vars.arrdep = (arrivalOrDeparture == "arrival") ? "ARR" : "DEP";
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
				var liveboard:Liveboard = new Liveboard();
				var timestamp:String = data.@timestamp;
				var version:String = data.@version;
				liveboard.station = ParserUtil.parseStationXML(data.station);

				liveboard.departures = [];
				for each (var departureXML:XML in data.departures.departure) {
					var departure:LiveboardDeparture = new LiveboardDeparture();
					departure.id = departureXML.@id;
					departure.dateTime = ParserUtil.getDateFromUnixTimestamp(departureXML.time);
					departure.platform = new IRStationPlatform(departureXML.platform);
					departure.vehicle = ParserUtil.parseVehicle(departureXML.vehicle);
					departure.delay = departureXML.@delay;

					departure.station = ParserUtil.parseStationXML(departureXML.station);

					liveboard.departures.push(departure);
				}

				liveboard.arrivals = [];
				for each (var arrivalXML:XML in data.arrivals.arrival) {
					var arrival:LiveboardArrival = new LiveboardArrival();
					arrival.id = arrivalXML.@id;
					arrival.dateTime = ParserUtil.getDateFromUnixTimestamp(arrivalXML.time);
					arrival.platform = new IRStationPlatform(arrivalXML.platform);
					arrival.vehicle = ParserUtil.parseVehicle(arrivalXML.vehicle);
					arrival.delay = arrivalXML.@delay;

					arrival.station = ParserUtil.parseStationXML(arrivalXML.station);

					liveboard.arrivals.push(arrival);
				}

				var iRailResultObject:IRailResult = new IRailResult(liveboard, timestamp, version);
				dispatchEvent(new IRailResultEvent(IRailResultEvent.LIVEBOARD_RESULT, iRailResultObject));
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
			var time:String = "" + dateObj.hours + dateObj.minutes;

			return [date, time];
		}
	}
}