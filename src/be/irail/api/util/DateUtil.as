package be.irail.api.util {

	public class DateUtil {
		private static const DASH:String = "-";
		private static const COLON:String = ":";
		private static const ZULU:String = "Z";
		private static const T:String = "T";
		private static const ZERO:String = "0";

		public static function convertISO8601ToDate(isoDate:String):Date {
			return parseDateTimeString(isoDate);
		}

		/**
		 * Converts an AS3 Date object into an ISO-8601 UTC extended date and time String (YYYY-MM-HHTHH:MM:SSZ).
		 * The zulu designation (Z) at the end of the string indicates the time is UTC (Coordinated Universal Time).
		 */
		public static function formatExtendedDateTime(date:Date):String {
			return formatExtendedDate(date)
				+ T
				+ formatExtendedTime(date)
				+ ZULU;
		}

		/**
		 * Converts an AS3 Date object into an ISO-8601 UTC basic date and time String. The Basic format has no hyphens or
		 * colons, but does have a UTC zulu designation at the end.
		 */
		public static function formatBasicDateTime(date:Date):String {
			return formatBasicDate(date)
				+ T
				+ formatBasicTime(date)
				+ ZULU;
		}

		public static function formatDateForDateStamp(dateObj:Date):String {
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

			return date;
		}

		/**
		 * converts an ISO-8601 date + time (UTC) string of format "2009-02-21T09:00:00Z" to an AS3 Date Object.
		 * The zulu designation (Z) at the end of the string indicates the time is UTC (Coordinated Universal Time).
		 * Even if the zulu designation is missing UTC will be assumed.
		 */
		public static function parseDateTimeString(val:String):Date {
			//first strip all non-numerals from the String ( convert all extended dates to basic)
			val = val.replace(/-|:|T|Z/g, "");

			var date:Date = parseBasicDate(val.substr(0, 8));
			date = parseBasicTime(val.substr(8, 6), date);

			return date;
		}

		public static function parseBasicDate(val:String, date:Date = null):Date {
			if (date == null) {
				date = new Date();
			}

			date.setUTCFullYear(convertYear(val), convertMonth(val), convertDate(val));

			return date;
		}

		public static function parseBasicTime(val:String, date:Date = null):Date {
			if (date == null) {
				date = new Date();
			}

			date.setUTCHours(convertHours(val), convertMinutes(val), convertSeconds(val));

			return date;
		}

		public static function formatExtendedDate(date:Date):String {
			return formatYear(date.getUTCFullYear())
				+ DASH
				+ formatMonth(date.getUTCMonth())
				+ DASH
				+ formatDate(date.getUTCDate())
		}

		public static function formatBasicDate(date:Date):String {
			return formatYear(date.getUTCFullYear())
				+ formatMonth(date.getUTCMonth())
				+ formatDate(date.getUTCDate());
		}

		public static function formatExtendedTime(date:Date):String {
			return formatTimeChunk(date.getUTCHours())
				+ COLON
				+ formatTimeChunk(date.getUTCMinutes())
				+ COLON
				+ formatTimeChunk(date.getUTCSeconds());
		}

		public static function formatBasicTime(date:Date):String {
			return formatTimeChunk(date.getUTCHours())
				+ formatTimeChunk(date.getUTCMinutes())
				+ formatTimeChunk(date.getUTCSeconds());
		}

		/**
		 * assumes an 8601 basic date string (8 characters YYYYMMDD)
		 */
		private static function convertYear(val:String):int {
			val = val.substr(0, 4);
			return parseInt(val);
		}

		/**
		 * assumes an 8601 basic date string (8 characters YYYYMMDD)
		 */
		private static function convertMonth(val:String):int {
			val = val.substr(4, 2);
			var y:int = parseInt(val) - 1; // months are zero indexed in Date objects so we need to decrement
			return y;
		}

		/**
		 * assumes an 8601 basic date string (8 characters YYYYMMDD)
		 */
		private static function convertDate(val:String):int {
			val = val.substr(6, 2);

			return parseInt(val);
		}

		/**
		 * assumes a 8601 basic UTC time string (6 characters HHMMSS)
		 */
		private static function convertHours(val:String):int {
			val = val.substr(0, 2);

			return parseInt(val);
		}

		/**
		 * assumes a 8601 basic UTC time string (6 characters HHMMSS)
		 */
		private static function convertMinutes(val:String):int {
			val = val.substr(2, 2);

			return parseInt(val);
		}

		/**
		 * assumes a 8601 basic UTC time string (6 characters HHMMSS)
		 */
		private static function convertSeconds(val:String):int {
			val = val.substr(4, 2);

			return parseInt(val);
		}

		// doesn't handle BC dates
		private static function formatYear(year:int):String {
			var y:String = year.toString();
			// 0009 0010 0099 0100
			if (year < 10) {
				y = ZERO + ZERO + ZERO + y;
			} else if (year < 100) {
				y = ZERO + ZERO + y;
			} else if (year < 1000) {
				y = ZERO + y;
			}

			return y;
		}

		private static function formatMonth(month:int):String {
			// Date object months are zero indexed so always increment the month up by one
			month++;

			// convert the month to a String
			var m:String = month.toString();

			if (month < 10) {
				m = ZERO + m;
			}

			return m;
		}

		private static function formatDate(date:int):String {
			var d:String = date.toString()
			if (date < 10) {
				d = ZERO + d;
			}

			return d;
		}

		private static function formatTimeChunk(val:int):String {
			var t:String = val.toString();

			if (val < 10) {
				t = ZERO + t;
			}

			return t;
		}
	}
}