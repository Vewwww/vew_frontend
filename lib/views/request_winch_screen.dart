import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/views/driver_home_screen.dart';
import 'package:vewww/views/loading_winch_screen.dart';

import '../core/components/backward_arrow.dart';
import '../core/utils/navigation.dart';

class RequestWinchScreen extends StatefulWidget {
  @override
  State<RequestWinchScreen> createState() => _RequestWinchScreenState();
}

class _RequestWinchScreenState extends State<RequestWinchScreen> {
  //const RequestWinchScreen({Key? key}) : super(key: key);
  bool isLoading = false;
  List<Placemark>? placemark;
  loc.LocationData? locationData;
  late double latitude;
  late double longitude;

  void getPermission() async {
    if (await Permission.location.isGranted) {
      getLocation();
      if (locationData != null) {
        latitude = locationData!.latitude!;
        longitude = locationData!.longitude!;
      }
    } else {
      Permission.location.request();
    }
  }

  void getLocation() async {
    setState(() {
      isLoading = true;
    });
    locationData = await loc.Location.instance.getLocation();
    setState(() {
      isLoading = false;
    });
  }

  void getAddress() async {
    setState(() {
      isLoading = true;
    });
    if (locationData != null) {
      placemark = await placemarkFromCoordinates(
          locationData!.latitude!, locationData!.longitude!);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackwardArrow(function: () {
          NavigationUtils.navigateTo(
              context: context, destinationScreen: DriverHomeScreen());
        }),
        title: Center(
          child: Text(
            'Winch Request',
            style: AppTextStyle.mainStyle(size: 25),
          ),
        ),
      ),
      body: isLoading
          ? Center(
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
                  Container(
                    width: 350,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(
                          color: Color.fromRGBO(2, 113, 106, 1),
                        )),
                    child: Row(
                      children: [
                        Text(
                          placemark != null
                              ? "${placemark![0].street} ${placemark![0].locality} ${placemark![0].administrativeArea} ${placemark![0].country}"
                              : " ",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultButton(
                      text: 'Current Location',
                      buttonIcon: Icons.location_on,
                      background: Colors.grey.shade100,
                      textColor: Color.fromRGBO(2, 113, 106, 1),
                      width: 300,
                      function: () {
                        getPermission();
                        getAddress();
                      }),
                  defaultButton(
                      text: 'Request',
                      width: 300,
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const LoadingWinchScreen())));
                      }),
                ],
              ),
            ),
    );
  }
}
