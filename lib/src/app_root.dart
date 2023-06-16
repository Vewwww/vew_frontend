import 'package:flutter/material.dart';
import 'package:vewww/bloc/chat_cubit/chat_cubit.dart';
import 'package:vewww/bloc/diagnose_cunit/diagnose_cubit.dart';
import 'package:vewww/views/common/splash_screen.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';
import '../bloc/auth_cubit/auth_cubit.dart';
import '../bloc/loaction_cubit/loaction_cubit.dart';
import '../bloc/selected page index/cubit/selected_page_index_cubit.dart';
import '../bloc/verification_cubit/verification_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/add_car_cubit/add_car_cubit.dart';
import '../bloc/gender_cubit/gender_cubit.dart';
import '../bloc/onboarding_cubit/onboarding_cubit.dart';
import '../bloc/reminder_cubit/reminder_cubit.dart';
import '../bloc/select_choice_cubit/select_choice_cubit.dart';
import '../bloc/select_color_cubit/select_color_cubit.dart';
import '../views/admin/admin_home_screen.dart';


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
          BlocProvider(
            create: (context) => OnboardingCubit(),
          ),
          BlocProvider(
            create: (context) => AddCarCubit(),
          ),
          BlocProvider(create: (context) => SelectChoiceCubit()),
          BlocProvider(create: (context) => SelectColorCubit()),
          BlocProvider(create: (context) => GenderCubit()),
          BlocProvider(create: (context) => ReminderCubit()),
          BlocProvider(create: (context)=> LocationCubit()),
          BlocProvider(create: (context)=> SelectedPageIndexCubit()),
          BlocProvider(create: (context)=> AuthCubit()),
          BlocProvider(create: (context)=> VerificationCubit()),
        ],
        child: MaterialApp(
          theme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                  focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: Color.fromARGB(255, 2, 113, 106)),
              )),
              shadowColor: const Color.fromARGB(255, 2, 113, 106),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 2, 113, 106))),
              primaryColor: const Color.fromARGB(255, 2, 113, 106)),
          debugShowCheckedModeBanner: false,

          home: SplashScreen(),
        ));
  }
}
