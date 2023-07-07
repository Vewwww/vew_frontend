import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vewww/core/utils/sp_helper/cache_helper.dart';
import '../../model/warning_sign.dart';
import '../../services/dio_helper.dart';
part 'warning_sign_state.dart';

class WarningSignCubit extends Cubit<WarningSignState> {
  WarningSignCubit() : super(WarningSignInitial());
  static WarningSignCubit get(context) => BlocProvider.of(context);
  SignResponse? signResponse;
  Sign? sign;

  Future<void> getAllSigns() async {
    String role = SharedPreferencesHelper.getData(key: "vewRole");
    emit(GetAllWarningSignLoadingState());
    if (signResponse == null) {
      DioHelper.getData(
              url: (role == "user") ? "/driver/sign/" : "/admin/sign/",
              token: SharedPreferencesHelper.getData(key: "vewToken"))
          .then((value) {
        print("get all warning sign response : ${value.data}");
        signResponse = SignResponse.fromJson(value.data);
        emit(GetAllWarningSignSuccessState(signs: signResponse!.signs!));
      }).catchError((error) {
        if (error is DioError) {
          print(error.response);
        }
        emit(GetAllWarningSignErrorState());
      });
    } else {
      emit(GetAllWarningSignSuccessState(signs: signResponse!.signs!));
    }
  }

  Future<void> getSignWithId(String id) async {
    emit(GetSingleWarningSignLoadingState());
    await DioHelper.getData(url: "/driver/sign/${id}").then((value) {
      print("get all warning sign response : ${value.data}");
      sign = Sign.fromJson(value.data["data"]);
      print("get all warning sign names : ${sign!.name!.en}");
      emit(GetSingleWarningSignSuccessState(sign: sign!));
    }).onError((error, stackTrace) {
      emit(GetSingleWarningSignErrorState());
      print("gat all warning sign error : ${error}");
    });
  }
}
