package be.irail.api.core {

	/**
	 * General settings for the API and API queries
	 */
	public class IRailAPISettings {

		/**
		 * Language code, see <code>be.irail.api.core.LanguageCode</code> for values.
		 * This language code will be used to localize API results like stationlists
		 * To set a main language, use <code>IRailAPISettings.mainLanguage = LanguageCode.ENGLISH</code>
		 */
		public static var mainLanguage:String = LanguageCode.DEFAULT;
	}
}
