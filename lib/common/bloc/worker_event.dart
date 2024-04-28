part of 'worker_bloc.dart';

@immutable
sealed class WorkerEvent {}

class UpdateLocation extends WorkerEvent {
  final LocationModel newLocation;
  UpdateLocation(this.newLocation);
}

class UpdatePhone extends WorkerEvent {
  final String newPhone;
  UpdatePhone(this.newPhone);
}

class UpdatePincode extends WorkerEvent {
  final String newPincode;
  UpdatePincode(this.newPincode);
}

class AddWorker extends WorkerEvent {
  final WorkerModel worker;
  AddWorker(this.worker);
}

class UpdateAvailability extends WorkerEvent {
  final bool newAvailability;
  UpdateAvailability(this.newAvailability);
}

class FetchWorker extends WorkerEvent {}

class FetchInitiated extends WorkerEvent {}

class ResetWorker extends WorkerEvent {}
