import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<IncrementCounterValue>((IncrementCounterValue event, Emitter<int> emit) {
      emit(state + 1);
    });

    on<DoubleIncrementCounterValue>((DoubleIncrementCounterValue event, Emitter<int> emit) {
      emit(state + 2);
    });

    on<DecrementCounterValue>((DecrementCounterValue event, Emitter<int> emit) {
      emit(state - 1);
    });

    on<DoubleDecrementCounterValue>((DoubleDecrementCounterValue event, Emitter<int> emit) {
      emit(state - 2);
    });
  }
}
