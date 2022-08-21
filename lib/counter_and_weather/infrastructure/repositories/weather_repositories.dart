import 'package:test_counter/counter_and_weather/infrastructure/models/weather_model.dart';
import '../data_sources/weather_data_provider.dart';

abstract class BaseWeatherRepository {
  Future<WeatherModel> getWeatherData(
      {required final double lat, required final double long});
}

class WeatherRepository extends BaseWeatherRepository {
  final WeatherDataProvider _dataProvider;
  WeatherRepository(this._dataProvider);
  @override
  Future<WeatherModel> getWeatherData(
      {required final double lat, required final double long}) async {
    final response = await _dataProvider.getWeatherData(lat: lat, long: long);
    if (response.runtimeType == WeatherModel) {
      return response;
    }
    throw Exception(response);
  }
}
