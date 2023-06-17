import 'package:flutter/material.dart';
import '../../core/components/backward_arrow.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/default_button.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';

class AddWarningSignScreen extends StatelessWidget {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var solutionController = TextEditingController();
  @override
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
              //pic
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
}
