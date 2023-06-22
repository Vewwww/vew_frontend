import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/add_image_cubit/add_image_cubit.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/default_button.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/style/app_colors.dart';
import 'package:image_picker/image_picker.dart';

class AddWarningSignScreen extends StatefulWidget {
  @override
  State<AddWarningSignScreen> createState() => _AddWarningSignScreenState();
}

class _AddWarningSignScreenState extends State<AddWarningSignScreen> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  var solutionController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  Widget build(BuildContext context) {
    AddImageCubit addImageCubit = AddImageCubit.get(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  haveBackArrow: true,
                  title: Text(
                    "Add Warning Sign",
                    style: AppTextStyle.mainStyle(size: 25),
                  ),
                ),
                addImage(addImageCubit),
                CustomTextField(
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                  label: 'Title',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                  label: 'Description',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  controller: solutionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                  label: 'Solution',
                ),
                const SizedBox(
                  height: 15,
                ),
                defaultButton(function: () {}, text: 'Add'),
              ],
            ),
          ),
        ));
  }

  void takePhoto(AddImageCubit addImageCubit) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    addImageCubit.addImage(pickedFile);
  }

  Widget addImage(AddImageCubit addImageCubit) {
    return Center(
      child: Stack(
        children: [
          BlocConsumer<AddImageCubit, AddImageState>(
            listener: (context, state) {},
            builder: (context, state) {
              return CircleAvatar(
                radius: 80,
                backgroundImage: (addImageCubit.imageFile == null)
                    ? const AssetImage('assets/images/addImage.png')
                    : FileImage(File(addImageCubit.imageFile!.path))
                        as ImageProvider,
                backgroundColor: Colors.white,
              );
            },
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                takePhoto(addImageCubit);
              },
              child: Icon(
                Icons.add_a_photo,
                color: mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
