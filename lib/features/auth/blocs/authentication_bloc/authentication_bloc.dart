import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quikhyr_worker/features/auth/data/repository/firebase_user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseUserRepo userRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthenticationBloc({required this.userRepository})
      : super(const AuthenticationState.unknown()) {
    _userSubscription = userRepository.user.listen((user) {
      add(AuthenticationUserChanged(user));
    });
  on<AuthenticationUserChanged>((event, emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isRegistered = prefs.getBool('isRegistered') ?? false;
    if (event.user != null && isRegistered) {
      emit(AuthenticationState.authenticated(event.user!));
    } else {
      emit(const AuthenticationState.unauthenticated());
    }
  });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
