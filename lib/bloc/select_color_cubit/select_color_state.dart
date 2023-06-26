part of 'select_color_cubit.dart';

@immutable
abstract class SelectColorState {}

class SelectColorInitial extends SelectColorState {}

class ColorChoiceSelected extends SelectColorState {}
class GettingColorsLoadingState extends SelectColorState {}
class GettingColorsSuccessState extends SelectColorState {}
class GettingColorsErrorState extends SelectColorState {}
