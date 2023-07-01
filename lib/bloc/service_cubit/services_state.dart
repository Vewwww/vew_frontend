part of 'services_cubit.dart';

@immutable
abstract class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServiceAddedState extends ServicesState {}

class ServiceRemovedState extends ServicesState {}

class GetAllServicesLoadingState extends ServicesState {}

class GetAllServicesSuccessState extends ServicesState {
  final List<Service> services;
  GetAllServicesSuccessState({required this.services});
}

class GetAllServicesErrorState extends ServicesState {}
