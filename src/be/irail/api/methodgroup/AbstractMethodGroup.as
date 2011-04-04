package be.irail.api.methodgroup {

	import be.irail.api.event.IRailErrorEvent;

	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;

	/**
	 * Abstract method group class, contains shared methods in all methodgroups.
	 *<br/><br/>
	 * created 06/08/2010
	 * @author Joris Timmerman
	 */
	public class AbstractMethodGroup extends EventDispatcher {

		/**
		 * Catches IO error events when the server is unavailable
		 */
		protected function onIOError(event:IOErrorEvent):void {
			trace("[ERROR] IRail IO ERROR:", event.text)

			var evt:IRailErrorEvent = new IRailErrorEvent(IRailErrorEvent.IO_ERROR);
			evt.originalErrorEvent = event;
			dispatchEvent(evt);
		}

		/**
		 * Handles API error events
		 */
		protected function onAPIError(message:String):void {
			trace("[ERROR] IRail API ERROR:", message)

			var evt:IRailErrorEvent = new IRailErrorEvent(IRailErrorEvent.API_ERROR, false, false, message);
			dispatchEvent(evt);
		}

	}
}