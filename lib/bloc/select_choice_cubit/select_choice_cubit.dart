import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'select_choice_state.dart';

class SelectChoiceCubit extends Cubit<SelectChoiceState> {
  SelectChoiceCubit() : super(SelectChoiceInitial());
  static SelectChoiceCubit get(context) => BlocProvider.of(context);
  int choice = 0;

  void chose(int c) {
    choice = c;
    emit(ChoiceSelected());
  }
}
