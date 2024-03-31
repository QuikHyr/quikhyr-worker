import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'registration_state.dart';
//!?REMOVE THIS IF NOT NEEDED
class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());
  void register() {
    emit(RegistrationLoading());
    try {
      // Register user
      emit(RegistrationSuccess());
    } catch (e) {
      emit(RegistrationFailure(e.toString()));
    }
  }
}
