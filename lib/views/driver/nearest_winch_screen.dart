import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vewww/bloc/nearest_repairer_cubit/nearest_repairer_cubit.dart';
import 'package:vewww/bloc/request_cubit/request_cubit.dart';
import 'package:vewww/controllers/controller.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/model/requests.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';
import 'package:vewww/views/driver/requests_screen.dart';

import '../../core/components/nearest_winch_card.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/location.dart';
import '../../model/name.dart';

class NearestWinchScreen extends StatefulWidget {
  const NearestWinchScreen({super.key});

  @override
  State<NearestWinchScreen> createState() => _NearestWinchScreenState();
}

class _NearestWinchScreenState extends State<NearestWinchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final nearestRepairerCubit = context.read<NearestRepairerCubit>();
    nearestRepairerCubit.getNearestWinch();
  }

  @override
  Widget build(BuildContext context) {
    RequestCubit requestCubit = RequestCubit.get(context);
    return Scaffold(
      body: Column(children: [
        CustomAppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 25,
            color: mainColor,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DriverHomeScreen()),
                  (route) => false);
            },
          ),
          haveLogo: true,
        ),
        BlocBuilder<NearestRepairerCubit, NearestRepairerState>(
          builder: (context, state) {
            if (state is GettingNearestWinchSuccessState) {
              return Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: state.nearestWinch.length,
                  itemBuilder: (context, index) => nearestWinchCard(
                      name: state.nearestWinch[index].name!,
                      plateNumber: state.nearestWinch[index].plateNumber!,
                      rate: state.nearestWinch[index].rate!,
                      distance: state.nearestWinch[index].distance!,
                      function: () async {
                        Position position = await Controller.getLocation();
                        String address = await Controller.getAddress(position);
                        Location location = Location(
                            latitude: position.latitude,
                            description: Name(en: address, ar: address),
                            longitude: position.longitude);
                        CreateRequest createRequest = CreateRequest(
                          driver: SharedPreferencesHelper.getData(key: 'vewId'),
                          car: '6484789db6fc5a39cbe4e3d8',
                          location: location,
                          winch: state.nearestWinch[index].sId,
                        );
                        //TODO: call create winch req. here
                        requestCubit.createWinchRequest(createRequest);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => RequestScreen(
                                      isWinch: true,
                                    ))));
                      }),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ]),
    );
  }
}
