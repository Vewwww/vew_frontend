import 'package:flutter/material.dart';
import 'package:vewww/core/components/filter_card.dart';
import 'package:vewww/views/driver/search_screen.dart';

import '../../core/components/custom_app_bar.dart';
import '../../core/components/near_repairer_card.dart';
import '../../core/components/search_bar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/style/app_colors.dart';
import '../../core/utils/navigation.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CustomAppBar(
              title: const Text(""),
              leading: IconButton(
                  onPressed: () {
                    NavigationUtils.navigateTo(
                        context: context,
                        destinationScreen: const SearchScreen());
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: mainColor,
                  )),
            ),
            SearchBar(),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilterCard(filter: "All"),
                  FilterCard(filter: "Mechanist"),
                  FilterCard(filter: "Gas Station"),
                  FilterCard(filter: "Maintenance Centers"),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return const NearRepairerCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
