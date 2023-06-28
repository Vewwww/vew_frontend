part of 'select_choice_cubit.dart';

@immutable
abstract class SelectChoiceState {}

class SelectChoiceInitial extends SelectChoiceState {}

class CarTypeChoiceSelected extends SelectChoiceState {}
class CarModelChoiceSelected extends SelectChoiceState {}

class GetAllCarTypesLoadingState extends SelectChoiceState {}

class GetAllCarTypesSuccessState extends SelectChoiceState {}

class GetAllCarTypesErrorState extends SelectChoiceState {}
class GetAllCarModelsLoadingState extends SelectChoiceState {}

class GetAllCarModelsSuccessState extends SelectChoiceState {}

class GetAllCarModelsErrorState extends SelectChoiceState {}
