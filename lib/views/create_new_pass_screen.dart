import 'package:flutter/material.dart';

import '../core/components/backward_arrow.dart';
import '../core/components/custom_text_field.dart';
import '../core/components/default_button.dart';
import '../core/components/pop_up.dart';

class CreateNewPassScreen extends StatelessWidget {
   final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _newPassword = TextEditingController();

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
            'Change Password',
            style: TextStyle(
              color: Color.fromRGBO(2, 113, 106, 1),
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/newPassword.png',
                  height: 250,
                  width: 250,
                ),
                
                SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  controller: _newPassword,
                  validator: (value) {
                    RegExp regex = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])');
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (!regex.hasMatch(value)) {
                      return 'Password should Contain: \nAt least 8 chatacters\nAt least an uppercase latter  \nAt least a lowercase latter   \nAt least one number \nAt least one special character';
                    }
                    return null;
                  },
                  label: 'New Password',
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please re-enter the password ';
                    } else if (value != _newPassword.text) {
                      return 'Doesn\'t match the new password ';
                    }
                    return null;
                  },
                  label: 'Confirm Password',
                ),
                SizedBox(
                  height: 20,
                ),
                defaultButton(
                    text: 'Continue',
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              popUp(context, titleOFPopUp: 'New password created Successfully'),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}