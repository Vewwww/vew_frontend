import 'package:flutter/material.dart';
import 'package:vewww/bloc/chat_cubit/chat_cubit.dart';
import 'package:vewww/views/common/splash_screen.dart';
import '../bloc/add_image_cubit/add_image_cubit.dart';
import '../bloc/admin_add_cubit/admin_add_cubit.dart';
import '../bloc/admin_analysis_cubit/admin_analysis_cubit.dart';
import '../bloc/auth_cubit/auth_cubit.dart';
import '../bloc/car_cubit/car_cubit.dart';
import '../bloc/diagnose_cubit/diagnose_cubit.dart';
import '../bloc/evaluate_service_provider_cubit/evaluate_service_provider_cubit.dart';
import '../bloc/get_all_cubit/get_all_cubit.dart';
import '../bloc/language_cubit/language_cubit.dart';
import '../bloc/loaction_cubit/loaction_cubit.dart';
import '../bloc/nearest_repairer_cubit/nearest_repairer_cubit.dart';
import '../bloc/new_request_cubit/new_request_cubit.dart';
import '../bloc/notification_cubit/notification_cubit.dart';
import '../bloc/profile_cubit/profile_cubit.dart';
import '../bloc/radio_button_cubit/radio_button_cubit.dart';
import '../bloc/repairer_requests_cubit.dart/repairer_requests_cubit.dart';
import '../bloc/request_cubit/request_cubit.dart';
import '../bloc/search_cubit/seaech_cubit.dart';
import '../bloc/selected page index/cubit/selected_page_index_cubit.dart';
import '../bloc/service_cubit/services_cubit.dart';
import '../bloc/verification_cubit/verification_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/add_car_cubit/add_car_cubit.dart';
import '../bloc/gender_cubit/gender_cubit.dart';
import '../bloc/onboarding_cubit/onboarding_cubit.dart';
import '../bloc/reminder_cubit/reminder_cubit.dart';
import '../bloc/select_choice_cubit/select_choice_cubit.dart';
import '../bloc/select_color_cubit/select_color_cubit.dart';
import '../bloc/warning_sign_cubit/warning_sign_cubit.dart';

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
          BlocProvider(create: (context) => LocationCubit()),
          BlocProvider(create: (context) => SelectedPageIndexCubit()),
          BlocProvider(create: (context) => AuthCubit()),
          BlocProvider(create: (context) => SearchCubit()),
          BlocProvider(create: (context) => NearestRepairerCubit()),
          BlocProvider(create: (context) => AddImageCubit()),
          BlocProvider(create: (context) => VerificationCubit()),
          BlocProvider(create: (context) => WarningSignCubit()),
          BlocProvider(create: (context) => ProfileCubit()),
          BlocProvider(create: (context) => ServicesCubit()),
          BlocProvider(create: (context) => LanguageCubit()),
          BlocProvider(create: (context) => CarCubit()),
          BlocProvider(create: (context) => EvaluateServiceProviderCubit()),
          BlocProvider(create: (context) => NewRequestCubit()),
          BlocProvider(create: (context) => RepairerRequestsCubit()),
          BlocProvider(create: (context) => NotificationCubit()),
          BlocProvider(create: (context) => GetAllCubit()),
          BlocProvider(create: (context) => AdminAnalysisCubit()),
          BlocProvider(create: (context) => AdminAddCubit()),
          BlocProvider(create: (context) => RequestCubit()),
          BlocProvider(create: (context) => RadioButtonCubit()),
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
          home: const SplashScreen(),
        ));
  }
}
