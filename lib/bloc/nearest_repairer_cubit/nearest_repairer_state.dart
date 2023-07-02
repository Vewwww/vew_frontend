part of 'nearest_repairer_cubit.dart';

@immutable
abstract class NearestRepairerState {}

class NearestRepairerInitial extends NearestRepairerState {}

class GettingNearestMCSuccessState extends NearestRepairerState {
  final List<MaintenanceCenter> maintenanceCenters;
  GettingNearestMCSuccessState(this.maintenanceCenters);
}

class GettingNearestMCLoadingState extends NearestRepairerState {}

class GettingNearestMCErrorState extends NearestRepairerState {}

class GettingNearestGasStationSuccessState extends NearestRepairerState {
  final List<GasStation> gasStations;
  GettingNearestGasStationSuccessState(this.gasStations);
}

class GettingNearestGasStationLoadingState extends NearestRepairerState {}

class GettingNearestGasStationErrorState extends NearestRepairerState {}

class GettingNearestMechanicLoadingState extends NearestRepairerState {}

class GettingNearestMechanicSuccessState extends NearestRepairerState {
  final List<Mechanic> mechanics;
  GettingNearestMechanicSuccessState({required this.mechanics});
}
class GettingNearestMechanicErrorState extends NearestRepairerState {}

class GettingNearestWinchLoadingState extends NearestRepairerState {}
class GettingNearestWinchSuccessState extends NearestRepairerState {
  final List<NearestWinch> nearestWinch;
  GettingNearestWinchSuccessState({required this.nearestWinch});
}

class GettingNearestWinchErrorState extends NearestRepairerState {}


class GettingNearestLoadingState extends NearestRepairerState {}

class GettingNearestSuccessState extends NearestRepairerState {
  final List<Place> places;
  GettingNearestSuccessState({required this.places});
}

class GettingNearestErrorState extends NearestRepairerState {}

class SearchLoadingState extends NearestRepairerState {}

class SearchSuccessState extends NearestRepairerState {
  final List<Place> places;
  SearchSuccessState({required this.places});
}

class SearchErrorState extends NearestRepairerState {}
