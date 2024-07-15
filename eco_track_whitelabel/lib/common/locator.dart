import 'package:domain/geo_locator.dart';
import 'package:domain/model/geolocation.dart';
import 'package:geolocator/geolocator.dart';

class Locator extends GeoLocator {
  @override
  Future<bool> isLocationServiceEnabled() =>
      Geolocator.isLocationServiceEnabled();

  @override
  Future<Geolocation> getLocation() async {
    final location = await Geolocator.getCurrentPosition().then(
          (position) => Geolocation(
        latitude: position.latitude,
        longitude: position.longitude,
      ),
    );
    return location;
  }
}