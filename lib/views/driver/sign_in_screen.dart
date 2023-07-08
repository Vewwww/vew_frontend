import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/auth_cubit/auth_cubit.dart';
import 'package:vewww/bloc/language_cubit/language_cubit.dart';
import 'package:vewww/core/utils/sp_helper/cache_helper.dart';
import 'package:vewww/model/person.dart';
import 'package:vewww/views/admin/admin_home_screen.dart';
import 'package:vewww/views/common/choose_role_screen.dart';
import 'package:vewww/views/common/forgot_password_screen.dart';
import 'package:vewww/views/mechanic/mechanic_home_screen.dart';
import 'package:vewww/views/winch/winch_home_page.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/logo.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';
import 'driver_home_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double constraintsHight = MediaQuery.of(context).size.height;
    LanguageCubit languageCubit = LanguageCubit.get(context);
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
                  SizedBox(height: constraintsHight / 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: BlocConsumer<LanguageCubit, LanguageState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return Text(
                              languageCubit.languageInText,
                              style: AppTextStyle.mainStyle(),
                            );
                          },
                        ),
                        onPressed: () {
                          languageCubit.changeLanguage();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(child: Logo()),
                  SizedBox(height: constraintsHight / 60),
                  BlocConsumer<LanguageCubit, LanguageState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Text(
                        (languageCubit.currentLanguage == "en")
                            ? "Login"
                            : "تسجيل الدخول",
                        style: AppTextStyle.titleTextStyle(20),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 1.2,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  BlocConsumer<LanguageCubit, LanguageState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return CustomTextField(
                        label: languageCubit.currentLanguage == "ar"
                            ? "الايميل"
                            : "Email",
                        controller: _email,
                        isArabic: languageCubit.currentLanguage == "ar",
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  BlocConsumer<LanguageCubit, LanguageState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return CustomTextField(
                        controller: _password,
                        isArabic: languageCubit.currentLanguage == "ar",
                        label: languageCubit.currentLanguage == "ar"
                            ? "كلمة السر"
                            : "Password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Person person = Person(
                                  email: _email.text, password: _password.text);
                              await authCubit.signIn(person);
                              if (state is SignInSuccessState) {
                                String role = SharedPreferencesHelper.getData(
                                    key: "vewRole");
                                const snackBar = SnackBar(
                                    content: Text("Loged in successfully !"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Widget screen;
                                if (role == "user") {
                                  screen = const DriverHomeScreen();
                                } else if (role == "winch") {
                                  screen = WinchHomePage();
                                } else if (role == "admin") {
                                  screen = AdminHomeScreen();
                                } else {
                                  screen = MechanicHomeScreen();
                                }
                                NavigationUtils.navigateAndClearStack(
                                    context: context,
                                    destinationScreen: screen);
                              } else if (state is SignInErrorState) {
                                var snackBar = SnackBar(
                                    content: Text(state.errMessage ??
                                        "Something went wrong try again !"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                state.errMessage = null;
                              }
                            }
                          },
                          child: (authCubit.state is SignInLoadingState)
                              ? const CircularProgressIndicator()
                              : BlocConsumer<LanguageCubit, LanguageState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    return Text(
                                        (languageCubit.currentLanguage == "en")
                                            ? "Login"
                                            : "تسجيل الدخول");
                                  },
                                ),
                        );
                      })),
                  BlocConsumer<LanguageCubit, LanguageState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (languageCubit.currentLanguage == "en")
                                ? "Don't have account?"
                                : "لا تمتلك حساب؟",
                            style: AppTextStyle.greyStyle(size: 16),
                          ),
                          TextButton(
                            child: Text(
                                (languageCubit.currentLanguage == "en")
                                    ? "Sign Up"
                                    : "انشاء حساب",
                                style: AppTextStyle.titleTextStyle(14)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChooseRoleScreen()),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  TextButton(
                    child: BlocConsumer<LanguageCubit, LanguageState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Text(
                            (languageCubit.currentLanguage == "en")
                                ? "Forgot Password"
                                : "هل نسيت كلمة المرور؟",
                            style: AppTextStyle.titleTextStyle(14));
                      },
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
