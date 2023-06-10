import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());
  static VerificationCubit get(context) => BlocProvider.of(context);
  String pinValue = '0000';
  int countDigits = 1;
  append(String digit, int index) {
    pinValue = _replaceCharAt(pinValue, index, digit);
    countDigits = countDigits + 1;
    print(pinValue);
    print(countDigits);
    emit(PinCodeAddSuccessfully());
  }

  String _replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }
}
