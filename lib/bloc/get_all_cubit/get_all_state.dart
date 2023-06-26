part of 'get_all_cubit.dart';

abstract class GetAllState {}

class GetAllInitial extends GetAllState {}
class GetAllMechanicShopLoadingState extends GetAllState {}
class GetAllMechanicShopSuccessState extends GetAllState {
  final List<MechanicShop> mechanicShops;
  GetAllMechanicShopSuccessState(this.mechanicShops);
}
class GetAllMechanicShopErrorState extends GetAllState {}

class GetAllWinchDriversLoadingState extends GetAllState {}
class GetAllWinchDriversSuccessState extends GetAllState {
   final List<WinchDriver> winchDriver;
  GetAllWinchDriversSuccessState(this.winchDriver);
}
class GetAllWinchDriversErrorState extends GetAllState {}

class GetAllDriversLoadingState extends GetAllState {}
class GetAllDriversSuccessState extends GetAllState {
   final List<Driver> drivers;
  GetAllDriversSuccessState(this.drivers);
}
class GetAllDriversErrorState extends GetAllState {}

