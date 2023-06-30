import 'package:flutter/material.dart';
import 'package:vewww/bloc/loaction_cubit/loaction_cubit.dart';

import '../../core/utils/navigation.dart';
import 'map.dart';

class MapScreen extends StatelessWidget {
  MapScreen({required this.locationCubit, Key? key}) : super(key: key);
  LocationCubit locationCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: MapElement(
            locationCubit: locationCubit,
          )),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  NavigationUtils.navigateBack(context: context);
                },
                child: const Text("تم"),
              ))
        ],
      ),
    );
  }
}
