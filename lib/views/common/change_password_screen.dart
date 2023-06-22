import 'package:flutter/material.dart';
import 'package:vewww/core/components/backward_arrow.dart';
import 'package:vewww/core/components/custom_text_field.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/components/pop_up.dart';
import '../../core/utils/navigation.dart';
import '../driver/driver_home_screen.dart';


class ChangePasswordScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackwardArrow(function: () {
          NavigationUtils.navigateTo(
              context: context, destinationScreen: const DriverHomeScreen());
        }),
        title: const Center(
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
                CustomTextField(
                  controller: _oldPassword,
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  label: 'Old Password',
                ),
                const SizedBox(
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
                    if (_oldPassword.text == value) {
                      return 'New password cannot be the same as old password';
                    }
                    return null;
                  },
                  label: 'New Password',
                ),
                const SizedBox(
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
                const SizedBox(
                  height: 20,
                ),
                defaultButton(
                    text: 'Save',
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => popUp(context,
                              titleOFPopUp: 'Password Changed Successfully'),
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
