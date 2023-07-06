part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class GettingProfileLoadingState extends ProfileState {}

class GettingProfileSuccessState extends ProfileState {}

class GettingProfileErrorState extends ProfileState {}

class EdittingProfileLoadingState extends ProfileState {}

class EdittingProfileSuccessState extends ProfileState {}

class EdittingProfileErrorState extends ProfileState {}

class WinchAvailabityLoadingState extends ProfileState {}

class WinchAvailabitySuccessState extends ProfileState {}

class WinchAvailabityErrorState extends ProfileState {}
