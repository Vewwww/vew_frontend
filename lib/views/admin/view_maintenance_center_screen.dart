import 'package:flutter/material.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/name_address_card.dart';
import '../../core/components/add_button.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import 'add_maintenance_center_screen.dart';

class ViewMaitenanceCenterScreen extends StatelessWidget {
  const ViewMaitenanceCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: addButton(function: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddMaintenanceCenterScreen()));
      }),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomAppBar(
            haveBackArrow: true,
              title: Text(
                "Maintenance Center",
                style: AppTextStyle.mainStyle(size: 25),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => nameAddressCard(name: 'Name of Maintenance Center', address: 'Address of MC', function: (){}),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                itemCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
