import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vewww/model/services.dart';

import '../../services/dio_helper.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  List<Service> selectedServices = [];
  List<Service>? services;

  void addService(Service service) {
    bool isSelected = false;
    for (Service s in selectedServices) {
      if (s.sId == service.sId) {
        isSelected = true;
        print("11-${s.toJson()} ,\n22- ${service.toJson()}");
      }
    }
    if (!isSelected) {
      selectedServices.add(service);
      print("service addeddd");
    } else {
      print("service removed");
      removeWithId(service.sId);
    }
    print("service handeled");
    emit(ServiceAddedState());
  }

  removeWithId(id) {
    int index = 0;
    for (Service s in selectedServices) {
      if (id == s.sId) {
        break;
      }
      index++;
    }
    selectedServices.removeAt(index);
    emit(ServiceRemovedState());
  }

  ServicesCubit() : super(ServicesInitial());
  static ServicesCubit get(context) => BlocProvider.of(context);
  ServiceResponse? serviceResponse;
  Future<void> getAllServices() async {
    print(selectedServices.length);
    emit(GetAllServicesLoadingState());
    await DioHelper.getData(url: "/service/").then((value) {
      print("get all services response : ${value.data}");
      serviceResponse = ServiceResponse.fromJson(value.data);
      services = serviceResponse!.service;
      //print("get all warning sign names : ${signResponse!.signs![0].name!.en}");
      emit(GetAllServicesSuccessState(services: serviceResponse!.service!));
    }).onError((error, stackTrace) {
      emit(GetAllServicesErrorState());
      print("gat all warning sign error : ${error}");
    });
  }
}
