import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vewww/bloc/car_cubit/car_cubit.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/model/profile_response.dart';
import 'package:vewww/views/driver/edit_driver_profile.dart';
import 'package:vewww/views/driver/select_car_type_screen.dart';

import '../../bloc/select_choice_cubit/select_choice_cubit.dart';
import '../../bloc/select_color_cubit/select_color_cubit.dart';
import '../../model/car.dart';
import '../../views/common/select_color_screen.dart';
import '../../views/driver/select_car_model.dart';
import '../style/app_Text_Style/app_text_style.dart';
import '../style/app_colors.dart';
import 'custom_text_field.dart';

Widget buildCarDetails(Car car, index,
    {GlobalKey<FormState>? formKey,
    editable = false,
    BuildContext? context,
    ProfileData? driver}) {
  CarCubit carCubit = CarCubit();
  if (editable) carCubit = CarCubit.get(context);
  return Form(
    //key: formKey ?? GlobalKey(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          thickness: 1,
        ),
        Center(
            child: CircleAvatar(
                radius: 30,
                backgroundColor: mainColor.withOpacity(0.3),
                child: const Icon(Icons.drive_eta,
                    size: 30, color: Colors.black //car.color,
                    ))),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Car $index",
              style: AppTextStyle.darkGreyStyle(size: 14),
            ),
            (editable)
                ? IconButton(
                    onPressed: () {
                      carCubit.remove(car);
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      size: 18,
                      color: Colors.red,
                    ))
                : Container()
          ],
        ),
        CustomTextField(
          readOnly: true,
          isDroped: editable,
          onDrop: () {
            SelectColorCubit.get(context).getcolors();
            NavigationUtils.navigateAndClearStack(
                context: context!,
                destinationScreen: SelectColorScreen(
                  index: index - 1,
                  driver: driver!,
                  destinationScreen: EditDriverProfile(
                    driver: driver,
                  ),
                ));
          },
          label: "Car color",
          hint: TextEditingController(
                  text: (car.color != null && car.color!.name != null)
                      ? car.color!.name!.en ?? ""
                      : "")
              .text,
          validator: (value) {
            if (SelectColorCubit.get(context).color == null)
              return "Please choose car color";
          },
        ),
        CustomTextField(
          readOnly: true,
          isDroped: editable,
          onDrop: () {
            SelectChoiceCubit.get(context).getAllCarTypes();
            NavigationUtils.navigateAndClearStack(
                context: context!,
                destinationScreen: SelectCarTypeScreen(
                  index: index - 1,
                  driver: driver!,
                  destinationScreen: EditDriverProfile(
                    driver: driver,
                  ),
                ));
          },
          label: "Car Type",
          hint: TextEditingController(
                  text:
                      (car.carType != null) ? car.carType!.name!.en ?? "" : "")
              .text,
          validator: (value) {
            if (SelectChoiceCubit.get(context).carTypeChoice == null)
              return "Please choose car type";
          },
        ),
        CustomTextField(
          readOnly: true,
          label: "Car Model",
          hint: TextEditingController(
                  text: (car.carModel != null) ? car.carModel!.name ?? "" : "")
              .text,
          isDroped: editable,
          onDrop: () {
            if (carCubit.updatedCars![index - 1].carType != null) {
              NavigationUtils.navigateAndClearStack(
                  context: context!,
                  destinationScreen: SelectCarModelScreen(
                    index: index - 1,
                    id: carCubit.updatedCars![index - 1].carType!.sId!,
                    destinationScreen:
                        EditDriverProfile(driver: driver!, inProgress: true),
                  ));
            } else {
              const snackBar =
                  SnackBar(content: Text("Please chose car type first!"));
              ScaffoldMessenger.of(context!).showSnackBar(snackBar);
            }
          },
          validator: (value) {
            if (SelectChoiceCubit.get(context).carModelChoice == null &&
                SelectChoiceCubit.get(context).carModelResponse != null &&
                SelectChoiceCubit.get(context)
                        .carModelResponse!
                        .carModels!
                        .length >
                    0) return "Please choose car type";
          },
        ),
        CustomTextField(
          label: "Year",
          readOnly: !editable,
          onChanged: (value) {
            carCubit.updatedCars![index - 1].year = value;
          },
          controller: TextEditingController(text: car.year ?? ""),
          validator: (value) {
            if (value == null) return ("year is required");
          },
        ),
        CustomTextField(
          readOnly: !editable,
          onChanged: (value) {
            carCubit.updatedCars![index - 1].plateNumber = value;
          },
          label: "Plate Number",
          controller: TextEditingController(text: car.plateNumber ?? ""),
          validator: (value) {
            if (value == null) return ("Plate Number is required");
          },
        ),
        (editable)
            ? buildDatePicker("Last Periodic Maintenance Date", (newDate) {
                carCubit.updatedCars![index - 1].lastPeriodicMaintenanceDate =
                    newDate.toString().replaceAll(" 00:00:00.000", "");
              })
            : Container(),
        (editable)
            ? buildDatePicker("Car License Renewal Date", (newDate) {
                carCubit.updatedCars![index - 1].carLicenseRenewalDate =
                    newDate.toString().replaceAll(" 00:00:00.000", "");
              })
            : Container(),
        (editable)
            ? CustomTextField(
                label: "Current Miles",
                controller: TextEditingController(
                    text: (car.miles != null) ? car.miles.toString() : ""),
                validator: (value) {
                  if (value == null) return ("Current Miles is required");
                },
                onChanged: (value) {
                  carCubit.updatedCars![index - 1].miles = double.parse(value);
                },
              )
            : Container(),
        (editable)
            ? CustomTextField(
                label: "Average Mile per Week ",
                controller: TextEditingController(
                    text: (car.averageMilesPerMonth != null)
                        ? car.averageMilesPerMonth.toString()
                        : ""),
                validator: (value) {
                  if (value == null)
                    return ("Average Mile per Week is required");
                },
                onChanged: (value) {
                  carCubit.updatedCars![index - 1].averageMilesPerMonth =
                      double.parse(value);
                },
              )
            : Container(),
      ],
    ),
  );
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
