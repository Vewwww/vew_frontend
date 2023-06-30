import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/add_image_cubit/add_image_cubit.dart';
import 'package:vewww/bloc/admin_add_cubit/admin_add_cubit.dart';
import 'package:vewww/model/mechanic_shop.dart';
import 'package:vewww/model/name.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/default_button.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/style/app_colors.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/warning_sign.dart';

class AddWarningSignScreen extends StatefulWidget {
  @override
  State<AddWarningSignScreen> createState() => _AddWarningSignScreenState();
}

class _AddWarningSignScreenState extends State<AddWarningSignScreen> {
  String? imagePath;
  Name description = Name();
  Name solution = Name();
  Name title = Name();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var solutionController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AddImageCubit addImageCubit = AddImageCubit.get(context);
    AdminAddCubit adminAddCubit = AdminAddCubit.get(context);
    Sign sign;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
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
                  defaultButton(
                      function: () {
                        final form = formKey.currentState;
                        print("from add button $imagePath");
                        if (form!.validate()) {
                          description = Name(en: descriptionController.text);
                          solution = Name(en: solutionController.text);
                          title = Name(en: titleController.text);
                          print("from add button2 $imagePath");
                          sign = Sign(
                              description: description,
                              name: title,
                              solution: solution,
                              image: imagePath);
                          adminAddCubit.addSign(sign);
                          if (adminAddCubit.state is AddSignSuccessState) {
                            const snackBar = SnackBar(
                                content: Text("Sign add successfully"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (adminAddCubit.state is AddSignErrorState) {
                            const snackBar = SnackBar(
                                content:
                                    Text("Something went wrong try again !"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      },
                      text: 'Add'),
                ],
              ),
            ),
          ),
        ));
  }

  Future<String> takePhoto(AddImageCubit addImageCubit) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    addImageCubit.addImage(pickedFile);
    print("image from take photo : $imagePath");
    print("image from take photo : ${addImageCubit.imageFile!.path}");
    return addImageCubit.imageFile!.path;
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
                    ? const AssetImage('assets/images/addImage.jpeg')
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
              onTap: () async {
                imagePath = await takePhoto(addImageCubit);
                print("from icon botton  $imagePath");
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