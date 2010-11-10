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
			var evt:IRailErrorEvent = new IRailErrorEvent(IRailErrorEvent.IO_ERROR, true);
			evt.originalErrorEvent = event;
			dispatchEvent(evt);
		}

		/**
		 * Handles API error events
		 */
		protected function onAPIError(message:String):void {
			var evt:IRailErrorEvent = new IRailErrorEvent(IRailErrorEvent.API_ERROR, true, false, message);
			dispatchEvent(evt);
		}



	}
}