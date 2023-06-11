import 'package:flutter/material.dart';

import '../../core/components/app_nav_bar.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/sidebar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';

class UpcomingRequestsScreen extends StatelessWidget {
  UpcomingRequestsScreen({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      bottomNavigationBar: const AppNavigationBar(),
      key: _globalKey,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              leading: IconButton(
                  onPressed: () {
                    _globalKey.currentState!.openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.grey,
                  )),
            ),
            Expanded(child: Container()),
            Image.asset(
              "assets/images/Empty.png",
              width: 300,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "لا يوجد لديك طلبات نقل الآن\n يمكنك الإنتظار لحين وصول طلب",
              textDirection: TextDirection.rtl,
              style: AppTextStyle.lightGrayTextStyle(25),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
