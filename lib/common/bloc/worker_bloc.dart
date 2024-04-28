import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quikhyr_worker/common/data/repositories/worker_repo.dart';
import 'package:quikhyr_worker/features/auth/data/repository/firebase_user_repo.dart';
import 'package:quikhyr_worker/models/location_model.dart';
import 'package:quikhyr_worker/models/worker_model.dart';

part 'worker_state.dart';
part 'worker_event.dart';

class WorkerBloc extends Bloc<WorkerEvent, WorkerState> {
  final WorkerRepo workerRepository;
  final FirebaseUserRepo firebaseUserRepo;
  StreamSubscription? _userSubscription;
  WorkerBloc({required this.workerRepository, required this.firebaseUserRepo})
      : super(WorkerInitial()) {
    on<FetchWorker>(_onFetchWorker);
    on<UpdatePincode>(_onUpdatePincode);
    on<ResetWorker>(_onResetWorker);
    on<UpdateLocation>(_onUpdateLocation);
    on<FetchInitiated>(_onFetchInitiated);
    on<UpdateAvailability>(_onUpdateAvailability);

    _userSubscription = firebaseUserRepo.user.listen((user) {
      if (user != null) {
        add(FetchWorker());
      }
    });
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

  FutureOr<void> _onResetWorker(ResetWorker event, Emitter<WorkerState> emit) {
    emit(WorkerInitial());
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  FutureOr<void> _onUpdateLocation(
      UpdateLocation event, Emitter<WorkerState> emit) async {
    emit(LocationUpdating());
    final String workerId = await firebaseUserRepo.getCurrentUserId();
    final result = await workerRepository.updateWorkerLocation(
        workerId: workerId, location: event.newLocation);
    result.fold((error) => emit(LocationUpdatedError(error: error)), (worker) {
      emit(LocationUpdatedSuccess());
      add(FetchWorker());
    });
  }

  FutureOr<void> _onFetchInitiated(
      FetchInitiated event, Emitter<WorkerState> emit) {
    emit(WorkerLoading());
  }

  FutureOr<void> _onUpdateAvailability(event, Emitter<WorkerState> emit) {
    final String workerId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('workers').doc(workerId).update({
      'available': event.newAvailability,
    }).then((value) {
      add(FetchWorker());
    }).catchError((error) {
      emit(WorkerError(error: error.toString()));
    });
    
  }
}
