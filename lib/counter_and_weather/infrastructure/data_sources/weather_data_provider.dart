import 'package:dio/dio.dart';
import 'package:test_counter/constants/api_key.dart';
import 'package:test_counter/counter_and_weather/infrastructure/repositories/weather_repositories.dart';
import '../models/weather_model.dart';

class WeatherDataProvider {
  WeatherDataProvider();

  Future<dynamic> getWeatherData(
      {required final double lat, required final double long}) async {
    final Dio dio = Dio();
    final Response response = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey');
    switch (response.statusCode) {
      case 200:
        return WeatherModel.fromJson(response.data);
      default:
        return response.statusCode;
    }
  }
}
