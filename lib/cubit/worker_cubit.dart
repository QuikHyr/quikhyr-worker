import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quikhyr_worker/models/location_model.dart';
import 'package:quikhyr_worker/models/worker_model.dart';

part 'worker_state.dart';

class WorkerCubit extends Cubit<WorkerState> {
  WorkerCubit() : super(WorkerInitial());

  void createWorker(String userId, String name, bool available, String avatar, String email, String gender, LocationModel location, String phone, String pincode, List<String> subservices) {
    final worker = WorkerModel(
      userId: userId,
      name: name,
      available: available,
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
}