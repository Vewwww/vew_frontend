import 'package:flutter/material.dart';
import 'package:vewww/bloc/car_cubit/car_cubit.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/model/profile_response.dart';
import 'package:vewww/views/driver/edit_driver_profile.dart';
import 'package:vewww/views/driver/select_car_type_screen.dart';

import '../../bloc/select_choice_cubit/select_choice_cubit.dart';
import '../../model/car.dart';
import '../../model/driver.dart';
import '../../views/driver/select_car_model.dart';
import '../style/app_Text_Style/app_text_style.dart';
import '../style/app_colors.dart';
import 'custom_text_field.dart';

Widget buildCarDetails(Car car, index,
    {editable = false, BuildContext? context, ProfileData? driver}) {
  CarCubit carCubit = CarCubit();
  if (editable) carCubit = CarCubit.get(context);
  return Column(
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
          SelectChoiceCubit.get(context).getAllCarTypes();
          NavigationUtils.navigateAndClearStack(
              context: context!,
              destinationScreen: SelectCarTypeScreen(
                index: index - 1,
                destinationScreen:
                    EditDriverProfile(driver: driver!, inProgress: true),
              ));
        },
        label: "Car Type",
        hint: TextEditingController(
                text: (car.carType != null) ? car.carType!.name!.en ?? "" : "")
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
          if (carCubit.editedCars![index - 1].carType != null) {
            NavigationUtils.navigateAndClearStack(
                context: context!,
                destinationScreen: SelectCarModelScreen(
                  index: index - 1,
                  id: carCubit.editedCars![index - 1].carType!.sId!,
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
      (editable)
          ? CustomTextField(
              label: "Last Periodic Maintenance Date",
              controller: TextEditingController(
                  text: car.lastPeriodicMaintenanceDate ?? ""),
              validator: (value) {},
            )
          : Container(),
      CustomTextField(
        readOnly: !editable,
        label: "Plate Number",
        controller: TextEditingController(text: car.plateNumber ?? ""),
        validator: (value) {},
      ),
      (editable)
          ? CustomTextField(
              label: "License renewal date",
              controller:
                  TextEditingController(text: car.carLicenseRenewalDate ?? ""),
              validator: (value) {},
              onChanged: (value) {
                carCubit.editedCars![index - 1].carLicenseRenewalDate = value;
              },
            )
          : Container(),
      (editable)
          ? CustomTextField(
              label: "Current Miles",
              controller: TextEditingController(text: car.miles),
              validator: (value) {},
              onChanged: (value) {
                carCubit.editedCars![index - 1].miles = value;
              },
            )
          : Container(),
      (editable)
          ? CustomTextField(
              label: "Average Mile per Week ",
              controller:
                  TextEditingController(text: car.averageMilesPerMonth ?? " "),
              validator: (value) {},
              onChanged: (value) {
                carCubit.editedCars![index - 1].averageMilesPerMonth = value;
              },
            )
          : Container(),
      // (editable)
      //     ? CustomTextField(
      //         readOnly: true,
      //         label: "Remind you before",
      //         //TODO::chech with back
      //         controller: TextEditingController(text: ""),
      //         validator: (value) {},
      //       )
      //     : Container(),
    ],
  );
}
