import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/views/driver/select_car_model_screen.dart';

import '../../bloc/add_car_cubit/add_car_cubit.dart';
import '../../bloc/gender_cubit/gender_cubit.dart';
import '../../bloc/reminder_cubit/reminder_cubit.dart';
import '../../bloc/select_choice_cubit/select_choice_cubit.dart';
import '../../bloc/select_color_cubit/select_color_cubit.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/logo.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/style/app_colors.dart';
import '../../core/utils/navigation.dart';
import '../../model/car_type.dart';
import '../../model/driver.dart';
import 'driver_home_screen.dart';
import '../common/select_color_screen.dart';

class EditDriverProfile extends StatelessWidget {
  String? carType;
  String? color;
  Driver driver;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  EditDriverProfile({required this.driver, this.color, Key? key})
      : super(key: key) {
    _email.text = driver.email!;
    _name.text = driver.name!;
    _phone.text = driver.phoneNumber!;
  }

  @override
  Widget build(BuildContext context) {
    var constraintsHight = MediaQuery.of(context).size.height;
    AddCarCubit addCarCubit = AddCarCubit.get(context);
    GenderCubit genderCubit = GenderCubit.get(context);
    ReminderCubit reminderCubit = ReminderCubit.get(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: constraintsHight / 30),
                  Center(child: Logo(size: 170)),
                  SizedBox(height: constraintsHight / 60),
                  const Divider(
                    thickness: 1.2,
                    color: Color.fromARGB(255, 209, 209, 209),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _name,
                    label: "Name",
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'Name is required';
                      }
                    },
                  ),
                  CustomTextField(
                    label: "Email",
                    controller: _email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      } else if (!value.contains('@') || !value.contains('.')) {
                        return 'Please Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                  Text(
                    "Gender",
                    style: AppTextStyle.darkGreyStyle(size: 14),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 20,
                    //TODO::Send gender as male or female
                    child: BlocConsumer<GenderCubit, GenderState>(
                        listener: (context, snapshot) {},
                        builder: (context, snapshot) {
                          return Row(
                            children: [
                              Radio<int>(
                                  value: 1,
                                  activeColor: mainColor,
                                  groupValue: genderCubit.gender,
                                  onChanged: (val) {
                                    (val != null)
                                        ? genderCubit.choseGender(1)
                                        : genderCubit.choseGender(-1);
                                  }),
                              const Text("Male"),
                              const Expanded(child: SizedBox()),
                              Radio<int>(
                                  activeColor: mainColor,
                                  value: 2,
                                  groupValue: genderCubit.gender,
                                  onChanged: (val) {
                                    (val != null)
                                        ? genderCubit.choseGender(2)
                                        : genderCubit.choseGender(-1);
                                  }),
                              const Text("Female"),
                            ],
                          );
                        }),
                  ),
                  CustomTextField(
                    label: "Phone Number",
                    controller: _phone,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'Phone number is required';
                      }
                    },
                  ),
                  CustomTextField(
                    label: "License Renewal Date",
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'License Renewal Date is required';
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      const Divider(
                        color: Colors.grey,
                      ),
                      BlocConsumer<AddCarCubit, AddCarState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              if (!addCarCubit.carExist) {
                                addCarCubit.add();
                              } else {
                                addCarCubit.remove();
                              }
                            },
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: (addCarCubit.carExist)
                                  ? Colors.grey
                                  : mainColor,
                              child: Icon(
                                (!addCarCubit.carExist)
                                    ? Icons.add
                                    : Icons.remove,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  //TODO:: add car model
                  BlocConsumer<AddCarCubit, AddCarState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (!addCarCubit.carExist) {
                        return Text(
                          "No cars",
                          style: AppTextStyle.greyStyle(size: 18),
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: mainColor.withOpacity(0.3),
                                    child: const Icon(Icons.drive_eta,
                                        size: 30,
                                        //TODO::confirm color structure with back team
                                        color: Colors
                                            .black // driver.cars![0].color,
                                        ))),
                            BlocConsumer<SelectChoiceCubit, SelectChoiceState>(
                                listener: (context, snapshot) {},
                                builder: (context, snapshot) {
                                  return CustomTextField(
                                    label: "Car Type",
                                    hint: SelectChoiceCubit.get(context).carTypeResponse!.carType![SelectChoiceCubit.get(context)
                                            .choice]
                                        .name!.en,
                                    isDroped: true,
                                    onDrop: () {
                                      NavigationUtils.navigateTo(
                                          context: context,
                                          destinationScreen:
                                              const SelectCarModelScreen());
                                    },
                                    validator: (value) {
                                      //TODO::return and validate car model
                                    },
                                  );
                                }),
                            BlocConsumer<SelectColorCubit, SelectColorState>(
                                listener: (context, snapshot) {},
                                builder: (context, snapshot) {
                                  return CustomTextField(
                                    label: "Car Color",
                                    // hint: colors[
                                    //     SelectColorCubit.get(context).color],
                                    isDroped: true,
                                    onDrop: () {
                                      NavigationUtils.navigateTo(
                                          context: context,
                                          destinationScreen:
                                              const SelectColorScreen());
                                    },
                                    validator: (value) {
                                      //TODO::return and validate car model
                                    },
                                  );
                                }),
                            CustomTextField(
                              label: "Car Plat Number",
                              validator: (value) {
                                if (addCarCubit.carExist) {
                                  if (value!.isEmpty || value == null) {
                                    return 'Car Number is required';
                                  }
                                }
                              },
                            ),
                            CustomTextField(
                              label: "Last Periodic Maintenance Date",
                              validator: (value) {
                                if (addCarCubit.carExist) {
                                  if (value!.isEmpty || value == null) {
                                    return 'Last Periodic Maintenance Date is required';
                                  }
                                }
                              },
                            ),
                            CustomTextField(
                              label: "License renewal date",
                              validator: (value) {
                                if (addCarCubit.carExist) {
                                  if (value!.isEmpty || value == null) {
                                    return 'License renewal date is required';
                                  }
                                }
                              },
                            ),
                            CustomTextField(
                              label: "Miles",
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (addCarCubit.carExist) {
                                  if (value!.isEmpty || value == null) {
                                    return 'Miles is required';
                                  }
                                }
                              },
                            ),
                            CustomTextField(
                              label: "Average Miles per week",
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (addCarCubit.carExist) {
                                  if (value!.isEmpty || value == null) {
                                    return 'Average Miles per week is required';
                                  }
                                }
                              },
                            ),
                            Text("Remind You Before?",
                                style: AppTextStyle.darkGreyStyle(size: 14)),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 20,
                              child: BlocConsumer<ReminderCubit, ReminderState>(
                                  listener: (context, snapshot) {},
                                  builder: (context, snapshot) {
                                    return Row(
                                      children: [
                                        Radio<int>(
                                            value: 1,
                                            activeColor: mainColor,
                                            groupValue: reminderCubit.reminder,
                                            onChanged: (val) {
                                              (val != null)
                                                  ? reminderCubit.choseTime(1)
                                                  : reminderCubit.choseTime(-1);
                                            }),
                                        const Text("Week"),
                                        const Expanded(child: SizedBox()),
                                        Radio<int>(
                                            activeColor: mainColor,
                                            value: 2,
                                            groupValue: reminderCubit.reminder,
                                            onChanged: (val) {
                                              (val != null)
                                                  ? reminderCubit.choseTime(2)
                                                  : reminderCubit.choseTime(-1);
                                            }),
                                        const Text("2 Weeks"),
                                        const Expanded(child: SizedBox()),
                                        Radio<int>(
                                            activeColor: mainColor,
                                            value: 3,
                                            groupValue: reminderCubit.reminder,
                                            onChanged: (val) {
                                              (val != null)
                                                  ? reminderCubit.choseTime(3)
                                                  : reminderCubit.choseTime(-1);
                                            }),
                                        const Text("Month"),
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            NavigationUtils.navigateAndClearStack(
                                context: context,
                                destinationScreen: const DriverHomeScreen());
                          }
                        },
                        child: const Text("Update"),
                      )),
                ],
              )),
        ),
      ),
    );
  }
}
