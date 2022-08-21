part of 'weather_bloc.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherCompleted extends WeatherState {
  WeatherCompleted(this.weatherData);
  final String weatherData;
}

class WeatherError extends WeatherState {
  WeatherError(this.message);
  final String message;
}