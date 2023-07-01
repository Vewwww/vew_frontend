part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class GettingProfileLoadingState extends ProfileState {}
class GettingProfileSuccessState extends ProfileState {}
class GettingProfileErrorState extends ProfileState {}
