import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quikhyr_worker/models/location_model.dart';
import 'package:quikhyr_worker/models/worker_model.dart';

part 'worker_state.dart';

class WorkerCubit extends Cubit<WorkerState> {
  WorkerModel worker;
  WorkerCubit(this.worker) : super(WorkerInitial());

  void createWorker(
      DateTime dob,
      String userId,
      String name,
      String avatar,
      String email,
      String gender,
      LocationModel location,
      String phone,
      String pincode,
      List<String> subservices) {
    int calculateAge(DateTime dob) {
      final now = DateTime.now();
      int age = now.year - dob.year;
      if (now.month < dob.month ||
          (now.month == dob.month && now.day < dob.day)) {
        age--;
      }
      return age;
    }

    final worker = WorkerModel(
      userId: userId,
      name: name,
      age: calculateAge(dob),
      available: false,
      avatar: avatar,
      email: email,
      gender: gender,
      location: location,
      phone: phone,
      pincode: pincode,
      subservices: subservices,
    );
    emit(WorkerLoaded(worker: worker));
  }

  void updateLocation(LocationModel newLocation) {
    final updatedWorker = worker.copyWith(location: newLocation);
    emit(WorkerLoaded(worker: updatedWorker));
  }

  void updatePhone(String newPhone) {
    final updatedWorker = worker.copyWith(phone: newPhone);
    emit(WorkerLoaded(worker: updatedWorker));
  }
  
}
