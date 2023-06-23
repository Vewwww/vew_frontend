part of 'loaction_cubit.dart';

@immutable
abstract class LocationState {}

class LoactionInitial extends LocationState {}
class LoadingState extends LocationState {}
class DoneLoadingState extends LocationState {}
class LocationChangedState extends LocationState {}
