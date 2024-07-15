import 'package:domain/geo_locator.dart';
import 'package:domain/model/geolocation.dart';
import 'package:domain/use_case/use_case.dart';

class GetLocationUC extends UseCase<NoParams, Geolocation> {
  GetLocationUC({
    required GeoLocator geoLocator,
    required super.logger,
  }) : _geoLocator = geoLocator;

  final GeoLocator _geoLocator;

  @override
  Future<Geolocation> getRawFuture(NoParams params) =>
      _geoLocator.getLocation();
}
