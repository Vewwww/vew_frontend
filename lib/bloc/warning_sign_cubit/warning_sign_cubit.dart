import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../model/warning_sign.dart';
import '../../services/dio_helper.dart';

part 'warning_sign_state.dart';

class WarningSignCubit extends Cubit<WarningSignState> {
  WarningSignCubit() : super(WarningSignInitial());
  static WarningSignCubit get(context) => BlocProvider.of(context);
  SignResponse? signResponse;
  Future<void> getAllSigns()async{
    emit(GetAllWarningSignLoadingState());
    await DioHelper.getData(url: "/sign/").then((value) {
      print("get all warning sign response : ${value.data}");
      signResponse = SignResponse.fromJson(value.data);
      print("get all warning sign names : ${signResponse!.name}");
      emit(GetAllWarningSignSuccessState());
    }).onError((error, stackTrace) {
      emit(GetAllWarningSignErrorState());
      print("gat all warning sign error : ${error}");
    });
  }

}
