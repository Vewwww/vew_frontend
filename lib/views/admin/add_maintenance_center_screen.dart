import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/loaction_cubit/loaction_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/model/car_type.dart';
import 'package:vewww/model/location.dart';
import 'package:vewww/model/repairer.dart';
import 'package:vewww/views/admin/admin_home_screen.dart';
import '../../bloc/admin_add_cubit/admin_add_cubit.dart';
import '../../bloc/select_choice_cubit/select_choice_cubit.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/default_button.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';
import '../../model/name.dart';
import '../common/map_screen.dart';
import '../common/select_car_type_screen.dart';

class AddMaintenanceCenterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var arabicAddress = TextEditingController();
  var arabicName = TextEditingController();
  var carTypeController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AdminAddCubit adminAddCubit = AdminAddCubit.get(context);
    SelectChoiceCubit selectChoiceCubit = SelectChoiceCubit.get(context);
    LocationCubit locationCubit = LocationCubit.get(context);
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
                    controller: arabicName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    label: 'Arabic Name'),
                CustomTextField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    label: 'English Name'),
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
                    label: 'English Address'),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    controller: arabicAddress,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    label: 'Arabic Address'),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Location"),
                    IconButton(
                        onPressed: () {
                          NavigationUtils.navigateTo(
                              context: context,
                              destinationScreen: MapScreen(
                                locationCubit: locationCubit,
                              ));
                        },
                        icon: Icon(Icons.location_on)),
                    Expanded(child: Container()),
                  ],
                ),
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
                SizedBox(
                  height: 15,
                ),
                defaultButton(
                    function: () async {
                      final form = formKey.currentState;
                      if (form!.validate() &&
                          selectChoiceCubit.carTypeResponse != null) {
                        MaintenanceCenter maintenanceCenter = MaintenanceCenter(
                            name: Name(
                                en: nameController.text, ar: arabicName.text),
                            location: Location(
                                description: Name(
                                    en: addressController.text,
                                    ar: arabicAddress.text),
                                latitude: locationCubit.lat,
                                longitude: locationCubit.long),
                            phoneNumber: phoneController.text,
                            carType: [
                              selectChoiceCubit.carTypeResponse!.carType![
                                  SelectChoiceCubit.get(context).carTypeChoice]
                            ]);
                        await adminAddCubit
                            .addMaintenanceCenter(maintenanceCenter);
                        NavigationUtils.navigateAndClearStack(
                            context: context,
                            destinationScreen: AdminHomeScreen());
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
