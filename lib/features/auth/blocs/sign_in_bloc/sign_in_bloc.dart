import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quikhyr_worker/features/auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:quikhyr_worker/features/auth/data/repository/firebase_user_repo.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationBloc _authenticationBloc;
	final FirebaseUserRepo _userRepository;
	
  SignInBloc({
    required AuthenticationBloc authenticationBloc,
		required FirebaseUserRepo userRepository
	}) : _userRepository = userRepository, _authenticationBloc = authenticationBloc,
		super(SignInInitial()) {
		on<SignInRequired>((event, emit) async {
			emit(SignInProcess());
      try {
        await _userRepository.signInWithEmailAndPassword(event.email, event.password);
				emit(SignInSuccess());
        _authenticationBloc.add(const AuthenticationCheckUserLoggedInEvent());

      } on FirebaseAuthException catch (e) {
				emit(SignInFailure(message: e.code));
			} catch (e) {
				emit(const SignInFailure());
      }
    });
  
		on<SignOutRequired>((event, emit) async {
			await _userRepository.logOut();
    });
  }
}