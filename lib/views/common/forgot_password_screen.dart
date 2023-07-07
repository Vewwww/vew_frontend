// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/auth_cubit/auth_cubit.dart';
import 'package:vewww/core/components/backward_arrow.dart';
import 'package:vewww/core/components/custom_text_field.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/views/common/create_new_pass_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: backwardArrow(function: () {
          Navigator.pop(context);
        }),
        title: const Center(
          child: Text(
            'Forgot Password',
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
          child: Column(
            children: [
              Image.asset(
                'assets/images/password.png',
                height: 250,
                width: 250,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Please enter your email:",
                style: AppTextStyle.greyStyle(),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                validator: (v) {},
                label: "Email",
                controller: _email,
              ),
              Container(height: 100),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return defaultButton(
                      text: (state is SendingCodeLoadingState)
                          ? "Loading..."
                          : 'Continue',
                      function: () async {
                        if (_email.text.isNotEmpty) {
                          AuthCubit authCubit = AuthCubit.get(context);
                          await authCubit.sendResetPasswordCode(_email.text);
                          if (state is SendingCodeSuccessState) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateNewPassScreen(
                                        email: _email.text,
                                      )),
                            );
                          } else if (state is SendingCodeErrorState) {
                            var snackBar =
                                SnackBar(content: Text(state.errMessage));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } else {
                          var snackBar =
                              SnackBar(content: Text("Email is Required"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
