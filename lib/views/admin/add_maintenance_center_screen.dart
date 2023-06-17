import 'package:flutter/material.dart';
import 'package:vewww/core/components/custom_app_bar.dart';

import '../../core/components/backward_arrow.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/default_button.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';

class AddMaintenanceCenterScreen extends StatelessWidget {
  
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var longitudeController = TextEditingController();
  var latitudeController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> carTypes = [
    'BMW',
    'MG',
    'Toyota',
    'Honda',
    'Jeep',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackwardArrow(function: () {
          Navigator.pop(context);
        }),
        title: const Center(
          child: Text(
            'Add Maintenance Center',
            style: TextStyle(
              color: Color.fromRGBO(2, 113, 106, 1),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),*/
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  haveBackArrow: true,
                  title: Text(
                    "Add Maintenance Center",
                    style: AppTextStyle.mainStyle(size: 25),
                  ),
                ),
                CustomTextField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    label: 'Name'),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    label: 'Phone Number'),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    controller: addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    label: 'Address'),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    controller: longitudeController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    label: 'Longitude'),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    controller: latitudeController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    label: 'Latitude'),
                    //Add car type
                const SizedBox(height: 15),
                defaultButton(
                    function: () {
                      final form = formKey.currentState;
                                    if (form!.validate()) {
                                      // take data in a model here
                                    }
                    },
                    text: 'Add'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
