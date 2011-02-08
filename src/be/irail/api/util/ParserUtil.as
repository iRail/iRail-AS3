package be.irail.api.util {

	import be.irail.api.data.stations.IRStation;
	import be.irail.api.data.vehicle.IRVehicle;

	public class ParserUtil {

		public static function parseStationXML(xml:*):IRStation {
			var data:XML;

			if (xml is XML) {
				data = xml as XML;
			} else if (xml is XMLList) {
				data = XML(xml.toXMLString());
			} else {
				throw new Error("Invalid xml input");
			}

			var irailStation:IRStation = new IRStation(data.text().toString()),
				xCoordValid:Boolean = StringUtils.trim(data.@locationX).length > 0 && !isNaN(Number(data.@locationX)),
				yCoordValid:Boolean = StringUtils.trim(data.@locationY).length > 0 && !isNaN(Number(data.@locationY));

			irailStation.id = data.@id;

			irailStation.hasLocation = false;
			if (xCoordValid && yCoordValid) {
				irailStation.hasLocation = true;
				irailStation.longitude = Number(data.@locationX);
				irailStation.latitude = Number(data.@locationY);
			}

			return irailStation;
		}

		public static function parseVehicle(xml:*):IRVehicle {
			var data:XML;

			if (xml is XML) {
				data = xml as XML;
			} else if (xml is XMLList) {
				data = XML(xml.toXMLString());
			} else {
				throw new Error("Invalid xml input");
			}

			var vehicle:IRVehicle = new IRVehicle(data.text().toString());
			if ("@locationX" in data) {
				vehicle.longitude = data.@locationX;
			}
			if ("@locationY" in data) {
				vehicle.latitude = data.@locationY;
			}

			return vehicle;
		}

	}
}