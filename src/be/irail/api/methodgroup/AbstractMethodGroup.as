package be.irail.api.methodgroup {
	import be.irail.api.event.IRailErrorEvent;

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
			dispatchEvent(new IRailErrorEvent(IRailErrorEvent.IO_ERROR, event, true));
		}

	}
}