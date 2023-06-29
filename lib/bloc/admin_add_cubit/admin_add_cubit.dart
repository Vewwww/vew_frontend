import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/driver.dart';
import '../../model/warning_sign.dart';
import '../../services/dio_helper.dart';

part 'admin_add_state.dart';

class AdminAddCubit extends Cubit<AdminAddState> {
  AdminAddCubit() : super(AdminAddInitial());
  static AdminAddCubit get(context) => BlocProvider.of(context);

  void addAdmin(Driver admin) async {
    emit(AddAdminLoadingState());
    await DioHelper.postData(
      url: "/admin/driver/",
      data: admin.toJson(),
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("Add admin response : ${value}");
      emit(AddAdminSuccessState());
    }).onError((error, stackTrace) {
      print("Add admin error : $error");
      emit(AddAdminErrorState());
    });
  }
   void addSign(Sign sign) async {
    emit(AddSignLoadingState());
    await DioHelper.postData(
      url: "/sign/",
      data: sign.toJson(),
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("Add sign response : ${value}");
      emit(AddSignSuccessState());
    }).onError((error, stackTrace) {
      print("Add sign error : $error");
      emit(AddSignErrorState());
    });
  }


}
