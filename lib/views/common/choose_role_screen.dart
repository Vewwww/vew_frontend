import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/views/driver/sign_up_screen.dart';
import 'package:vewww/views/mechanic/mechanic_signup.dart';
import 'package:vewww/views/winch/winch_sign_up_screen.dart';

import '../../core/style/app_Text_Style/app_text_style.dart';

class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var constraintsHight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: constraintsHight / 10),
          Center(child: Image.asset("assets/images/Logo(1).png")),
          SizedBox(height: constraintsHight / 60),

          //const SizedBox(height: 10),
          const Divider(
            thickness: 0,
            color: Colors.grey,
          ),
          const SizedBox(height: 10),
          Center(
              child: Text(
            "اهلا بك فى vewww",
            textDirection: TextDirection.rtl,
            style: AppTextStyle.mainStyle(size: 20),
          )),
          card("التسجيل كسائق", Icons.person, SignUpScreen(), context),
          card("التسجيل كميكانيكى", Icons.handyman_rounded, MechanicSignup(services: []),
              context),
          card("التسجيل كمالك ونش", Icons.car_repair, WinchSignUpScreen(),
              context),
        ],
      ),
    );
  }

  Widget card(String data, IconData icon, Widget screen, context) {
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              data,
              style: AppTextStyle.mainStyle(),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(width: 20),
            Icon(
              icon,
              color: mainColor,
            ),
          ],
        ),
      ),
    );
  }
}
