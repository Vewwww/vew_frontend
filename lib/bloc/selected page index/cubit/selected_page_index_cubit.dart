import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'selected_page_index_state.dart';

class SelectedPageIndexCubit extends Cubit<SelectedPageIndexState> {
  int? selectedIndex = 0;
  

  SelectedPageIndexCubit({this.selectedIndex = 0})
      : super(SelectedPageIndexInitial());
  static SelectedPageIndexCubit get(context) => BlocProvider.of(context);

  void changeIndex(int selected) {
    selectedIndex = selected;
    emit(SelectedPageIndexInChanged());
  }
}
