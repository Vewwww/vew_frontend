import 'package:flutter/material.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/views/admin/view_admins_screen.dart';
import 'package:vewww/views/admin/view_app_users_screen.dart';
import 'package:vewww/views/admin/view_gas_stations_screen.dart';
import 'package:vewww/views/admin/view_maintenance_center_screen.dart';

import '../../core/components/default_button.dart';
import '../common/warning_light_screen.dart';
import 'admin_drawer.dart';

class AdminHomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _globalKey,
      endDrawer: const AdminDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                haveLogo: true,
                leading: IconButton(
                  icon: Icon(Icons.menu),
                  iconSize: 35,
                  color: Color.fromRGBO(2, 113, 106, 1),
                  onPressed: () {
                    _globalKey.currentState!.openDrawer();
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: defaultButton(
                      height: 70,
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const ViewAdminsScreen())));
                      },
                      text: 'Admins')),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: defaultButton(
                      height: 70,
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const WarningLightScreen())));
                      },
                      text: 'Warning Sign')),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: defaultButton(
                      height: 70,
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ViewAppUsersScreen())));
                      },
                      text: 'Users')),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultButton(
                      height: 70,
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const ViewMaitenanceCenterScreen())));
                      },
                      text: 'Maintenance Centers')),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultButton(
                      height: 70,
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const ViewGasStationScreen())));
                      },
                      text: 'Gas Stations')),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultButton(
                    height: 70,
                    text: 'Analytics',
                    function: () {
                      print('Analytics');
                    },
                  )),
            ],
          ),
        ),
      ),
      drawer: const AdminDrawer(),
    );
  }
}
