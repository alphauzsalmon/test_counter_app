part of 'counter_bloc.dart';

abstract class CounterEvent {}

class IncrementCounterValue extends CounterEvent {}

class DoubleIncrementCounterValue extends CounterEvent {}

class DecrementCounterValue extends CounterEvent {}

class DoubleDecrementCounterValue extends CounterEvent {}