import 'package:flutter/material.dart';
import 'package:vewww/core/components/near_repairer_card.dart';
import 'package:vewww/core/components/search_bar.dart';

import '../../core/components/custom_app_bar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/style/app_colors.dart';
import '../../core/utils/navigation.dart';
import '../../model/repairer.dart';
import 'driver_home_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CustomAppBar(
              title: const Text(""),
              leading: IconButton(
                  onPressed: () {
                    NavigationUtils.navigateTo(
                        context: context,
                        destinationScreen: const DriverHomeScreen());
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: mainColor,
                  )),
            ),
            SearchBar(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Near Repairers", style: AppTextStyle.greyStyle()),
                InkWell(
                    onTap: () {},
                    child: Text("See All", style: AppTextStyle.mainStyle())),
              ],
            ),
            const Divider(
              thickness: 1,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return NearRepairerCard(repairer: MaintenanceCenter());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
