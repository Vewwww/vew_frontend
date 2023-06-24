import 'package:flutter/material.dart';
import 'package:vewww/views/mechanic/mechanic_profile.dart';
import '../../core/components/accepted_request_card.dart';
import '../../core/components/app_nav_bar.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/sidebar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import 'mechanic_upcoming_req_screen.dart';

class MechanicHomeScreen extends StatelessWidget {
   MechanicHomeScreen({super.key});
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  AppNavigationBar(
         homeFunction: (){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MechanicHomeScreen()),
            (route) => false);
         },
         upComingReqFunction: (){
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MechanicUpComingReqScreen(),
            ));
      },
      ),
      key: _globalKey,
      endDrawer:  Sidebar(function: (){
         Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MechanicProfile()),
              (route) => true);
      },),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 20),
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Text(
                "الطلبات المقبولة",
                style: AppTextStyle.titleTextStyle(18),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return AcceptedRequestCard();
                    }))
          ],
        ),
      ),
    );
  }
}