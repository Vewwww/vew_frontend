import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/diagnose_cubit/diagnose_cubit.dart';
import 'package:vewww/bloc/radio_button_cubit/radio_button_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';

import '../../core/components/custom_text_field.dart';
import '../../model/case.dart';

class AddCaseScreen extends StatelessWidget {
  var keyWordsController = TextEditingController();
  var solutionController = TextEditingController();
  var serviceIdController = TextEditingController();
  var mcController = TextEditingController();
  var mechanicController = TextEditingController();
  var gSController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    DiagnoseCubit diagnoseCubit = DiagnoseCubit.get(context);
    RadioButtonCubit radioButtonCubit = RadioButtonCubit.get(context);
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  haveBackArrow: true,
                  title: Text(
                    'Add Diagnose Case',
                    style: AppTextStyle.mainStyle(size: 25),
                  ),
                ),
                CustomTextField(
                    controller: keyWordsController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    label: 'Case Keywords'),
                Text(
                  ' Please enter the keywords spareted by commas',
                  style: AppTextStyle.lightGrayTextStyle(10),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    controller: solutionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    label: 'Solution'),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    controller: serviceIdController,
                    validator: (value) {
                      return null;
                    },
                    label: 'ServiceId'),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Maintenance Center',
                  style: AppTextStyle.greyStyle(size: 15),
                ),
                Row(
                  children: [
                    BlocBuilder<RadioButtonCubit, RadioButtonState>(
                      builder: (context, state) {
                        return Container(
                          width: 150,
                          child: ListTile(
                            title: const Text('True'),
                            leading: Radio<BooleanEnum>(
                              value: BooleanEnum.yes,
                              groupValue:
                                  radioButtonCubit.maintenanceCenterchoice,
                              onChanged: (BooleanEnum? value) {
                                radioButtonCubit.mcChangeOption(value);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    BlocBuilder<RadioButtonCubit, RadioButtonState>(
                      builder: (context, state) {
                        return Container(
                          width: 150,
                          child: ListTile(
                            title: const Text('False'),
                            leading: Radio<BooleanEnum>(
                              value: BooleanEnum.no,
                              groupValue:
                                  radioButtonCubit.maintenanceCenterchoice,
                              onChanged: (BooleanEnum? value) {
                                radioButtonCubit.mcChangeOption(value);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Mechanic',
                  style: AppTextStyle.greyStyle(size: 15),
                ),
                Row(
                  children: [
                    BlocBuilder<RadioButtonCubit, RadioButtonState>(
                      builder: (context, state) {
                        return Container(
                          width: 150,
                          child: ListTile(
                            title: const Text('True'),
                            leading: Radio<BooleanEnum>(
                              value: BooleanEnum.yes,
                              groupValue: radioButtonCubit.mechanicChoice,
                              onChanged: (BooleanEnum? value) {
                                radioButtonCubit.mChangeOption(value);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    BlocBuilder<RadioButtonCubit, RadioButtonState>(
                      builder: (context, state) {
                        return Container(
                          width: 150,
                          child: ListTile(
                            title: const Text('False'),
                            leading: Radio<BooleanEnum>(
                              value: BooleanEnum.no,
                              groupValue: radioButtonCubit.mechanicChoice,
                              onChanged: (BooleanEnum? value) {
                                radioButtonCubit.mChangeOption(value);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Gas Station',
                  style: AppTextStyle.greyStyle(size: 15),
                ),
                Row(
                  children: [
                    BlocBuilder<RadioButtonCubit, RadioButtonState>(
                      builder: (context, state) {
                        return Container(
                          width: 150,
                          child: ListTile(
                            title: const Text('True'),
                            leading: Radio<BooleanEnum>(
                              value: BooleanEnum.yes,
                              groupValue: radioButtonCubit.gasStationChoice,
                              onChanged: (BooleanEnum? value) {
                                radioButtonCubit.gsChangeOption(value);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    BlocBuilder<RadioButtonCubit, RadioButtonState>(
                      builder: (context, state) {
                        return Container(
                          width: 150,
                          child: ListTile(
                            title: const Text('False'),
                            leading: Radio<BooleanEnum>(
                              value: BooleanEnum.no,
                              groupValue: radioButtonCubit.gasStationChoice,
                              onChanged: (BooleanEnum? value) {
                                radioButtonCubit.gsChangeOption(value);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                defaultButton(
                    text: 'Add',
                    function: () {
                      final form = formKey.currentState;
                      if (form!.validate()) {
                        List<String> keyWord =
                            keyWordsController.text.split(',');
                        Case aCase = Case(
                          caseKeyWords: keyWord,
                          solution: solutionController.text,
                          serviceId: serviceIdController.text,
                          maintenanceCenter: radioButtonCubit.mcChoice,
                          mechanic: radioButtonCubit.mChoice,
                          gasStation: radioButtonCubit.gsChoice,
                        );
                        diagnoseCubit.addCase(aCase);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum BooleanEnum { yes, no }
