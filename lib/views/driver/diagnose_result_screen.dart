import 'package:flutter/material.dart';
import 'package:vewww/bloc/diagnose_cunit/diagnose_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/style/button_style/app_button_style.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';
import 'package:vewww/views/driver/search_result_screen.dart';
import 'package:vewww/views/common/select_car_type_screen.dart';
import '../../bloc/select_choice_cubit/select_choice_cubit.dart';
import '../../model/diagnose_result.dart';
import '../common/services_screen.dart';
import 'add_diagnose_question_screen.dart';

class DiagnoseResultScreen extends StatelessWidget {
  DiagnoseResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DiagnoseCubit diagnoseCubit = DiagnoseCubit.get(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomAppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: mainColor,
                ),
                onPressed: () {
                  NavigationUtils.navigateAndClearStack(
                      context: context, destinationScreen: const DriverHomeScreen());
                },
              ),
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
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            const SizedBox(height: 70),
            Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: "The Problrm should be solved if you ...\n ",
                        style: AppTextStyle.darkGreyStyle()),
                    TextSpan(
                        text: diagnoseCubit.diagnoseResult!.solution!,
                        style: AppTextStyle.mainStyle()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Expanded(child: SizedBox()),
            (diagnoseCubit.diagnoseResult!.gasStation!)
                ? SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: enabeledButton,
                        child: const Text("Find Gas Station"),
                        onPressed: () {
                          NavigationUtils.navigateTo(
                            context: context,
                            destinationScreen: SearchResultScreen(
                              filter: "Gas Station",
                            ),
                          );
                        }),
                  )
                : Container(),
            (diagnoseCubit.diagnoseResult!.maintenanceCenter!)
                ? SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: enabeledButton,
                      child: const Text('Find MaintanceCenter'),
                      onPressed: () {
                        SelectChoiceCubit.get(context).getAllCarTypes();
                        NavigationUtils.navigateTo(
                            context: context,
                            destinationScreen: SelectCarTypeScreen(
                              destinationScreen: SearchResultScreen(
                                filter: "Maintenance Centers",
                              ),
                            ));
                      },
                    ),
                  )
                : Container(),
            (diagnoseCubit.diagnoseResult!.mechanic!)
                ? SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: enabeledButton,
                      child: const Text('Request mechanic'),
                      onPressed: () {
                        if (diagnoseCubit.diagnoseResult!.serviceId == null)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ServicesScreen())));
                        else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => SearchResultScreen(
                                      filter: "Mechanist",
                                      serviceId: diagnoseCubit
                                          .diagnoseResult!.serviceId!.sId))));
                        }
                      },
                    ),
                  )
                : Container(),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "Your problem still unsolved?",
                style: AppTextStyle.greyStyle(size: 16),
              ),
            ),
            Center(
              child: TextButton(
                child: Text("Add question",
                    style: AppTextStyle.titleTextStyle(14)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddDiagnoseQuestionScreen()),
                  );
                },
              ),
            ),
           
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
