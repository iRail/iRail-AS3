package be.irail.api.methodgroup {
	import be.irail.api.core.IRailServiceURL;
	import be.irail.api.data.scheduler.TrainConnection;
	import be.irail.api.data.scheduler.TrainGate;
	import be.irail.api.data.stations.IRailStation;
	import be.irail.api.event.IRailResult;
	import be.irail.api.event.IRailResultEvent;

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
	public class TrainScheduler extends AbstractMethodGroup {

		/**
		 * Calculates possible routes from one station to another.
		 * @param from Departure station
		 * @param to Destination station
		 * @param dateTime (optional) Date and Time of departure
		 * @param includeTime (optional) If true, will include time in <code>dateTime</code> in query, else te query will only send a date
		 * @param dateTimeIndicator (optional) Indicate what the selected date and time indicates, arrival or departure. See <code>be.irail.api.core.DateTimeIndicator</code> for values. (default: departure)
		 * @param trainsOnly (optional) Return only trains or also other means of transportation, like busses and metro.
		 * @param langCode (optional) Language code, see <code>be.irail.api.core.LanguageCode</code> for values
		 *
		 * @see be.irail.api.core.DateTimeIndicator
		 * @see be.irail.api.core.LanguageCode
		 */
		public function getRoutes(from:IRailStation, to:IRailStation, dateTime:Date = null, includeTime:Boolean = true, dateTimeIndicator:String = "depart", trainsOnly:Boolean = false, langCode:String = ""):void {
			var serviceURL:String = IRailServiceURL.SCHEDULER_URL;
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

			vars.trainsonly = (trainsOnly) ? 1 : 0;

			request.data = vars;

			loader.addEventListener(Event.COMPLETE, onResponse);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(request);
		}

		private function onResponse(event:Event):void {
			var data:XML = XML(event.target.data);

			var connections:Array = [];
			for each (var connectionXML:XML in data..connection) {
				var connection:TrainConnection = new TrainConnection();

				// departure
				var departureGate:TrainGate = new TrainGate();
				departureGate.station = new IRailStation(connectionXML.departure.station);

				departureGate.formattedDate = connectionXML.departure.date;
				departureGate.formattedTime = connectionXML.departure.time;
				departureGate.dateTime = getDateFromDateTimeStrings(departureGate.formattedDate, departureGate.formattedTime);

				connection.departure = departureGate;

				//arrival
				var arrivalGate:TrainGate = new TrainGate();
				arrivalGate.station = new IRailStation(connectionXML.arrival.station);

				arrivalGate.formattedDate = connectionXML.arrival.date;
				arrivalGate.formattedTime = connectionXML.arrival.time;
				arrivalGate.dateTime = getDateFromDateTimeStrings(arrivalGate.formattedDate, arrivalGate.formattedTime);

				connection.arrival = arrivalGate;

				//duration
				connection.formattedDuration = connectionXML.duration;

				connection.delay = connectionXML.delay;

				connection.trains = new Vector.<String>();
				for each (var trainXML:XML in connectionXML.trains..train) {
					var train:String = trainXML.toString();
					connection.trains.push(train);
				}

				connections.push(connection);
			}

			var iRailResultObject:IRailResult = new IRailResult(formatDate(new Date())[0], connections);
			dispatchEvent(new IRailResultEvent(IRailResultEvent.SCHEDULER_RESULT, iRailResultObject));
		}

		private function getDateFromDateTimeStrings(date:String, time:String):Date {
			var dateData:Array = date.split("-");
			var timeData:Array = time.split(":");

			var year:String = String(new Date().fullYear).substr(0, 2) + dateData[2];

			return new Date(year, (dateData[1] - 1), dateData[0], timeData[0], timeData[1]);
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

			var date:String = day + "-" + month + "-" + year;
			var time:String = dateObj.hours + ":" + dateObj.minutes;

			return [date, time];
		}
	}
}