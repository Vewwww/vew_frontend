import 'package:flutter/material.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/button_style/app_button_style.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/views/driver_home_screen.dart';
import '../model/diagnose_result.dart';

class DiagnoseResultScreen extends StatelessWidget {
  DiagnoseResultScreen({Key? key}) : super(key: key);

  DiagnoseResult diagnoseResult = DiagnoseResult(
      result: "The car need fuel",
      actions: 'Add fuel to your car ',
      conclusion: 'Something wrong with the fuel indicator',
      needHelp: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomAppBar(
              title: Row(
                children: [
                  SizedBox(
                      height: 30, child: Image.asset("assets/images/Logo.png")),
                  Text(
                    "The Problem",
                    style: AppTextStyle.greyStyle(),
                  )
                ],
              ),
            ),
            SizedBox(height: 70),
            Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: "The Problrm is that ",
                        style: AppTextStyle.darkGreyStyle()),
                    TextSpan(
                        text: diagnoseResult.result,
                        style: AppTextStyle.mainStyle()),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            SizedBox(height: 30),
            Text(
              "Conclusion :",
              style: AppTextStyle.mainStyle(),
            ),
            Text(diagnoseResult.conclusion),
            SizedBox(height: 30),
            Text(
              "Actions :",
              style: AppTextStyle.mainStyle(),
            ),
            Text(diagnoseResult.actions),
            Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                    style: enabeledButton,
                    child: const Text("Find Gas Station"),
                    onPressed: () {
                      //TODO::Navigate to Find Gas Station screen
                      NavigationUtils.navigateAndClearStack(
                          context: context,
                          destinationScreen: DriverHomeScreen());
                    }),
                ElevatedButton(
                  style: enabeledButton,
                  child: const Text('Request mechanic'),
                  onPressed: () {
                    //TODO::Navigate to Request mechanic screen
                    NavigationUtils.navigateAndClearStack(
                        context: context,
                        destinationScreen: DriverHomeScreen());
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
