import 'package:flutter/material.dart';

import '../../core/components/accepted_request_card.dart';
import '../../core/components/app_nav_bar.dart';
import '../../core/components/coming_request_card.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/sidebar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';

class WinchHomePage extends StatelessWidget {
  WinchHomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AppNavigationBar(),
      key: _globalKey,
      endDrawer: const Sidebar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
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
                      if (index % 2 == 0)
                        return AcceptedRequestCard();
                      else
                        return ComingRequestCard();
                    }))
          ],
        ),
      ),
    );
  }
}

/*
Expanded(child: Container()),
            Image.asset(
              "assets/images/Empty.png",
              width: 300,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Requests will be here",
              style: AppTextStyle.lightGrayTextStyle(25),
            ),
            Expanded(child: Container()),
*/ 
