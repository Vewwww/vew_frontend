import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/diagnose_cunit/diagnose_cubit.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/style/button_style/app_button_style.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/views/driver/diagnose_result_screen.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/logo.dart';

class DiagnoseScreen extends StatefulWidget {
  String category;
  DiagnoseScreen({required this.category , Key? key}):super(key: key);

  @override
  State<DiagnoseScreen> createState() => _DiagnoseScreenState();
}

class _DiagnoseScreenState extends State<DiagnoseScreen> {
  @override
  void initState() {
    super.initState();
    var diagnoseCubit = context.read<DiagnoseCubit>();
    diagnoseCubit.questionNumber = 0;
    diagnoseCubit.selectedAnswer = -1;
    diagnoseCubit.keywords = [];
    diagnoseCubit.nextButtonTitle = "Next";
    diagnoseCubit.getQuestionsByCategory(widget.category);
  }

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
                    child: BlocBuilder<DiagnoseCubit, DiagnoseState>(
                        builder: (context, state) {
                      if (state is! GetQuestionsLoadingState &&
                          state is! GetAllQuestionErrorState) {
                        return Text(
                          diagnoseCubit
                                  .questionsResponse!
                                  .data![0]
                                  .questions![diagnoseCubit.questionNumber]
                                  .subQuestion ??
                              "null",
                          style: AppTextStyle.mainStyle(),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
                  ),
                  const SizedBox(height: 16.0),
                  Column(
                    children: [
                      Row(children: [
                        Radio(
                          value: 0,
                          groupValue: diagnoseCubit.selectedAnswer,
                          onChanged: (int? value) {
                            if (diagnoseCubit.state
                                    is! GetQuestionsErrorState &&
                                diagnoseCubit.state
                                    is! GetQuestionsLoadingState) {
                              diagnoseCubit.chooseAnswer(
                                  value,
                                  diagnoseCubit
                                      .questionsResponse!
                                      .data![0]
                                      .questions![diagnoseCubit.questionNumber]
                                      .yesKeywords!);
                            }
                          },
                          activeColor: mainColor,
                        ),
                        Text(
                          "Yes",
                          style: AppTextStyle.darkGreyStyle(),
                        ),
                      ]),
                      Row(children: [
                        Radio(
                          value: 1,
                          groupValue: diagnoseCubit.selectedAnswer,
                          onChanged: (int? value) {
                            if (diagnoseCubit.state
                                    is! GetQuestionsErrorState &&
                                diagnoseCubit.state
                                    is! GetQuestionsLoadingState) {
                              diagnoseCubit.chooseAnswer(
                                  value,
                                  diagnoseCubit
                                      .questionsResponse!
                                      .data![0]
                                      .questions![diagnoseCubit.questionNumber]
                                      .noKeywords!);
                            }
                          },
                          activeColor: mainColor,
                        ),
                        Text(
                          "No",
                          style: AppTextStyle.darkGreyStyle(),
                        ),
                      ]),
                    ],
                  ),
                  const Expanded(child: SizedBox(height: 16.0)),
                  BlocBuilder<DiagnoseCubit, DiagnoseState>(
                      builder: (context, state) {
                    if (diagnoseCubit.state is! GetQuestionsErrorState &&
                        diagnoseCubit.state is! GetQuestionsLoadingState) {
                      return Row(
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
                            onPressed: () async {
                              if (diagnoseCubit.questionNumber <
                                  diagnoseCubit.questionsResponse!.data![0]
                                          .questions!.length -
                                      1) {
                                diagnoseCubit.nextQuestion();
                              } else if (diagnoseCubit.questionNumber ==
                                      diagnoseCubit.questionsResponse!.data![0]
                                              .questions!.length -
                                          1 &&
                                  diagnoseCubit.selectedAnswer != -1) {
                                await diagnoseCubit.getResults();
                                if (diagnoseCubit.state
                                    is GetSolutionSuccessState) {
                                  NavigationUtils.navigateTo(
                                      context: context,
                                      destinationScreen:
                                          DiagnoseResultScreen());
                                }
                              }
                            },
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
