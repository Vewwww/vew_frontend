import 'package:flutter/material.dart';

import '../../core/components/backward_arrow.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/default_button.dart';

class AddMaintenanceCenterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var locationController = TextEditingController();
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
      appBar: AppBar(
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(2, 113, 106, 1),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '*Required';
                }
                return null;
              },
              label: 'Name',
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(2, 113, 106, 1),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              controller: phoneController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '*Required';
                }
                return null;
              },
              label: 'Phone Number',
            ),
            const SizedBox(height: 15),
            defaultButton(function: () {}, text: 'ADD'),
          ],
        ),
      ),
    );
  }
}
