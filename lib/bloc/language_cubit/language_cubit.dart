import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());
  static LanguageCubit get(context) => BlocProvider.of(context);

  String languageInText = "عربى";
  String currentLanguage = "en";

  void changeLanguage() {
    if (currentLanguage == "en") {
      languageInText = "English";
      currentLanguage = "ar";
    } else {
      languageInText = "عربى";
      currentLanguage = "en";
    }
    emit(LanguageChangedState());
  }
}
