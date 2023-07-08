import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/components/service_card.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/views/admin/car_model_analysis_screen.dart';
import 'package:vewww/views/admin/gender_analysis.dart';
import 'package:vewww/views/admin/seasons_analysis_screen.dart';
import 'package:vewww/views/admin/users_analysis_screen.dart';

class AdminAnalysisScreen extends StatelessWidget {
  const AdminAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            title: Text(
              'Choose Your Analysis',
              style: AppTextStyle.mainStyle(size: 25),
            ),
            haveBackArrow: true,
          ),
          Center(
              child: Image.asset(
            'assets/images/Logo(1).png',
            height: 150,
            width: 175,
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                serviceCard(
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => UsersAnalysisScreen())));
                    },
                    title: 'Vewww user\'s analysis'),
                serviceCard(
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => GenderAnalysisScreen())));
                    },
                    title: 'Gender analysis'),
                serviceCard(
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => SeasonAnalysisScreen())));
                    },
                    title: 'Seasons analysis.'),
                serviceCard(
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  CarModelAnalysisScreen())));
                    },
                    title: 'Car types analysis'),
                serviceCard(
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  CarModelAnalysisScreen())));
                    },
                    title: 'Roads analysis'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
