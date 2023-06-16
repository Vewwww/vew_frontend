import 'package:flutter/material.dart';
import 'package:vewww/bloc/auth_cubit/auth_cubit.dart';
import 'package:vewww/views/common/choose_role_screen.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';
import 'package:vewww/views/common/forgot_password_screen.dart';
import '../../bloc/add_car_cubit/add_car_cubit.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/logo.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';
import '../../model/driver.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double constraintsHight = MediaQuery.of(context).size.height;
    AddCarCubit addCarCubit = AddCarCubit.get(context);
    AuthCubit authCubit = AuthCubit.get(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: constraintsHight / 10),
                  Center(child: Logo()),
                  SizedBox(height: constraintsHight / 60),
                  Text(
                    "Login",
                    style: AppTextStyle.titleTextStyle(20),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 1.2,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: "Email",
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    controller: _password,
                    label: "Password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Driver driver = Driver(
                                email: _email.text, password: _password.text);
                            authCubit.signIn(driver);
                            // NavigationUtils.navigateAndClearStack(
                            //     context: context,
                            //     destinationScreen: DriverHomeScreen());
                          }
                        },
                        child: Text("Login"),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account?",
                        style: AppTextStyle.greyStyle(size: 16),
                      ),
                      TextButton(
                        child: Text("Sign Up",
                            style: AppTextStyle.titleTextStyle(14)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChooseRoleScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  TextButton(
                    child: Text("Forgot Password",
                        style: AppTextStyle.titleTextStyle(14)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Divider(
                        color: Color.fromARGB(255, 151, 151, 151),
                        thickness: 1,
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          "or continue with",
                          style: AppTextStyle.greyStyle(size: 12),
                        ),
                      ),
                      const Expanded(
                          child: Divider(
                        color: Color.fromARGB(255, 151, 151, 151),
                        thickness: 1,
                      )),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Image.asset("assets/images/google.png")),
                      InkWell(
                          onTap: () async {},
                          child: Image.asset("assets/images/Facebook.png")),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
