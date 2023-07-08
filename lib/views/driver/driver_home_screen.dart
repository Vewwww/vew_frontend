import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/warning_sign_cubit/warning_sign_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/views/common/services_screen.dart';
import 'package:vewww/views/common/warning_light_screen.dart';
import 'package:vewww/views/driver/choose_problem_category_screen.dart';
import 'package:vewww/views/driver/driver_drawer.dart';
import 'package:vewww/views/driver/search_screen.dart';
import 'package:vewww/views/common/select_car_type_screen.dart';
import 'package:vewww/views/driver/which_car_screen.dart';
import '../../bloc/chat_cubit/chat_cubit.dart';
import '../../bloc/diagnose_cubit/diagnose_cubit.dart';
import '../../bloc/notification_cubit/notification_cubit.dart';
import '../../bloc/select_choice_cubit/select_choice_cubit.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import 'search_result_screen.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({Key? key}) : super(key: key);

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  @override
  void initState() {
    super.initState();
    var notificationCubit = context.read<NotificationCubit>();
    notificationCubit.getNotificatin();
    var chatCubit = context.read<ChatCubit>();
    chatCubit.getDriverChats();
  }

  @override
  Widget build(BuildContext context) {
    WarningSignCubit warningSignCubit = WarningSignCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                haveLogo: true,
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                      icon: BlocBuilder<NotificationCubit, NotificationState>(
                        builder: (context, state) {
                          if (state is GettingNotificationSuccessState &&
                              NotificationCubit.get(context).haveNew) {
                            return Stack(
                              children: [
                                const Icon(Icons.menu),
                                Positioned(
                                  right: 0,
                                  top: 1,
                                  child: CircleAvatar(
                                    radius: 7,
                                    backgroundColor: Colors.red.shade900,
                                  ),
                                )
                              ],
                            );
                          } else {
                            return const Icon(Icons.menu);
                          }
                        },
                      ),
                      iconSize: 35,
                      color: const Color.fromRGBO(2, 113, 106, 1),
                    );
                  },
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        NavigationUtils.navigateTo(
                            context: context,
                            destinationScreen: const SearchScreen());
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Color.fromRGBO(2, 113, 106, 1),
                        size: 30,
                      )),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              homeButton(
                  buttonIcon: Icons.live_help,
                  function: () {
                    DiagnoseCubit.get(context).getAllCategories();
                    NavigationUtils.navigateTo(
                        context: context,
                        destinationScreen: const ChoosePrblemCategoryScreen());
                  },
                  text: 'Do Not Know Car Problem',
                  width: 350,
                  height: 80),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Request ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  homeButton(
                      text: 'Mechanic',
                      buttonIcon: Icons.engineering,
                      height: 80,
                      width: (MediaQuery.of(context).size.width - 50) / 2,
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ServicesScreen())));
                      }),
                  homeButton(
                      text: 'Winch',
                      buttonIcon: Icons.car_repair,
                      height: 80,
                      width: (MediaQuery.of(context).size.width - 50) / 2,
                      function: () {
                        String id =
                            SharedPreferencesHelper.getData(key: 'vewId');
                        NavigationUtils.navigateTo(
                            context: context,
                            destinationScreen: WhichCarScreen(
                              id: id,
                              isWinch: true,
                            ));
                      }),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Find Nearest',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  homeButton(
                      text: 'Maintenance Center',
                      textSize: 15,
                      buttonIcon: Icons.build,
                      height: 80,
                      width: (MediaQuery.of(context).size.width - 50) / 2,
                      function: () {
                        SelectChoiceCubit.get(context).getAllCarTypes();
                        NavigationUtils.navigateTo(
                            context: context,
                            destinationScreen: SelectCarTypeScreen(
                              destinationScreen: SearchResultScreen(
                                filter: "Maintenance Centers",
                              ),
                            ));
                      }),
                  homeButton(
                      text: 'Gas Station',
                      height: 80,
                      width: (MediaQuery.of(context).size.width - 50) / 2,
                      buttonIcon: Icons.gas_meter,
                      iconColor: Colors.white,
                      function: () {
                        NavigationUtils.navigateTo(
                          context: context,
                          destinationScreen: SearchResultScreen(
                            filter: "Gas Station",
                          ),
                        );
                      })
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              homeButton(
                text: 'Warning Light',
                buttonIcon: Icons.warning_amber_rounded,
                height: 80,
                width: 350,
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const WarningLightScreen())));
                },
              ),
            ],
          ),
        ),
      ),
      drawer: const DriverDrawer(),
    );
  }
}
