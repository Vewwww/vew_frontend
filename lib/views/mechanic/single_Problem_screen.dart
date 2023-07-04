import 'package:flutter/material.dart';
import 'package:vewww/views/mechanic/mechanic_home_screen.dart';

import '../../bloc/diagnose_cunit/diagnose_cubit.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';
import '../../model/problem_response.dart';

class SingleProblemScreen extends StatelessWidget {
  ProblemData problemData;
  TextEditingController _solution = TextEditingController();
  SingleProblemScreen({required this.problemData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomAppBar(
              haveBackArrow: true,
              haveLogo: true,
            ),
            // const Divider(
            //   color: Colors.grey,
            //   thickness: 1,
            // ),
            SizedBox(height: 20),
            Text(
              "من فضلك ادخل حل للمشكلة فقط اذا كنت متأكد",
              style: AppTextStyle.greyStyle(),
              textAlign: TextAlign.center,
            ),
            Text(
              "نحن نقدر مساعدتك ,شكرا لك",
              style: AppTextStyle.mainStyle(),
              textAlign: TextAlign.center,
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
            SizedBox(height: 10),
            Text(
              ":المشكلة ",
              style: AppTextStyle.mainStyle(),
              textAlign: TextAlign.center,
            ),
            Text(
              problemData.problem!,
              style: AppTextStyle.darkGreyStyle(),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            const Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
            SizedBox(height: 10),
            CustomTextField(
              isArabic: true,
              controller: _solution,
              hint: "يجب عليك ايقاف السيارة و تذويدها بالماء",
              validator: (value) {},
              label: "الحل:",
            ),
            Expanded(child: Container()),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (_solution.text == " " || _solution.text == "") {
                        const snackBar =
                            SnackBar(content: Text("من فضلك ادخل الاجابة"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        const snackBar = SnackBar(content: Text("شكرا لك!"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        DiagnoseCubit.get(context)
                            .solveDriverQuestion(problemData, _solution.text);
                        DiagnoseCubit.get(context).getUnsolvedQuestion();

                        NavigationUtils.navigateBack(context: context);
                      }
                    },
                    child: Text("حل"))),
            SizedBox(height: 30),
          ],
        ),
      )),
    );
  }
}
