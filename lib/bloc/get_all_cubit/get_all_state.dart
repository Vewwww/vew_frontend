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

class GetAllAdminsLoadingState extends GetAllState {}
class GetAllAdminsSuccessState extends GetAllState {
   final List<Driver> admins;
  GetAllAdminsSuccessState(this.admins);
}
class GetAllAdminsErrorState extends GetAllState {}


class GetUserWithIdLoadingState extends GetAllState {}
class GetDriverWithIdSuccessState extends GetAllState {
   final Driver driver;
  GetDriverWithIdSuccessState(this.driver);
}
class GetMechanicWithIdSuccessState extends GetAllState {
   final MechanicShop mechanicShop;
  GetMechanicWithIdSuccessState(this.mechanicShop);
}
class GetWinchWithIdSuccessState extends GetAllState {
   final WinchDriver winchDriver;
  GetWinchWithIdSuccessState(this.winchDriver);
}
class GetUserWithIdErrorState extends GetAllState {}