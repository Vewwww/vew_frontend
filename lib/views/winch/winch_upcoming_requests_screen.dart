import 'package:flutter/material.dart';
import 'package:vewww/core/components/empty_requests.dart';
import 'package:vewww/views/winch/winch_home_page.dart';
import 'package:vewww/views/winch/winch_profile.dart';

import '../../core/components/accepted_request_card.dart';
import '../../core/components/app_nav_bar.dart';
import '../../core/components/coming_request_card.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/sidebar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';

class WinchUpcomingRequestsScreen extends StatelessWidget {
  WinchUpcomingRequestsScreen({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Sidebar(
        function: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const WinchProfile()),
              (route) => true);
        },
      ),
      bottomNavigationBar: AppNavigationBar(homeFunction: (){
         Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => WinchHomePage()),
            (route) => false);
      },
      upComingReqFunction: (){
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WinchUpcomingRequestsScreen(),
            ));
      },
      ),
      key: _globalKey,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 20),
          CustomAppBar(
            leading: IconButton(
                onPressed: () {
                  _globalKey.currentState!.openEndDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.grey,
                )),
            haveLogo: true,
          ),
          Expanded(child: Container()),
          //TODO::uncomment
          //(comingRequests.length > 0)?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Text(
              "الطلبات القادمة",
              style: AppTextStyle.titleTextStyle(18),
            ),
          ),
          Expanded(
              flex: 70,
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return const ComingRequestCard();
                  })),
          //:const SizedBox(height: 400, child: EmptyRequests()),
          Expanded(child: Container()),
        ],
      )),
    );
  }
}