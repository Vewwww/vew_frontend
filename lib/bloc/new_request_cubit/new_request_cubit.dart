import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'new_request_state.dart';

//Cubit to reload screen when having new requests
class NewRequestCubit extends Cubit<NewRequestState> {
  NewRequestCubit() : super(NewRequestInitial());
  static NewRequestCubit get(context) => BlocProvider.of(context);
  bool? hasNew = false;

  void setHaveNew(bool value) {
    hasNew = value;
    if (hasNew!) {
      emit(HasNewState());
    } else {
      emit(NoNewRequestsState());
    }
  }
}
