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
  List<Service> selectedServices = [];
  List<Service>? services;

  void addService(Service service) {
    bool isSelected = false;
    for (Service s in selectedServices) {
      if (s.sId == service.sId) {
        isSelected = true;
      }
    }
    if (!isSelected) {
      selectedServices.add(service);
    } else {
      removeWithId(service.sId);
    }
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

  Future<void> getAllServices() async {
    emit(GetAllServicesLoadingState());
    await DioHelper.getData(url: "/service/").then((value) {
      serviceResponse = ServiceResponse.fromJson(value.data);
      services = serviceResponse!.service;
      emit(GetAllServicesSuccessState(services: serviceResponse!.service!));
    }).onError((error, stackTrace) {
      emit(GetAllServicesErrorState());
    });
  }
}
