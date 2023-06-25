import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vewww/model/services.dart';

import '../../services/dio_helper.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(ServicesInitial());
  static ServicesCubit get(context) => BlocProvider.of(context);
  ServiceResponse? serviceResponse;
  Future<void> getAllServices()async{
    emit(GetAllServicesLoadingState());
    await DioHelper.getData(url: "/service/").then((value) {
      print("get all services response : ${value.data}");
      serviceResponse = ServiceResponse.fromJson(value.data);
      //print("get all warning sign names : ${signResponse!.signs![0].name!.en}");
      emit(GetAllServicesSuccessState(services: serviceResponse!.service!));
    }).onError((error, stackTrace) {
      emit(GetAllServicesErrorState());
      print("gat all warning sign error : ${error}");
    });
  }
}
