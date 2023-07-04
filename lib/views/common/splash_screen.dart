import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/request_cubit/request_cubit.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';
import 'package:vewww/views/common/on_boarding_screen.dart';
import 'package:vewww/views/driver/sign_in_screen.dart';
import 'package:vewww/views/mechanic/mechanic_home_screen.dart';
import '../../bloc/repairer_requests_cubit.dart/repairer_requests_cubit.dart';
import '../../core/components/logo.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../admin/admin_home_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../winch/winch_home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  IO.Socket? socket;
  @override
  void initState() {
    super.initState();
    startTime();
  }

  initSocket(String id) {
    socket = IO.io("https://vewwwapi.onrender.com/", <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket!.connect();
    socket!.onConnect((_) {
      print('Connection established');
      socket!.emit('join-room', {'room': id});
      print('joined room');
    });
    socket!.on("new-request", (data) {
      print("new request created");
      var requestCubit = context.read<RepairerRequestsCubit>();
      String role = SharedPreferencesHelper.getData(key: "vewRole");
      if (role == "mechanic")
        requestCubit.mechanicUpComingRequests();
      else if (role == "winch") requestCubit.winchUpComingRequests();
    });
    socket!.onDisconnect((_) => print('Connection Disconnection'));
    socket!.onConnectError((err) => print(err));
    socket!.onError((err) => print(err));
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
        String id = SharedPreferencesHelper.getData(key: "vewId");
        if (SharedPreferencesHelper.getData(key: "vewRole") == "admin")
          return AdminHomeScreen();
        else if (SharedPreferencesHelper.getData(key: "vewRole") == "user")
          return DriverHomeScreen();
        else if (SharedPreferencesHelper.getData(key: "vewRole") == "winch") {
          initSocket(id);
          return WinchHomePage();
        } else {
          initSocket(id);
          return MechanicHomeScreen();
        }
      }
    }), (route) => true);
  }
}
