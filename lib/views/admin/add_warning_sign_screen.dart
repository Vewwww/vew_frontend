import 'package:flutter/material.dart';
import '../../core/components/backward_arrow.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/default_button.dart';

class AddWarningSignScreen extends StatelessWidget {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var solutionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: BackwardArrow(function: (){ Navigator.pop(context);}),
          title: const Center(
            child: Text(
              'Add Warning Sign',
              style: TextStyle(
                color: Color.fromRGBO(2, 113, 106, 1),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(2, 113, 106, 1),
                ),
                ),
                const SizedBox(height: 15,),
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
                  const Text(
                'Description',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(2, 113, 106, 1),
                ),
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
                  const Text(
                'Solution',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(2, 113, 106, 1),
                ),
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
                  defaultButton(function: (){}, text: 'ADD'),
            ],
          ),
        ));
  }
}
