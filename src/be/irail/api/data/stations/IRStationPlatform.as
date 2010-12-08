package be.irail.api.data.stations {

	/**
	 * Platform data
	 * RemoteClass alias: irail.IRStationPlatform
	 * @author Joris Timmerman
	 */
	[RemoteClass(alias="irail.IRStationPlatform")]
	public class IRStationPlatform {
		// ----------------------------
		// platform
		// ----------------------------

		private var _platform:int;

		public function get platformNo():int {
			return _platform;
		}

		public function set platformNo(value:int):void {
			if (value != _platform) {
				_platform = value;
			}
		}
		// ----------------------------
		// isNormal
		// ----------------------------

		private var _isNormal:Boolean = true;

		public function get isNormal():Boolean {
			return _isNormal;
		}

		public function set isNormal(value:Boolean):void {
			if (value !== _isNormal) {
				_isNormal = value;
			}
		}

		public function IRStationPlatform(platform:int = -1, isNormal:Boolean = true) {
			this.platformNo = platform;
			this.isNormal = isNormal;
		}
	}
}