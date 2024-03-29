import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/components/backward_arrow.dart';
import 'package:vewww/core/components/custom_text_field.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/utils/sp_helper/cache_helper.dart';
import 'package:vewww/views/driver/sign_in_screen.dart';
import 'package:vewww/views/mechanic/mechanic_home_screen.dart';
import 'package:vewww/views/winch/winch_home_page.dart';
import '../../bloc/auth_cubit/auth_cubit.dart';
import '../../core/utils/navigation.dart';
import '../driver/driver_home_screen.dart';

class ChangePasswordScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _newPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: backwardArrow(function: () {
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
                      return 'Password should Contain: \nAt least 8 chatacters\nAt least an uppercase latter \nAt least a lowercase latter \nAt least one number \nAt least one special character(!@#\$&*~)';
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
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return defaultButton(
                        text: 'Save',
                        function: () async {
                          if (_formKey.currentState!.validate()) {
                            AuthCubit authCubit = AuthCubit.get(context);
                            await authCubit.changePassword(_newPassword.text);
                            print(state);
                            if (state is ChangePasswordSuccessState) {
                              var snackBar = const SnackBar(
                                  content:
                                      Text('Password Changed Successfully'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              var role = SharedPreferencesHelper.getData(
                                  key: "vewRole");
                              Widget destinationScreen;
                              if (role == "winch") {
                                destinationScreen = WinchHomePage();
                              } else if (role == "user") {
                                destinationScreen = const DriverHomeScreen();
                              } else if (role == "mechanic") {
                                destinationScreen = MechanicHomeScreen();
                              } else {
                                destinationScreen = SignInScreen();
                              }
                              NavigationUtils.navigateTo(
                                  context: context,
                                  destinationScreen: destinationScreen);
                            } else if (state is ChangePasswordErrorState) {
                              var snackBar =
                                  SnackBar(content: Text(state.errMessage));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
