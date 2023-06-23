import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:vewww/bloc/loaction_cubit/loaction_cubit.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';
import 'package:vewww/views/driver/loading_winch_screen.dart';

import '../../core/components/backward_arrow.dart';
import '../../core/utils/navigation.dart';
import '../common/map.dart';

class RequestWinchScreen extends StatelessWidget {
  //const RequestWinchScreen({Key? key}) : super(key: key);
  // bool isLoading = false;
  // List<Placemark>? placemark;
  // loc.LocationData? locationData;
  // late double latitude;
  // late double longitude;

  // Future <void> getPermission() async {
  //   if (await Permission.location.isGranted) {
  //    await getLocation();
  //     if (locationData != null) {
  //       latitude = locationData!.latitude!;
  //       longitude = locationData!.longitude!;
  //     }
  //   } else {
  //     Permission.location.request();
  //   }
  // }

  // Future <void> getLocation() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   locationData = await loc.Location.instance.getLocation();
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // void getAddress() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   if (locationData != null) {
  //     placemark = await placemarkFromCoordinates(
  //         locationData!.latitude!, locationData!.longitude!);
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    LocationCubit loactionCubit = LocationCubit.get(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackwardArrow(function: () {
          NavigationUtils.navigateTo(
              context: context, destinationScreen: const DriverHomeScreen());
        }),
        title: Center(
          child: Text(
            'Winch Request',
            style: AppTextStyle.mainStyle(size: 25),
          ),
        ),
      ),
      body: loactionCubit.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    'Current Location',
                    style: AppTextStyle.boldStyle(size: 20),
                  ),
                  Text(
                    'Please enter your current location here',
                    style: AppTextStyle.darkGreyStyle(size: 15),
                  ),
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                      //height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(
                            color: const Color.fromRGBO(2, 113, 106, 1),
                          )),
                      child: BlocConsumer<LocationCubit, LocationState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Text(
                              // loactionCubit.placemark != null
                              //     ? "${loactionCubit.placemark![0].street} ${loactionCubit.placemark![0].locality} ${loactionCubit.placemark![0].administrativeArea} ${loactionCubit.placemark![0].country}"
                              //     : " ",
                              loactionCubit.address,
                              overflow: TextOverflow.ellipsis);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                      height: 250,
                      child: MapElement(
                        locationCubit: loactionCubit,
                      )),
                  const SizedBox(height: 15),
                  // defaultButton(
                  //     text: 'Current Location',
                  //     buttonIcon: Icons.location_on,
                  //     background: Colors.grey.shade100,
                  //     textColor: const Color.fromRGBO(2, 113, 106, 1),
                  //     width: 300,
                  //     function: () async {
                  //       await loactionCubit.getPermission();
                  //       loactionCubit.getAddress();
                  //     }),
                  BlocConsumer<LocationCubit, LocationState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return defaultButton(
                          text: 'Request',
                          width: 300,
                          function: () {
                            print(loactionCubit.address);
                            print(
                                ("lat = ${loactionCubit.lat.toString()} , \nlon = ${loactionCubit.longitude.toString()}"));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const LoadingWinchScreen())));
                          });
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
