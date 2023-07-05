import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/car_cubit/car_cubit.dart';
import 'package:vewww/bloc/select_choice_cubit/select_choice_cubit.dart';
import 'package:vewww/bloc/select_color_cubit/select_color_cubit.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/model/car_type.dart';
import 'package:vewww/model/driver.dart';
import 'package:vewww/views/common/select_color_screen.dart';
import 'package:vewww/views/driver/select_car_model.dart';
import 'package:vewww/views/driver/sign_in_screen.dart';
import '../../bloc/add_car_cubit/add_car_cubit.dart';
import '../../bloc/auth_cubit/auth_cubit.dart';
import '../../bloc/gender_cubit/gender_cubit.dart';
import '../../bloc/reminder_cubit/reminder_cubit.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/logo.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';
import '../../model/car.dart';
import '../../model/car_color.dart';
import '../../model/person.dart';
import 'select_car_type_screen.dart';

class SignUpScreen extends StatelessWidget {
  String? carType;
  String? color;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _driverlisenceRenewalDate =
      TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _carType = TextEditingController();
  final TextEditingController _carPlateNum = TextEditingController();
  final TextEditingController _carColor = TextEditingController();
  final TextEditingController _carlisenceRenewalDate = TextEditingController();
  final TextEditingController _lastPeriodicMaintenanceDate =
      TextEditingController();
  final TextEditingController _miles = TextEditingController();
  final TextEditingController _avgMilesPerMonth = TextEditingController();
  SignUpScreen({this.carType, this.color, Key? key}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    double constraintsHight = MediaQuery.of(context).size.height;
    AddCarCubit addCarCubit = AddCarCubit.get(context);
    GenderCubit genderCubit = GenderCubit.get(context);
    SelectChoiceCubit selectChoiceCubit = SelectChoiceCubit.get(context);
    ReminderCubit reminderCubit = ReminderCubit.get(context);
    AuthCubit authCubit = AuthCubit.get(context);
    //CarCubit carCubit = CarCubit.get(context);
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
                  Center(
                    child: Text(
                      "Sign Up",
                      style: AppTextStyle.titleTextStyle(20),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                    hint: "example@mail.com",
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
                    controller: _phoneNumber,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'Phone number is required';
                      }
                    },
                  ),
                  CustomTextField(
                    controller: _password,
                    label: "Password",
                    validator: (value) {
                      RegExp regex =
                          RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])');
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (!regex.hasMatch(value)) {
                        return 'Password should Contain: \nAt least 8 chatacters\nAt least an uppercase latter  \nAt least a lowercase latter   \nAt least one number';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    label: "Confirm password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please re-enter the password ';
                      } else if (value != _password.text) {
                        return 'Doesn\'t match the password ';
                      }
                      return null;
                    },
                  ),
                  // CustomTextField(
                  //   label: "License Renewal Date",
                  //   controller: _driverlisenceRenewalDate,

                  //   validator: (value) {
                  //     if (value!.isEmpty || value == null) {
                  //       return 'License Renewal Date is required';
                  //     }
                  //   },
                  // ),
                  buildDatePicker("License Renewal Date is required",
                      (newDate) {
                    authCubit.driver.lisenceRenewalDate =
                        newDate.toString().replaceAll(" 00:00:00.000", "");
                  }),
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
                              if (addCarCubit.cars.isEmpty)
                                addCarCubit.add(Car());
                              else
                                addCarCubit.remove(0);
                            },
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: (addCarCubit.cars.length > 0)
                                  ? Colors.grey
                                  : mainColor,
                              child: Icon(
                                (addCarCubit.cars.isEmpty)
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
                  BlocConsumer<AddCarCubit, AddCarState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (addCarCubit.cars.isEmpty) {
                        return Text(
                          "No cars",
                          style: AppTextStyle.greyStyle(size: 18),
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocConsumer<SelectChoiceCubit, SelectChoiceState>(
                                listener: (context, snapshot) {},
                                builder: (context, snapshot) {
                                  return Column(
                                    children: [
                                      CustomTextField(
                                        label: "Car Type",
                                        controller: _carType,
                                        hint: (selectChoiceCubit
                                                    .carTypeResponse !=
                                                null)
                                            ? selectChoiceCubit
                                                .carTypeResponse!
                                                .carType![SelectChoiceCubit.get(
                                                        context)
                                                    .carTypeChoice]
                                                .name!
                                                .en!
                                            : "",
                                        isDroped: true,
                                        onDrop: () {
                                          selectChoiceCubit.getAllCarTypes();
                                          NavigationUtils.navigateTo(
                                              context: context,
                                              destinationScreen:
                                                  SelectCarTypeScreen());
                                        },
                                        validator: (value) {
                                          if (selectChoiceCubit
                                                  .carTypeResponse ==
                                              null) {
                                            return "car type is required";
                                          }
                                        },
                                      ),
                                      CustomTextField(
                                        label: "Car Model",
                                        //controller: _carModel,
                                        hint: (selectChoiceCubit
                                                        .carModelResponse !=
                                                    null &&
                                                selectChoiceCubit
                                                    .carModelResponse!
                                                    .carModels!
                                                    .isNotEmpty)
                                            ? selectChoiceCubit
                                                .carModelResponse!
                                                .carModels![
                                                    SelectChoiceCubit.get(
                                                            context)
                                                        .carModelChoice]
                                                .name!
                                            : "",
                                        isDroped: true,
                                        onDrop: () {
                                          if (selectChoiceCubit
                                                  .carTypeResponse !=
                                              null) {
                                            String id = selectChoiceCubit
                                                .carTypeResponse!
                                                .carType![selectChoiceCubit
                                                    .carTypeChoice]
                                                .sId!;
                                            selectChoiceCubit
                                                .getAllCarModels(id);
                                            NavigationUtils.navigateTo(
                                                context: context,
                                                destinationScreen:
                                                    SelectCarModelScreen(
                                                        id: id));
                                          } else {
                                            const snackBar = SnackBar(
                                                content: Text(
                                                    "Please chose car type first!"));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                        },
                                        validator: (value) {
                                          if (selectChoiceCubit
                                                  .carTypeResponse ==
                                              null) {
                                            return "car type is required";
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                }),
                            BlocConsumer<SelectColorCubit, SelectColorState>(
                                listener: (context, snapshot) {},
                                builder: (context, snapshot) {
                                  return CustomTextField(
                                    label: "Car Color",
                                    controller: _carColor,
                                    hint: (SelectColorCubit.get(context)
                                                .carColorResponse !=
                                            null)
                                        ? SelectColorCubit.get(context)
                                            .carColorResponse!
                                            .carColor![
                                                SelectColorCubit.get(context)
                                                    .color]
                                            .name!
                                            .en!
                                        : "",
                                    isDroped: true,
                                    onDrop: () {
                                      SelectColorCubit.get(context).getcolors();
                                      NavigationUtils.navigateTo(
                                          context: context,
                                          destinationScreen:
                                              SelectColorScreen());
                                    },
                                    validator: (value) {
                                      if (SelectColorCubit.get(context).color !=
                                          null)
                                        return "Please choose car color";
                                    },
                                  );
                                }),
                            CustomTextField(
                              label: "Car Plat Number",
                              controller: _carPlateNum,
                              validator: (value) {
                                if (addCarCubit.cars.isNotEmpty) {
                                  if (value!.isEmpty || value == null) {
                                    return 'Car Number is required';
                                  }
                                }
                              },
                            ),
                            buildDatePicker("Last Periodic Maintenance Date",
                                (newDate) {
                              if (authCubit.driver.cars == null)
                                authCubit.driver.cars = [Car()];
                              authCubit.driver.cars![0]
                                      .lastPeriodicMaintenanceDate =
                                  newDate
                                      .toString()
                                      .replaceAll(" 00:00:00.000", "");
                            }),
                            buildDatePicker("Car License Renewal Date",
                                (newDate) {
                              if (authCubit.driver.cars == null)
                                authCubit.driver.cars = [Car()];
                              authCubit.driver.cars![0].carLicenseRenewalDate =
                                  newDate
                                      .toString()
                                      .replaceAll(" 00:00:00.000", "");
                            }),
                            CustomTextField(
                              label: "Miles",
                              keyboardType: TextInputType.number,
                              controller: _miles,
                              validator: (value) {
                                if (addCarCubit.cars.isNotEmpty) {
                                  if (value!.isEmpty || value == null) {
                                    return 'Miles is required';
                                  }
                                }
                              },
                            ),
                            CustomTextField(
                              label: "Average Miles per month",
                              controller: _avgMilesPerMonth,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (addCarCubit.cars.isNotEmpty) {
                                  if (value!.isEmpty || value == null) {
                                    return 'Average Miles per Month is required';
                                  }
                                }
                              },
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () async {
                            if (validateFieldes(
                                context, authCubit, selectChoiceCubit)) {
                              Car car = Car(
                                plateNumber: _carPlateNum.text,
                                carType: CarType(
                                    sId: selectChoiceCubit
                                        .carTypeResponse!
                                        .carType![SelectChoiceCubit.get(context)
                                            .carTypeChoice]
                                        .sId),
                                color: CarColor(
                                    sId: SelectColorCubit.get(context)
                                        .carColorResponse!
                                        .carColor![
                                            SelectColorCubit.get(context).color]
                                        .sId),
                                carLicenseRenewalDate: authCubit
                                    .driver.cars![0].carLicenseRenewalDate,
                                miles: double.parse(_miles.text),
                                averageMilesPerMonth:
                                    double.parse(_avgMilesPerMonth.text),
                                lastPeriodicMaintenanceDate: authCubit.driver
                                    .cars![0].lastPeriodicMaintenanceDate,
                              );
                              Driver driver = Driver(
                                  person: Person(
                                    email: _email.text,
                                    name: _name.text,
                                    password: _password.text,
                                    role: "user",
                                    gender: genderCubit.genderInText,
                                  ),
                                  lisenceRenewalDate:
                                      authCubit.driver.lisenceRenewalDate,
                                  phoneNumber: _phoneNumber.text,
                                  cars: [car]);
                              print(driver.toSignupJson());
                              await authCubit.driverSignUp(driver);

                              if (authCubit.state is SignUpSuccessState) {
                                var snackBar = SnackBar(
                                    content: Text(
                                        "Welcome to vewww plaese Check your email"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                NavigationUtils.navigateAndClearStack(
                                    context: context,
                                    destinationScreen: SignInScreen());
                              } else if (state is SignUpErrorState) {
                                var snackBar =
                                    SnackBar(content: Text(state.errMessage));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          },
                          child: BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is SignUpLoadingState)
                                return const CircularProgressIndicator();
                              else
                                return const Text("Sign Up");
                            },
                          ),
                        );
                      })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: AppTextStyle.greyStyle(size: 14),
                      ),
                      TextButton(
                        child: Text("Login",
                            style: AppTextStyle.titleTextStyle(14)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Divider(
                        color: Color.fromARGB(255, 151, 151, 151),
                        thickness: 1,
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          "OR",
                          style: AppTextStyle.greyStyle(size: 12),
                        ),
                      ),
                      const Expanded(
                          child: Divider(
                        color: Color.fromARGB(255, 151, 151, 151),
                        thickness: 1,
                      )),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Image.asset("assets/images/google.png")),
                      InkWell(
                          onTap: () async {},
                          child: Image.asset("assets/images/Facebook.png")),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  bool validateFieldes(BuildContext context, AuthCubit authCubit,
      SelectChoiceCubit selectChoiceCubit) {
    if (_formKey.currentState!.validate() &&
        SelectColorCubit.get(context).carColorResponse != null &&
        selectChoiceCubit.carTypeResponse != null &&
        selectChoiceCubit.carModelResponse != null &&
        authCubit.driver.lisenceRenewalDate != null &&
        authCubit.driver.cars![0].carLicenseRenewalDate != null &&
        authCubit.driver.cars![0].lastPeriodicMaintenanceDate != null)
      return true;
    return false;
  }

  Widget buildDatePicker(String lable, Function(DateTime) onChange) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lable,
            style: AppTextStyle.darkGreyStyle(size: 14),
          ),
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 70,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (DateTime newDateTime) {
                onChange(newDateTime);
                // controller.text =
                //     newDateTime.toString().replaceAll(" 00:00:00.000", "");
              },
            ),
          )
        ],
      ),
    );
  }
}
