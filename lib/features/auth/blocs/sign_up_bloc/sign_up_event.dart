part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequired extends SignUpEvent {
  final WorkerModel worker;
  final String password;

  const SignUpRequired({required this.worker, required this.password});
}


// class RegistrationRequired extends SignUpEvent {
//   final WorkerModel worker;

//   const RegistrationRequired({required this.worker});
// }

// class CheckRegistrationStatus extends SignUpEvent {}