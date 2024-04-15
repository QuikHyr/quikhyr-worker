import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_booking_state.dart';

class ChatBookingCubit extends Cubit<ChatBookingState> {
  ChatBookingCubit() : super(ChatBookingInitial());
}
