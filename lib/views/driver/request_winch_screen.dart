import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/loaction_cubit/loaction_cubit.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';
import 'package:vewww/views/driver/loading_winch_screen.dart';
import '../../core/components/backward_arrow.dart';
import '../../core/utils/navigation.dart';
import '../common/map.dart';

class RequestWinchScreen extends StatelessWidget {


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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset('assets/images/Logo(1).png',height: 170,width:200 ,)),
                  Text(
                    'Please enter your current location here: ',
                    style: AppTextStyle.darkGreyStyle(size: 18),
                  ),
                  const SizedBox(height: 10,),
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
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
                  const SizedBox(height: 15,),
                  BlocConsumer<LocationCubit, LocationState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return defaultButton(
                          text: 'Next',
                          // width: 300,
                          function: () {
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
