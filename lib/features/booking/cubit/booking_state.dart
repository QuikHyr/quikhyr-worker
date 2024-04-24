part of 'booking_cubit.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

final class BookingLoading extends BookingState {}

final class BookingLoaded extends BookingState {
  final BookingData booking;

  BookingLoaded(this.booking);
}

final class BookingError extends BookingState {
  final String message;

  BookingError(this.message);
}
