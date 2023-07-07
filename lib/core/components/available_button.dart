import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/profile_cubit/profile_cubit.dart';
import 'package:vewww/core/style/app_colors.dart';

class AvailableButton extends StatelessWidget {
  AvailableButton({Key? key}) : super(key: key);

  bool value = false;
  String title = "Not Available";
  Color color = Colors.grey;
  @override
  Widget build(BuildContext context) {
    var cubit = ProfileCubit.get(context);
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          children: [
            Switch(
                activeColor: mainColor,
                value: cubit.isWinchAvailable,
                onChanged: (bool state) {
                  cubit.updateWinchState(state);
                }),
            Text(
              cubit.isWinchAvailable ? "متاح" : "مشغول",
              style: TextStyle(
                  color: cubit.isWinchAvailable ? mainColor : Colors.grey,
                  fontSize: 15),
            ),
            const SizedBox(width: 7),
          ],
        );
      },
    );
  }
}
