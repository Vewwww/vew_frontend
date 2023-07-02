import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/model/car_type.dart';
import 'package:vewww/model/location.dart';
import 'package:vewww/model/repairer.dart';

import '../../bloc/admin_add_cubit/admin_add_cubit.dart';
import '../../bloc/select_choice_cubit/select_choice_cubit.dart';
import '../../core/components/backward_arrow.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/default_button.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';
import '../../model/name.dart';
import '../driver/select_car_type_screen.dart';

class AddMaintenanceCenterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var longitudeController = TextEditingController();
  var latitudeController = TextEditingController();
  var carTypeController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> carTypes = [
    'BMW',
    'MG',
    'Toyota',
    'Honda',
    'Jeep',
  ];

  @override
  Widget build(BuildContext context) {
    AdminAddCubit adminAddCubit = AdminAddCubit.get(context);
    SelectChoiceCubit selectChoiceCubit = SelectChoiceCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  haveBackArrow: true,
                  title: Text(
                    "Add Maintenance Center",
                    style: AppTextStyle.mainStyle(size: 25),
                  ),
                ),
                CustomTextField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    label: 'Name'),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    label: 'Phone Number'),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    controller: addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    label: 'Address'),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    controller: longitudeController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    label: 'Longitude'),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    controller: latitudeController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    label: 'Latitude'),
                //Add car type
                const SizedBox(height: 15),
                BlocConsumer<SelectChoiceCubit, SelectChoiceState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return CustomTextField(
                      label: "Car Type",
                      controller: carTypeController,
                      hint: (selectChoiceCubit.carTypeResponse != null)
                          ? selectChoiceCubit
                              .carTypeResponse!
                              .carType![
                                  SelectChoiceCubit.get(context).carTypeChoice]
                              .name!
                              .en!
                          : "",
                      isDroped: true,
                      onDrop: () {
                        selectChoiceCubit.getAllCarTypes();
                        NavigationUtils.navigateTo(
                            context: context,
                            destinationScreen: SelectCarTypeScreen());
                      },
                      validator: (value) {
                        if (selectChoiceCubit.carTypeResponse == null) {
                          return "car type is required";
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 15,),
                defaultButton(
                    function: () {
                      final form = formKey.currentState;
                      if (form!.validate() &&
                          selectChoiceCubit.carTypeResponse != null) {
                        MaintenanceCenter maintenanceCenter = MaintenanceCenter(
                            name: Name(en:nameController.text, ar: " "),
                            location: Location(
                                description: Name(en: addressController.text, ar: " "),
                                latitude: double.tryParse(latitudeController.text),
                                longitude: double.tryParse(longitudeController.text) ),
                            phoneNumber: phoneController.text,
                            carType: [
                              CarType(
                                  name: selectChoiceCubit
                                      .carTypeResponse!
                                      .carType![
                                          SelectChoiceCubit.get(context).carTypeChoice]
                                      .name!,
                                  
                                      ),
                            ]
                            
                            );
                        adminAddCubit.AddMaintenanceCenter(maintenanceCenter);
                      }
                    },
                    text: 'Add'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
