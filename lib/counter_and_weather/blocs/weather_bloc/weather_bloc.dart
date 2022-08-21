import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:test_counter/constants/texts.dart';
import 'package:test_counter/counter_and_weather/infrastructure/models/weather_model.dart';
import 'package:test_counter/counter_and_weather/infrastructure/repositories/location_repositories.dart';
import 'package:test_counter/counter_and_weather/infrastructure/repositories/weather_repositories.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final BaseLocationRepository _locationRepository;
  final BaseWeatherRepository _weatherRepository;
  WeatherBloc(this._locationRepository, this._weatherRepository)
      : super(WeatherCompleted(beforeWeatherData)) {
    on<LoadWeatherData>(
        (LoadWeatherData event, Emitter<WeatherState> emit) async {
      emit(WeatherInitial());
      try {
        final LocationData? locationData =
            await _locationRepository.getLocation();
        final WeatherModel weatherModel =
            await _weatherRepository.getWeatherData(
                lat: locationData!.latitude!, long: locationData.longitude!);
        emit(WeatherCompleted(
            "Weather for ${weatherModel.name}: ${weatherModel.main!.temp!.toStringAsFixed(0)}°C"));
      } catch (err) {
        emit(WeatherError(err.toString()));
      }
    });
  }
}
