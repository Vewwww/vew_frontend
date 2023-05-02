import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_colors.dart';
import '../core/components/logo.dart';
import 'on_boarding_screen.dart';

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
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => OnBoardingScreen()
            /* {
      if (SharedPreferencesHelper.getData(key: "accessToken") == null)
        return LoginScreen();
      else
        return HomeScreen();
    } */
            ),
        (route) => true);
  }
}
