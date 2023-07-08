import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
part 'add_image_state.dart';

// Cubit to add image in the add warning sign screen for admin
class AddImageCubit extends Cubit<AddImageState> {
  AddImageCubit() : super(AddImageInitial());
  static AddImageCubit get(context) => BlocProvider.of(context);
  XFile? imageFile;

void addImage(pickedFile) {
    imageFile = pickedFile;
    emit(ImageAddedState());
}
}