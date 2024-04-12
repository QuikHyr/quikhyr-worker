part of 'notification_cubit.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

final class NotificationInitial extends NotificationState {}

final class NotificationSentLoading extends NotificationState {
  const NotificationSentLoading();
}

final class NotificationSentSuccess extends NotificationState {
  const NotificationSentSuccess();
}

final class NotificationSentError extends NotificationState {
  final String error;
  const NotificationSentError({required this.error});
}
