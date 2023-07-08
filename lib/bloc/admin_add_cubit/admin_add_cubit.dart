import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/model/repairer.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/driver.dart';
import '../../model/sign_image.dart';
import '../../services/dio_helper.dart';
part 'admin_add_state.dart';

class AdminAddCubit extends Cubit<AdminAddState> {
  AdminAddCubit() : super(AdminAddInitial());
  static AdminAddCubit get(context) => BlocProvider.of(context);

  void addAdmin(Driver admin) async {
    emit(AddAdminLoadingState());
    await DioHelper.postData(
      url: "/admin/",
      data: admin.toJson(),
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      emit(AddAdminSuccessState());
    }).catchError((error) {
      if (error is DioError) {}
      emit(AddAdminErrorState());
    });
  }

  void addSign(SignImage sign) async {
    //Preparing data
    FormData formData = FormData.fromMap(
      {
        "name.en": sign.name!.en!,
        "description.en": sign.description!.en!,
        "solution.en": sign.solution!.en!,
        "image": await MultipartFile.fromFile(sign.path!,
            filename: "image", contentType: MediaType("image", "jpeg")),
      },
    );
    String token = SharedPreferencesHelper.getData(key: 'vewToken');
    DioHelper.dio.options.headers["Authorization"] = "Bearer $token";

    //start uploading
    emit(AddSignLoadingState());
    await DioHelper.dio
        .post(
      "/admin/sign/",
      data: formData,
    )
        .then((value) {
      emit(AddSignSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        emit(AddSignErrorState());
      }
    });
  }

  Future<void> addMaintenanceCenter(MaintenanceCenter maintenanceCenter) async {
    emit(AddGasStationLoadingState());
    await DioHelper.postData(
      url: "/admin/maintenanceCenter/",
      data: maintenanceCenter.toAddJson(),
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      emit(AddGasStationSuccessState());
    }).catchError((error) {
      if (error is DioError) {}
      emit(AddGasStationErrorState());
    });
  }

  void addGasStation(GasStation gasStation) async {
    emit(AddGasStationLoadingState());
    await DioHelper.postData(
      url: "/admin/gasStation",
      data: gasStation.toJson(),
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      emit(AddGasStationSuccessState());
    }).catchError((error) {
      if (error is DioError) {}
      emit(AddGasStationErrorState());
    });
  }
}
