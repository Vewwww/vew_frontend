part of 'nearest_repairer_cubit.dart';

@immutable
abstract class NearestRepairerState {}

class NearestRepairerInitial extends NearestRepairerState {}
class GettingNearestMCSuccessState extends NearestRepairerState {
  final List<MaintenanceCenter> maintenanceCenters ;
  GettingNearestMCSuccessState(this.maintenanceCenters);
}
class GettingNearestMCLoadingState extends NearestRepairerState {}
class GettingNearestMCErrorState extends NearestRepairerState {}
class GettingNearestGasStationSuccessState extends NearestRepairerState {
  final List<GasStation> gasStations ;
  GettingNearestGasStationSuccessState(this.gasStations);
}
class GettingNearestGasStationLoadingState extends NearestRepairerState {}
class GettingNearestGasStationErrorState extends NearestRepairerState {}
