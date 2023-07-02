import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/car_cubit/car_cubit.dart';
import 'package:vewww/bloc/profile_cubit/profile_cubit.dart';
import 'package:vewww/views/driver/select_car_model.dart';
import 'package:vewww/views/driver/select_car_type_screen.dart';

import '../../bloc/add_car_cubit/add_car_cubit.dart';
import '../../bloc/gender_cubit/gender_cubit.dart';
import '../../bloc/reminder_cubit/reminder_cubit.dart';
import '../../bloc/select_choice_cubit/select_choice_cubit.dart';
import '../../bloc/select_color_cubit/select_color_cubit.dart';
import '../../core/components/build_car.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/logo.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/style/app_colors.dart';
import '../../core/utils/navigation.dart';
import '../../model/car.dart';
import '../../model/car_type.dart';
import '../../model/driver.dart';
import '../../model/profile_response.dart';
import 'driver_home_screen.dart';
import '../common/select_color_screen.dart';

class EditDriverProfile extends StatefulWidget {
  String? color;
  bool inProgress;
  ProfileData driver;

  EditDriverProfile(
      {required this.driver, this.inProgress = false, this.color, Key? key})
      : super(key: key) {
    print("from edit const ${driver.toJson()}");
  }

  @override
  State<EditDriverProfile> createState() => _EditDriverProfileState(driver);
}

class _EditDriverProfileState extends State<EditDriverProfile> {
  String? carType;
  ProfileData driver;
  bool inProgress;

  _EditDriverProfileState(this.driver, {this.inProgress = false}) {
    print("from state const ${driver.user.toString()}");
    print("from state const ${driver.user.toString()}");
    _email.text = driver.user!.email!;
    _name.text = driver.user!.name!;
    _phone.text = driver.user!.phoneNumber!;
  }
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _name = TextEditingController();

  final TextEditingController _licenseRenewalDate = TextEditingController();

  final TextEditingController _phone = TextEditingController();
  @override
  void initState() {
    super.initState();
    var genderCubit = context.read<GenderCubit>();
    int c = (widget.driver.user!.gender == "male") ? 1 : 0;
    genderCubit.choseGender(c);
    if (!inProgress) {
      var carCubit = context.read<CarCubit>();
      carCubit.currentCars = (driver.cars != null) ? driver.cars! : [];
      carCubit.editedCars = (driver.cars != null) ? driver.cars! : [];
    }
  }

  @override
  Widget build(BuildContext context) {
    var constraintsHight = MediaQuery.of(context).size.height;
    AddCarCubit addCarCubit = AddCarCubit.get(context);
    CarCubit carCubit = CarCubit.get(context);
    GenderCubit genderCubit = GenderCubit.get(context);
    ReminderCubit reminderCubit = ReminderCubit.get(context);
    SelectChoiceCubit selectChoiceCubit = SelectChoiceCubit.get(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                    controller: _licenseRenewalDate,
                    keyboardType: TextInputType.number,
                    validator: (value) {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            carCubit.add();
                          },
                          child: Text(
                            "Add car",
                            style: AppTextStyle.mainStyle(size: 13),
                          )),
                      Text("Cars"),
                    ],
                  ),
                  BlocBuilder<CarCubit, CarState>(builder: (context, state) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: carCubit.editedCars!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildCarDetails(
                            carCubit.editedCars![index], index + 1,
                            editable: true, context: context, driver: driver);
                      },
                    );
                  }),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          for (Car car in carCubit.editedCars!)
                            print(car.toJson());
                          if (_formKey.currentState!.validate()) {
                            ProfileData p = driver;
                            p.user!.name = _name.text;
                            p.user!.email = _email.text;
                            p.user!.phoneNumber = _phone.text;
                            p.user!.gender = genderCubit.genderInText;
                            if (_licenseRenewalDate.text != null)
                              p.user!.driverLisenceRenewalNotification =
                                  _licenseRenewalDate.text;
                            p.cars = carCubit.editedCars;
                            print("p.toJson():${p.toJson()}");
                            ProfileCubit profileCubit =
                                ProfileCubit.get(context);
                            await profileCubit.EditDriverProfile({
                              "name": _name.text,
                              "phoneNumber": _phone.text,
                              "gender": genderCubit.genderInText,
                              "driverLisenceRenewalDate":
                                  ((_licenseRenewalDate.text != null))
                                      ? "2023-09-1"
                                      : null
                            });
                            await carCubit.handleCarEdit();
                            // NavigationUtils.navigateAndClearStack(
                            //     context: context,
                            //     destinationScreen: const DriverHomeScreen());
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
