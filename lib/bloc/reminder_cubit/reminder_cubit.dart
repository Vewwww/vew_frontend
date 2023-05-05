import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  ReminderCubit() : super(ReminderInitial());
  static ReminderCubit get(context) => BlocProvider.of(context);

  int reminder = -1;
  void choseTime(int c) {
    reminder = c;
    print("reminder: $reminder");
    emit(ReminderSelected());
  }
}
