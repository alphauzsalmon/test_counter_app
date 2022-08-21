import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_counter/counter_and_weather/blocs/counter_bloc/counter_bloc.dart';
import 'package:test_counter/counter_and_weather/infrastructure/data_sources/location_data_provider.dart';
import 'package:test_counter/counter_and_weather/infrastructure/repositories/location_repositories.dart';
import 'package:test_counter/counter_and_weather/screens/counter_and_weather_page.dart';
import 'counter_and_weather/blocs/weather_bloc/weather_bloc.dart';
import 'counter_and_weather/infrastructure/data_sources/weather_data_provider.dart';
import 'counter_and_weather/infrastructure/repositories/weather_repositories.dart';

void main() {
  runApp(const MyApp());
}

final ValueNotifier<ThemeMode> notifier = ValueNotifier(ThemeMode.light);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(create: (ctx) => CounterBloc()),
        BlocProvider<WeatherBloc>(
          create: (ctx) => WeatherBloc(
              LocationRepository(LocationDataProvider()),
              WeatherRepository(WeatherDataProvider())),
        )
      ],
      child: ValueListenableBuilder(
        valueListenable: notifier,
        builder: (_,ThemeMode mode, __) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: mode,
          home: CounterAndWeatherPage(mode: mode),
        ),
      ),
    );
  }
}
