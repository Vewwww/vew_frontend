import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/services/dio_helper.dart';

import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/notification.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  static NotificationCubit get(context) => BlocProvider.of(context);

  NotifivatoinResponse? notifivatoinResponse;
  bool haveNew = false;

  Future<void> getNotificatin() async {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    emit(GettingNotificationLoadingState());
    await DioHelper.getWithBody(
            url: "/driver/getNotifications/",
            query: {"toDay": date.toString().replaceAll("00:00:00.000", "")},
            token: SharedPreferencesHelper.getData(key: 'vewToken'))
        .then((value) {
      notifivatoinResponse = NotifivatoinResponse.fromJson(value.data);
      haveNew = notifivatoinResponse!.newNotifications!;
      emit(GettingNotificationSuccessState(
          notifivatoinResponse!.notifications!));
    }).catchError((err) {
      emit(GettingNotificationErrorState());
    });
  }
}
