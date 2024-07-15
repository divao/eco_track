import 'model/geolocation.dart';

abstract class GeoLocator {
  Future<Geolocation> getLocation();

  Future<bool> isLocationServiceEnabled();
}