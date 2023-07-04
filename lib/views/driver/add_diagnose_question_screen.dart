import 'package:flutter/material.dart';
import 'package:vewww/bloc/diagnose_cunit/diagnose_cubit.dart';
import 'package:vewww/core/components/custom_text_field.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';

import '../../core/components/custom_app_bar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/style/app_colors.dart';
import '../../core/utils/navigation.dart';

class AddDiagnoseQuestionScreen extends StatelessWidget {
  AddDiagnoseQuestionScreen({Key? key}) : super(key: key);
  TextEditingController _question = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomAppBar(
              haveBackArrow: true,
              haveLogo: true,
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            SizedBox(height: 20),
            Text(
              "Please add a clear question for your case \nso an expert answer it \nfor furthet similier proplems",
              style: AppTextStyle.greyStyle(),
              textAlign: TextAlign.center,
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
            SizedBox(height: 50),
            CustomTextField(
              controller: _question,
              hint:
                  "I am hearing knock sound from the engin and tempretue is high",
              validator: (value) {},
              label: "Question",
            ),
            Expanded(child: Container()),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (_question.text == " " || _question.text == "") {
                        const snackBar =
                            SnackBar(content: Text("please add your question"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        const snackBar = SnackBar(
                            content: Text(
                                "Thank you, you can find nearest repairer\nto solve your problem now"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        DiagnoseCubit.get(context)
                            .addDriverQuestion(_question.text);
                        NavigationUtils.navigateAndClearStack(
                            context: context,
                            destinationScreen: DriverHomeScreen());
                      }
                    },
                    child: Text("Add"))),
            SizedBox(height: 30),
          ],
        ),
      )),
    );
  }
}
