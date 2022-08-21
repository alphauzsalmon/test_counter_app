import 'package:location/location.dart';
import 'package:test_counter/counter_and_weather/infrastructure/data_sources/location_data_provider.dart';

abstract class BaseLocationRepository {
  Future<LocationData?> getLocation();
}

class LocationRepository extends BaseLocationRepository {
  final LocationDataProvider _dataProvider;
  LocationRepository(this._dataProvider);
  @override
  Future<LocationData?> getLocation() async {
    final LocationData? locationData = await _dataProvider.getLocation();
    if (locationData != null) {
      return locationData;
    }
    throw Exception("Location Error");
  }
}
