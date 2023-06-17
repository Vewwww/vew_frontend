import 'package:flutter/material.dart';
import '../../core/components/add_button.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/name_address_card.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import 'add_gas_station_screen.dart';

class ViewGasStationScreen extends StatelessWidget {
  const ViewGasStationScreen({Key? key}) : super(key: key);

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: addButton(function: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddGasStationScreen()));
      }),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomAppBar(
            haveBackArrow: true,
              title: Text(
                "Gas Stations",
                style: AppTextStyle.mainStyle(size: 25),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => nameAddressCard(name: 'Name of Gas Station', address: 'Address of GS', function: (){}),
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
