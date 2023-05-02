import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'select_color_state.dart';

class SelectColorCubit extends Cubit<SelectColorState> {
  SelectColorCubit() : super(SelectColorInitial());
  static SelectColorCubit get(context) => BlocProvider.of(context);
  int color = 0;

  void choseColor(int c) {
    color = c;
    emit(ColorChoiceSelected());
  }
}
