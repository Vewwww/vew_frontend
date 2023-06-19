import 'package:flutter/material.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/user_card.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/views/admin/view_drivers_screen.dart';
import 'package:vewww/views/admin/view_mechanic_screen.dart';
import 'package:vewww/views/admin/view_winch_screen.dart';

import '../../core/components/backward_arrow.dart';

class ViewAppUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        CustomAppBar(
          title: Text(
            'Application\' s Users',
            style: AppTextStyle.mainStyle(size: 25),
          ),
          haveBackArrow: true,
        ),
        SizedBox(height: 175,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              uaserCard(
                function: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                   ViewDriversScreen())));
                }, 
                title: 'Drivers', 
                icon: Icons.person),
              SizedBox(
                height: 25,
              ),
              uaserCard(
                  function: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                   ViewWinchScreen())));
                  },
                  title: 'Winch Driver',
                  icon: Icons.car_repair),
              SizedBox(
                height: 25,
              ),
              uaserCard(
                  function: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                   ViewMechanicScreen())));
                  },
                  title: 'Mechnaic',
                  icon: Icons.handyman_outlined),
            ],
          ),
        ),
      ]),
    );
  }
}
