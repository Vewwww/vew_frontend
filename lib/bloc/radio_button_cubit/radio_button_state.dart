part of 'radio_button_cubit.dart';

@immutable
abstract class RadioButtonState {}

class RadioButtonInitial extends RadioButtonState {}
class MaintenanceCenterChoiceChanged extends RadioButtonState {}
class MechanicChoiceChanged extends RadioButtonState {}
class GasStationChoiceChanged extends RadioButtonState {}