import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'onboarding_state.dart';

//Cubit to allow user navigate the onboading screens content  
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  static OnboardingCubit get(context) => BlocProvider.of(context);
  int pageIndex = 0;

  changeIndex(int newIndex) {
    pageIndex = newIndex;
    emit(PageChangedState());
  }


}
