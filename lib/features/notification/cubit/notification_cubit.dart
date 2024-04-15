import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quikhyr_worker/features/notification/repository/notification_repo.dart';
import 'package:quikhyr_worker/models/notification_model.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo _notificationRepo;
  NotificationCubit(this._notificationRepo) : super(NotificationInitial());
  // void sendNotification(NotificationModel notification) async{
  //   emit(const NotificationSentLoading());
  //   final result = await _notificationRepo.createNotification(notification);
  //   result.fold(
  //     (error) => emit(NotificationSentError(error: error)),
  //     (success) => emit(const NotificationSentSuccess()),
  //   );
  // }
}
