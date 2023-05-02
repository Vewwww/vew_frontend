import 'package:flutter/material.dart';
import 'package:vewww/bloc/chat_cubit/chat_cubit.dart';
import 'package:vewww/bloc/diagnose_cunit/diagnose_cubit.dart';
import 'package:vewww/views/driver_home_screen.dart';
import 'package:vewww/views/email_verification_screen.dart';
import 'package:vewww/views/warning_light_screen.dart';
import '../views/email_verified_screen.dart';
import '../views/phone_pin_verification.dart';
import '../views/phone_verification_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../views/splash_screen.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DiagnoseCubit(),
          ),
          BlocProvider(
            create: (context) => ChatCubit(),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: PhonePINVerification(),
        ));
  }
}
