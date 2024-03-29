import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../model/car_color.dart';
import '../../services/dio_helper.dart';
part 'select_color_state.dart';

class SelectColorCubit extends Cubit<SelectColorState> {
  SelectColorCubit() : super(SelectColorInitial());
  static SelectColorCubit get(context) => BlocProvider.of(context);
  int color = 0;
  CarColorResponse? carColorResponse;

  void choseColor(int c) {
    color = c;
    emit(ColorChoiceSelected());
  }

  Future<void> getcolors() async {
    await DioHelper.getData(url: "/color/").then((value) {
      emit(GettingColorsLoadingState());
      carColorResponse = CarColorResponse.fromJson(value.data);
      emit(GettingColorsSuccessState());
    }).onError((error, stackTrace) {
      emit(GettingColorsErrorState());
    });
  }
}
