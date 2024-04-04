part of 'worker_bloc.dart';

@immutable
sealed class WorkerState {}
sealed class PincodeState extends WorkerState{}
final class WorkerInitial extends WorkerState {}

final class WorkerLoading extends WorkerState {}

final class WorkerLoaded extends WorkerState {
  final WorkerModel worker;

  WorkerLoaded({required this.worker});
}

final class WorkerError extends WorkerState {
  final String error;

  WorkerError({required this.error});
}

final class PincodeUpdatedSuccess extends PincodeState {}

final class PincodeUpdatedError extends PincodeState {
  final String error;

  PincodeUpdatedError({required this.error});
}

final class PincodeUpdating extends PincodeState {}

final class LocationUpdating extends WorkerState {}

final class LocationUpdatedSuccess extends WorkerState {}

final class LocationUpdatedError extends WorkerState {
  final String error;

  LocationUpdatedError({required this.error});
}
