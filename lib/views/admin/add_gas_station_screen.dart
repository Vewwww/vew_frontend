import 'package:flutter/material.dart';

import '../../core/components/backward_arrow.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/default_button.dart';

class AddGasStationScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var locationController = TextEditingController();

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
        title: Center(
          child: Text(
            'Add Gas Station',
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
            Text(
              'Name',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(2, 113, 106, 1),
              ),
            ),
            SizedBox(
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
            SizedBox(
              height: 15,
            ),
            defaultButton(function: () {}, text: 'ADD'),
          ],
        ),
      ),
    );
  }
}
