import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/views/driver/sign_up_screen.dart';
import 'package:vewww/views/mechanic/mechanic_signup.dart';
import 'package:vewww/views/winch/winch_sign_up_screen.dart';

import '../../bloc/language_cubit/language_cubit.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';

class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var constraintsHight = MediaQuery.of(context).size.height;
    LanguageCubit languageCubit = LanguageCubit.get(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
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
          SizedBox(height: 20),
          Center(child: Image.asset("assets/images/Logo(1).png")),
          SizedBox(height: constraintsHight / 60),

          //const SizedBox(height: 10),
          const Divider(
            thickness: 0,
            color: Colors.grey,
          ),
          const SizedBox(height: 10),

          BlocConsumer<LanguageCubit, LanguageState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children: [
                  Center(
                    child: Text(
                      (languageCubit.currentLanguage == "ar")
                          ? "اهلا بك فى vewww"
                          : "Welcome to Vewww",
                      textDirection: (languageCubit.currentLanguage == "ar")
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      style: AppTextStyle.mainStyle(size: 20),
                    ),
                  ),
                  card(
                      (languageCubit.currentLanguage == "ar")
                          ? "التسجيل كسائق"
                          : "Sign up as driver",
                      Icons.person,
                      SignUpScreen(),
                      context,
                      isArabic: (languageCubit.currentLanguage == "ar")),
                  card(
                      (languageCubit.currentLanguage == "ar")
                          ? "التسجيل كميكانيكى"
                          : "Sign up as mechanic",
                      Icons.handyman_rounded,
                      MechanicSignup(services: []),
                      context,
                      isArabic: (languageCubit.currentLanguage == "ar")),
                  card(
                      (languageCubit.currentLanguage == "ar")
                          ? "التسجيل كمالك ونش"
                          : "Sign up as winch",
                      Icons.car_repair,
                      WinchSignUpScreen(),
                      context,
                      isArabic: (languageCubit.currentLanguage == "ar")),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget card(String data, IconData icon, Widget screen, context,
      {required bool isArabic}) {
    return GestureDetector(
      onTap: () {
        NavigationUtils.navigateTo(context: context, destinationScreen: screen);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(2, 2),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(5, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment:
              isArabic ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Text(
              data,
              style: AppTextStyle.mainStyle(),
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            ),
            SizedBox(width: 20),
            Icon(
              icon,
              color: mainColor,
            ),
          ].reversed.map((e) => e).toList(),
        ),
      ),
    );
  }
}
