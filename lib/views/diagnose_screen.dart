import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/diagnose_cunit/diagnose_cubit.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/style/button_style/app_button_style.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/views/diagnose_result_screen.dart';
import '../core/components/custom_app_bar.dart';
import '../core/components/logo.dart';
import '../model/diagnose_question.dart';

class DiagnoseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DiagnoseCubit diagnoseCubit = DiagnoseCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<DiagnoseCubit, DiagnoseState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomAppBar(
                    title: Text('Know The Problem',
                        style: AppTextStyle.greyStyle(size: 18)),
                    haveBackArrow: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Logo(),
                  ),
                  Center(
                    child: Text(
                      questions[diagnoseCubit.questionNumber].question,
                      style: AppTextStyle.mainStyle(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Column(
                    children: <Widget>[
                      for (int i = 0;
                          i <
                              questions[diagnoseCubit.questionNumber]
                                  .answers
                                  .length;
                          i++)
                        Row(children: [
                          Radio(
                            value: i,
                            groupValue: diagnoseCubit.selectedAnswer,
                            onChanged: (int? value) {
                              diagnoseCubit.chooseAnswer(value);
                            },
                            activeColor: mainColor,
                          ),
                          Text(
                            questions[diagnoseCubit.questionNumber].answers[i],
                            style: AppTextStyle.darkGreyStyle(),
                          ),
                        ]),
                    ],
                  ),
                  const Expanded(child: SizedBox(height: 16.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ElevatedButton(
                        style: diagnoseCubit.previousButtonStyle,
                        child: const Text('Back'),
                        onPressed: () {
                          diagnoseCubit.previousQuestion();
                        },
                      ),
                      ElevatedButton(
                        style: enabeledButton,
                        child: Text(diagnoseCubit.nextButtonTitle),
                        onPressed: () {
                          if (diagnoseCubit.questionNumber <
                              questions.length - 1) {
                            diagnoseCubit.nextQuestion();
                          } else if (diagnoseCubit.questionNumber ==
                                  questions.length - 1 &&
                              diagnoseCubit.selectedAnswer != -1) {
                            NavigationUtils.navigateTo(
                                context: context,
                                destinationScreen: DiagnoseResultScreen());
                          }
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
