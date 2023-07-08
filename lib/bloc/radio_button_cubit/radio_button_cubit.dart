import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vewww/views/admin/add_case_screen.dart';

part 'radio_button_state.dart';

class RadioButtonCubit extends Cubit<RadioButtonState> {
  RadioButtonCubit() : super(RadioButtonInitial());
  static RadioButtonCubit get(context) => BlocProvider.of(context);
  BooleanEnum maintenanceCenterchoice = BooleanEnum.no;
  bool mcChoice = false;

  BooleanEnum mechanicChoice = BooleanEnum.no;
  bool mChoice = false;

  BooleanEnum gasStationChoice = BooleanEnum.no;
  bool gsChoice = false;

  void mcChangeOption(BooleanEnum? newOption) {
    if (newOption != null) this.maintenanceCenterchoice = newOption;
    if (newOption == BooleanEnum.yes) {
      mcChoice = true;
    }
    emit(MaintenanceCenterChoiceChanged());
  }

  void mChangeOption(BooleanEnum? newOption) {
    if (newOption != null) this.mechanicChoice = newOption;
    if (newOption == BooleanEnum.yes) {
      mChoice = true;
    }
    emit(MechanicChoiceChanged());
  }

  void gsChangeOption(BooleanEnum? newOption) {
    if (newOption != null) this.gasStationChoice = newOption;
    if (newOption == BooleanEnum.yes) {
      gsChoice = true;
    }
    emit(GasStationChoiceChanged());
  }
}
