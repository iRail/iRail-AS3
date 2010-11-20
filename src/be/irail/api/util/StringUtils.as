package be.irail.api.util {

	public class StringUtils {

		public static function trim(str:String):String {
			if (str == null) {
				return null;
			}
			return str.replace(/^\s*/, '').replace(/\s*$/, '');
		}


	}
}