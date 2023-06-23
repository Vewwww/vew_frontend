part of 'select_choice_cubit.dart';

@immutable
abstract class SelectChoiceState {}

class SelectChoiceInitial extends SelectChoiceState {}

class ChoiceSelected extends SelectChoiceState {}

class GetAllCarTypesLoadingState extends SelectChoiceState {}

class GetAllCarTypesSuccessState extends SelectChoiceState {}

class GetAllCarTypesErrorState extends SelectChoiceState {}
