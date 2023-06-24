import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';
import 'package:vewww/views/common/on_boarding_screen.dart';
import 'package:vewww/views/driver/sign_in_screen.dart';
import '../../core/components/logo.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../admin/admin_home_screen.dart';
import '../winch/winch_home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.primaryColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              tileMode: TileMode.repeated,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                mainColor,
                mainColor.withOpacity(0.8),
                const Color.fromARGB(255, 4, 237, 222),
                //Colors.white
              ]),
        ),
        child: Column(
          children: [
            Expanded(child: Container()),
            Center(
              child: Logo(
                size: 250,
                color: "white",
              ),
            ),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 10);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      if (SharedPreferencesHelper.getData(key: "vewIsFirst") != false) {
        return OnBoardingScreen();
      } else if (SharedPreferencesHelper.getData(key: "vewRole") == null)
        return SignInScreen();
      else {
        if (SharedPreferencesHelper.getData(key: "vewRole") == "admin")
          return AdminHomeScreen();
        else if (SharedPreferencesHelper.getData(key: "vewRole") == "driver")
          return DriverHomeScreen();
        else if (SharedPreferencesHelper.getData(key: "vewRole") == "winch")
          return WinchHomePage();
        else {
          //TODO:: add mechanic home screen
          return DriverHomeScreen();
        }
      }
    }), (route) => true);
  }
}
