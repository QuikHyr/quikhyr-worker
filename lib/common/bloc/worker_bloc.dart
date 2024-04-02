import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quikhyr_worker/common/data/repositories/worker_repo.dart';
import 'package:quikhyr_worker/features/auth/data/repository/firebase_user_repo.dart';
import 'package:quikhyr_worker/models/location_model.dart';
import 'package:quikhyr_worker/models/worker_model.dart';

part 'worker_state.dart';
part 'worker_event.dart';

class WorkerBloc extends Bloc<WorkerEvent, WorkerState>{
  final WorkerRepo workerRepository;
  final FirebaseUserRepo firebaseUserRepo;

  WorkerBloc({required this.workerRepository, required this.firebaseUserRepo})
      : super(WorkerInitial()) {
    on<FetchWorker>(_onFetchWorker);
    on<UpdatePincode>(_onUpdatePincode);
  }

  FutureOr<void> _onFetchWorker(
      FetchWorker event, Emitter<WorkerState> emit) async {
    final String workerId = await firebaseUserRepo.getCurrentUserId();
    final workerResult = await workerRepository.getWorker(workerId: workerId);
    workerResult.fold(
      (error) => emit(WorkerError(error: error)),
      (worker) => emit(WorkerLoaded(worker: worker)),
    );
  }

  FutureOr<void> _onUpdatePincode(
      UpdatePincode event, Emitter<WorkerState> emit) async {
    emit(PincodeUpdating());
    final String workerId = await firebaseUserRepo.getCurrentUserId();
    final workerResult = await workerRepository.updateWorkerPincode(
        workerId: workerId, pincode: event.newPincode);
    workerResult.fold(
      (error) => emit(PincodeUpdatedError(error: error)),
      (worker) => add(FetchWorker()),
    );
  }
}
