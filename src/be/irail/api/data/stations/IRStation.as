package be.irail.api.data.stations {

	/**
	 * Station data object, contains data about a station.
	 *<br/><br/>
	 * created 06/08/2010
	 * @author Joris Timmerman
	 */
	public class IRStation {
		private var _name:String;

		/**
		 * Capitalized station name (like BRUSSEL-ZUID)
		 */
		public function get name():String {
			return _name;
		}

		public function set name(value:String):void {
			if (value != _name) {
				_name = value;
			}
		}

		private var _longitude:Number;

		/**
		 * Station position: longitude
		 */
		public function get longitude():Number {
			return _longitude;
		}

		public function set longitude(value:Number):void {
			if (value != _longitude) {
				_longitude = value;
			}
		}


		private var _latitude:Number;

		/**
		 * Station position: latitude
		 */
		public function get latitude():Number {
			return _latitude;
		}

		public function set latitude(value:Number):void {
			if (value !== _latitude) {
				_latitude = value;
			}
		}

		/**
		 * Returns formatted name of the station (like Brussel-Zuid).
		 *
		 * Added: 07/08/2010
		 */
		public function get formattedName():String {
			return toTitleCase(this.name);
		}


		public function IRStation(name:String) {
			this.name = name;
		}

		/**
		 * Label function for stations.<br/>
		 * Formats station names from capitals to title case.<br/>
		 * Use as a static function, for example in a Flex application.<br/>
		 * <code>labelFunction="IRailStation.labelFunction"</code>
		 *
		 * Added: 07/08/2010
		 */
		public static function labelFunction(data:IRStation):String {
			return data.formattedName;
		}

		private function toTitleCase(strIn:String):String {
			//check if is null
			if (!strIn) {
				return "";
			}

			// define characters after which the next letter is a capital
			var interruptors:Array = [" ", "-"],

				//char array of the word
				chars:Array = strIn.split(""),

				// will indicate when next character will have a capital
				nextIsCapital:Boolean = true,

				//return value will be stored here
				retValue:String = "";

			// check every character in string
			// if character is found in interruptors, the next character will be a capital
			var i:int = 0;
			for (i = 0; i < chars.length; i++) {
				var char:String = chars[i];

				if (nextIsCapital) {

					char = char.toUpperCase();
					nextIsCapital = false;

				} else {

					if (interruptors.indexOf(char) > -1) {
						nextIsCapital = true;
					} else {
						char = char.toLowerCase();
					}

				}

				retValue += char;
			}

			//return the formatted string
			return retValue;
		}
	}
}