import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quikhyr_worker/features/auth/data/repository/firebase_user_repo.dart';
import 'package:quikhyr_worker/models/worker_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  // final WorkerCubit workerCubit;
  final FirebaseUserRepo _workerRepository;

  SignUpBloc(
      {
      // required this.workerCubit,
      required FirebaseUserRepo userRepository})
      : _workerRepository = userRepository,
        super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      try {
        final workerModel = await _workerRepository.signUp(event.worker, event.password);
        emit(SignUpSuccessWithWorker(workerModel));
      } catch (e) {
        emit(SignUpFailure(e.toString()));
      }
    });
    on<RegistrationRequired>((event, emit) async {
      emit(RegistrationLoading());
      try {
        await _workerRepository.setUserData(event.worker);
        emit(RegistrationSuccess());

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isRegistered', true);
      } catch (e) {
        emit(RegistrationFailure(e.toString()));
      }
    });
  }
}
