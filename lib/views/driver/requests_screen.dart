import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/horizontal_line.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/views/driver/nearest_winch_screen.dart';

import '../../core/components/request_card.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        CustomAppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => NearestWinchScreen()),
                  (route) => false);
            },
            iconSize: 40,
            color: mainColor,
            icon: Icon(
              Icons.keyboard_arrow_left,
            ),
          ),
          haveLogo: true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text('Pending Requests', style: AppTextStyle.darkGreyStyle(),),
        ),
        HorizontalLine(),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return requestCard(
                  function: () {},
                  isWinch: true,
                  name: "Winch Name",
                  rate: 3.5,
                  thirdVal: '123 اق',
                  requestState: 'Pending..');
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 15,
            ),
          ),
        ),
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text('Current Requests', style: AppTextStyle.darkGreyStyle(),),
        ),
        HorizontalLine(),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return requestCard(
                  function: () {},
                  isWinch: true,
                  name: "Winch Name",
                  rate: 3.5,
                  thirdVal: '123 اق',
                  requestState: 'On his way');
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 15,
            ),
          ),
        ),
      ]),
    );
  }
}
