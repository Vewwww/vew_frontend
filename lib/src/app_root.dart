import 'package:flutter/material.dart';
import 'package:vewww/views/driver_home_screen.dart';
import 'package:vewww/views/warning_light_screen.dart';

import '../views/splash_screen.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DriverHomeScreen(),
    );
  }
}