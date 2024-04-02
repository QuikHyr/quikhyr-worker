part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();
  
  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  const SignUpSuccess();
  
  @override
  List<Object> get props => [];

}
class SignUpFailure extends SignUpState {
  final String message;
  const SignUpFailure(this.message);
  
  @override
  List<Object> get props => [message];
}
class SignUpProcess extends SignUpState {}

// final class RegistrationLoading extends SignUpState {}

// class RegistrationSuccess extends SignUpState {}

// class RegistrationFailure extends SignUpState {
//   final String message;
//   const RegistrationFailure(this.message);
  
//   @override
//   List<Object> get props => [message];
// }