import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_counter/constants/texts.dart';
import 'package:test_counter/counter_and_weather/blocs/counter_bloc/counter_bloc.dart';
import 'package:test_counter/counter_and_weather/blocs/weather_bloc/weather_bloc.dart';

import '../../main.dart';

class CounterAndWeatherPage extends StatelessWidget {
  const CounterAndWeatherPage({Key? key, required this.mode}) : super(key: key);
  final Object mode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Weather"),
          centerTitle: true,
        ),
        body: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, weatherState) {
          if (weatherState is WeatherError) {
            Future.delayed(Duration.zero, () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(weatherState.message),
                ),
              );
            });
          }
          if (weatherState is WeatherCompleted) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Text(weatherState.weatherData),
                const Text(counterText),
                Text(
                  state.toString(),
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 200),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        FloatingActionButton(
                            onPressed: () {
                              BlocProvider.of<WeatherBloc>(context)
                                  .add(LoadWeatherData());
                            },
                            child: const Icon(Icons.cloud)),
                        FloatingActionButton(
                          onPressed: () => notifier.value = mode == ThemeMode.light
                              ? ThemeMode.dark
                              : ThemeMode.light,
                          child: const Icon(Icons.draw),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        state < 10
                            ? FloatingActionButton(
                            onPressed: () {
                              BlocProvider.of<CounterBloc>(context)
                                  .add(IncrementCounterValue());
                            },
                            child: const Icon(Icons.add))
                            : const SizedBox(height: 40,),
                        state > 0
                            ? FloatingActionButton(
                            onPressed: () {
                              BlocProvider.of<CounterBloc>(context)
                                  .add(DecrementCounterValue());
                            },
                            child: const Icon(Icons.minimize))
                            : const SizedBox(height: 40,)
                      ],
                    )
                  ],
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        }),
      );
    });
  }
}
