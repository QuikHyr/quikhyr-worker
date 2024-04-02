
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quikhyr_worker/features/auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:quikhyr_worker/features/auth/data/repository/firebase_user_repo.dart';
import 'package:quikhyr_worker/models/worker_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState>{
  final AuthenticationBloc _authenticationBloc;
  final FirebaseUserRepo _workerRepository;

  SignUpBloc(
      {
        required AuthenticationBloc authenticationBloc,
      required FirebaseUserRepo userRepository})
      : _workerRepository = userRepository, _authenticationBloc = authenticationBloc,
        super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      try {
        final workerModel =
            await _workerRepository.signUp(event.worker, event.password);
        emit(SignUpSuccessWithWorker(workerModel));
      } catch (e) {
        emit(SignUpFailure(e.toString()));
      }
    });
    on<RegistrationRequired>((event, emit) async {
      emit(RegistrationLoading());
      try {
        await _workerRepository.setUserData(event.worker);
        debugPrint("SignUpBloc hashCode in sign_up_bloc.dart: $hashCode");
        emit(RegistrationSuccess());

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isRegistered${event.worker.id}', true);
        debugPrint(prefs.getBool('isRegistered${event.worker.id}').toString());
        _authenticationBloc.add(const AuthenticationCheckUserLoggedInEvent());
      } catch (e) {
        emit(RegistrationFailure(e.toString()));
      }
    });

    // on<CheckRegistrationStatus>((event, emit) async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   bool registrationSuccess = prefs.getBool('isRegistered') ?? false;
    //   if (registrationSuccess) {
    //     emit(RegistrationSuccess());
    //   } else {
    //     emit(const RegistrationFailure('Not registered'));
    //   }
    // });

    // add(CheckRegistrationStatus());
  }
}
