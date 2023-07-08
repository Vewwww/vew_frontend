import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/car_cubit/car_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/views/driver/driver_profile.dart';
import '../../bloc/select_color_cubit/select_color_cubit.dart';
import '../../core/components/build_car.dart';
import '../../core/components/custom_text_field.dart';
import '../../bloc/select_choice_cubit/select_choice_cubit.dart';
import '../../model/car.dart';
import '../common/select_car_model.dart';
import '../common/select_car_type_screen.dart';
import '../common/select_color_screen.dart';

class AddCarScreen extends StatefulWidget {
  String driverId;
  AddCarScreen(this.driverId, {Key? key}) : super(key: key);

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final TextEditingController _carType = TextEditingController();

  final TextEditingController _carModel = TextEditingController();

  final TextEditingController _carPlateNum = TextEditingController();

  final TextEditingController _year = TextEditingController();

  final TextEditingController _carColor = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _miles = TextEditingController();

  final TextEditingController _avgMilesPerMonth = TextEditingController();

  late Car car;
  @override
  void initState() {
    super.initState();
    car = Car();
  }

  @override
  Widget build(BuildContext context) {
    SelectChoiceCubit selectChoiceCubit = SelectChoiceCubit.get(context);
    CarCubit carCubit = CarCubit.get(context);

    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  const SizedBox(height: 10),
                  CustomAppBar(
                    title: Text(
                      "Add Car",
                      style: AppTextStyle.mainStyle(),
                    ),
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: mainColor,
                      ),
                      onPressed: () {
                        NavigationUtils.navigateAndClearStack(
                            context: context,
                            destinationScreen: DriverProfile());
                      },
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        BlocConsumer<SelectChoiceCubit, SelectChoiceState>(
                            listener: (context, snapshot) {},
                            builder: (context, snapshot) {
                              return Column(
                                children: [
                                  CustomTextField(
                                    label: "Car Type",
                                    controller: _carType,
                                    hint: (selectChoiceCubit.carTypeResponse !=
                                            null)
                                        ? selectChoiceCubit
                                            .carTypeResponse!
                                            .carType![
                                                SelectChoiceCubit.get(context)
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
                                              SelectCarTypeScreen(
                                            destinationScreen:
                                                AddCarScreen(widget.driverId),
                                          ));
                                    },
                                    validator: (value) {
                                      if (_carType == null) {
                                        return "car type is required";
                                      }
                                    },
                                  ),
                                  CustomTextField(
                                    label: "Car Model",
                                    controller: _carModel,
                                    hint: (selectChoiceCubit.carModelResponse !=
                                                null &&
                                            selectChoiceCubit.carModelResponse!
                                                .carModels!.isNotEmpty)
                                        ? selectChoiceCubit
                                            .carModelResponse!
                                            .carModels![
                                                SelectChoiceCubit.get(context)
                                                    .carModelChoice]
                                            .name!
                                        : "",
                                    isDroped: true,
                                    onDrop: () {
                                      if (selectChoiceCubit.carTypeResponse !=
                                          null) {
                                        String id = selectChoiceCubit
                                            .carTypeResponse!
                                            .carType![
                                                selectChoiceCubit.carTypeChoice]
                                            .sId!;
                                        selectChoiceCubit.getAllCarModels(id);
                                        NavigationUtils.navigateTo(
                                            context: context,
                                            destinationScreen:
                                                SelectCarModelScreen(id: id));
                                      } else {
                                        const snackBar = SnackBar(
                                            content: Text(
                                                "Please chose car type first!"));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    },
                                    validator: (value) {
                                      if (selectChoiceCubit.carTypeResponse ==
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
                                            SelectColorCubit.get(context).color]
                                        .name!
                                        .en!
                                    : "",
                                isDroped: true,
                                onDrop: () {
                                  SelectColorCubit.get(context).getcolors();
                                  NavigationUtils.navigateTo(
                                      context: context,
                                      destinationScreen: SelectColorScreen());
                                },
                                validator: (value) {
                                  return "Please choose car color";
                                },
                              );
                            }),
                        CustomTextField(
                          label: "Car Plat Number",
                          controller: _carPlateNum,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Car Number is required';
                            }
                          },
                        ),
                        CustomTextField(
                          label: "Year",
                          controller: _year,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Car year is required';
                            }
                          },
                        ),
                        buildDatePicker("Last Periodic Maintenance Date",
                            (newDate) {
                          car.lastPeriodicMaintenanceDate = newDate
                              .toString()
                              .replaceAll(" 00:00:00.000", "");
                        }),
                        buildDatePicker("Car License Renewal Date", (newDate) {
                          car.carLicenseRenewalDate = newDate
                              .toString()
                              .replaceAll(" 00:00:00.000", "");
                        }),
                        CustomTextField(
                          label: "Miles",
                          keyboardType: TextInputType.number,
                          controller: _miles,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Miles is required';
                            }
                          },
                        ),
                        CustomTextField(
                          label: "Average Miles per month",
                          controller: _avgMilesPerMonth,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Average Miles per Month is required';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: BlocBuilder<CarCubit, CarState>(
                        builder: (context, state) {
                      return defaultButton(
                          text: (state is AddCarLoadingState)
                              ? "Loading..."
                              : "Add",
                          function: () async {
                            if (_formKey.currentState!.validate()) {
                              if (selectChoiceCubit.carModelResponse != null &&
                                  selectChoiceCubit.carTypeResponse != null) {
                                if (car.lastPeriodicMaintenanceDate != null) {
                                  if (car.carLicenseRenewalDate != null) {
                                    if (SelectColorCubit.get(context)
                                            .carColorResponse !=
                                        null) {
                                      car.averageMilesPerMonth =
                                          double.parse(_avgMilesPerMonth.text);
                                      car.miles = double.parse(_miles.text);
                                      car.owner = widget.driverId;
                                      car.year = _year.text;
                                      car.carType = selectChoiceCubit
                                              .carTypeResponse!.carType![
                                          selectChoiceCubit.carTypeChoice];
                                      car.carModel = selectChoiceCubit
                                              .carModelResponse!.carModels![
                                          selectChoiceCubit.carModelChoice];
                                      car.color = SelectColorCubit.get(context)
                                              .carColorResponse!
                                              .carColor![
                                          SelectColorCubit.get(context).color];
                                      car.plateNumber = _carPlateNum.text;

                                      await carCubit.add(car);
                                      if (state is AddCarSuccessState) {
                                        NavigationUtils.navigateAndClearStack(
                                            context: context,
                                            destinationScreen: DriverProfile());
                                      } else {
                                        const snackBar = SnackBar(
                                            content: Text(
                                                "something went wrong try againب"));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    } else {
                                      const snackBar = SnackBar(
                                          content:
                                              Text("car color is required"));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  } else {
                                    const snackBar = SnackBar(
                                        content: Text(
                                            "Car licence renewal date is required"));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                } else {
                                  const snackBar = SnackBar(
                                      content: Text(
                                          "Last periodic maintenance date is required"));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            } else {
                              const snackBar = SnackBar(
                                  content: Text(
                                      "car type and car model are required"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          });
                    }),
                  )
                ]))));
  }
}
