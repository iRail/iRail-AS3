
package be.irail.api.methodgroup {
	import be.irail.api.core.IRServiceURL;
	import be.irail.api.data.scheduler.IRVehicle;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	/**
	 * Contains methods to retreive Vehicule information
	 *<br/><br/>
	 * created 19/09/2010
	 * @author Joris Timmerman
	 */
	public class Vehicles extends AbstractMethodGroup {

		/**
		 * Retreive information about a certain vehicule.
		 * @param vehicule Specific vehicule to get info from.
		 */
		public function getVehicleInformation(vehicule:IRVehicle):void {
			var serviceURL:String = IRServiceURL.VEHICULE_URL,
				loader:URLLoader = new URLLoader(),
				request:URLRequest = new URLRequest(serviceURL),
				vars:URLVariables = new URLVariables();

			var vehCode:String = vehicule.vehicleCode.split(".").join("");
			vars.id = vehCode;

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
			}
		}

	}
}