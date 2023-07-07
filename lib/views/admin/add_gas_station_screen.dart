import 'package:flutter/material.dart';
import 'package:vewww/bloc/loaction_cubit/loaction_cubit.dart';
import 'package:vewww/model/name.dart';
import 'package:vewww/model/repairer.dart';
import '../../bloc/admin_add_cubit/admin_add_cubit.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/default_button.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';
import '../../model/location.dart';
import '../common/map_screen.dart';

class AddGasStationScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var arabicName = TextEditingController();
  var addressController = TextEditingController();
  var arabicAddress = TextEditingController();
  var latitudeController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AdminAddCubit adminAddCubit = AdminAddCubit.get(context);
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
                    "Add Gas Station",
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
                    label: 'English Name'),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    controller: arabicName,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    label: 'Arabic Name'),
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
                // CustomTextField(
                //     controller: latitudeController,
                //     keyboardType: TextInputType.phone,
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return '*Required';
                //       }
                //       return null;
                //     },
                //     label: 'Latitude'),
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
                const SizedBox(height: 15),
                defaultButton(
                    function: () {
                      final form = formKey.currentState;
                      if (form!.validate()) {
                        GasStation gasStation = GasStation(
                          name: Name(
                            en: nameController.text,
                            ar: arabicName.text,
                          ),
                          location: Location(
                              description:
                                  Name(en: addressController.text, ar: arabicAddress.text),
                              latitude: locationCubit.lat,
                              longitude: locationCubit.long),
                        );
                        adminAddCubit.AddGasStation(gasStation);
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
