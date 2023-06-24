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
  Signs? sign;
  Future<void> getAllSigns()async{
    emit(GetAllWarningSignLoadingState());
    await DioHelper.getData(url: "/sign/").then((value) {
      //print("get all warning sign response : ${value.data}");
      signResponse = SignResponse.fromJson(value.data);
      //print("get all warning sign names : ${signResponse!.signs![0].name!.en}");
      emit(GetAllWarningSignSuccessState(signs:signResponse!.signs!));
    }).onError((error, stackTrace) {
      emit(GetAllWarningSignErrorState());
      print("gat all warning sign error : ${error}");
    });
  }

  Future<void> getSignWithId (String id) async{
    emit(GetSingleWarningSignLoadingState());
    await DioHelper.getData(url: "/sign/${id}").then((value) {
      print("get all warning sign response : ${value.data}");
      sign = Signs.fromJson(value.data["data"]);
      print("get all warning sign names : ${sign!.name!.en}");
      emit(GetSingleWarningSignSuccessState(sign: sign!));
    }).onError((error, stackTrace) {
      emit(GetSingleWarningSignErrorState());
      print("gat all warning sign error : ${error}");
    });
  }

}
