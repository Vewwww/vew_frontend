import 'dart:io';
import 'package:flutter/material.dart';
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

  XFile? imageFile;
  final ImagePicker picker = ImagePicker();

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 CustomAppBar(haveBackArrow: true,title: Text(
                "Add Warning Sign",
                style: AppTextStyle.mainStyle(size: 25),
              ),),
              addImage(),
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
                    const SizedBox(height: 15,),
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
                    const SizedBox(height: 15,),
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
                    const SizedBox(height: 15,),
                    defaultButton(function: (){}, text: 'Add'),
              ],
            ),
          ),
        ));
  }

  void takePhoto() async{
     final pickedFile = await picker.pickImage(source: ImageSource.gallery,);
    setState(() {
      imageFile = pickedFile;
    });
  }

Widget addImage(){
  return Center(
    child: Stack(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: /*(imageFile == null) ?*/ const AssetImage('assets/images/addImage.png')/*: FileImage(File(imageFile!.path))*/ ,
          backgroundColor: Colors.white,
        ),
         Positioned(
            bottom: 20,
            right: 20, 
            child: InkWell(
              onTap: (){
                takePhoto();
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