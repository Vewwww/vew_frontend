import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/repairer_requests_cubit.dart/repairer_requests_cubit.dart';
import 'package:vewww/core/components/rating_bar.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/model/accepted_requests_response.dart';
import 'package:vewww/views/mechanic/mechanic_home_screen.dart';
import '../../views/winch/single_request_screen.dart';
import '../style/app_text_style/app_text_style.dart';
import '../utils/navigation.dart';

class ComingRequestCard extends StatelessWidget {
  ComingRequestCard({this.mechanicRequestsData, Key? key}) : super(key: key);
  MechanicRequestsData? mechanicRequestsData;

  @override
  Widget build(BuildContext context) {
    RepairerRequestsCubit requestsCubit = RepairerRequestsCubit.get(context);
    return InkWell(
        onTap: () {
          NavigationUtils.navigateTo(
              context: context,
              destinationScreen: SingleRequestScreen(
                mechanicRequestsData!,
                type: "comming",
              ));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      (mechanicRequestsData != null)
                          ? mechanicRequestsData!.driver!.person!.name!
                          : "winchRequestsData!.driver!.person!.name!",
                      style: AppTextStyle.titleTextStyle(20),
                    ),
                    Text(
                      " السيارة : ${(mechanicRequestsData != null) ? mechanicRequestsData!.car!.carType!.name!.ar! : 'winchRequestsData!.car!.carType!.name!.ar!'}",
                      style: AppTextStyle.darkGreyStyle(size: 13),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                            ),
                            onPressed: () {
                              if (mechanicRequestsData != null) {
                                requestsCubit.mechanicCancelRequest(
                                    mechanicRequestsData!.sId!);
                              }
                            },
                            child: const Text(
                              "رفض",
                              style: TextStyle(color: Colors.white),
                            )),
                        BlocBuilder<RepairerRequestsCubit,
                            RepairerRequestsState>(
                          builder: (context, state) {
                            return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor,
                                ),
                                onPressed: () async {
                                  if (mechanicRequestsData != null) {
                                    await requestsCubit.mechanicAcceptRequest(
                                        mechanicRequestsData!.sId!);
                                    if (state is AcceptingRequestSuccessState)
                                      NavigationUtils.navigateAndClearStack(
                                          context: context,
                                          destinationScreen:
                                              MechanicHomeScreen());
                                  }
                                },
                                child: const Text(
                                  "قبول",
                                  style: TextStyle(color: Colors.white),
                                ));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 140,
                height: 140,
                margin: const EdgeInsets.fromLTRB(16, 7, 0, 3),
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: const Icon(
                  Icons.car_repair,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ));
  }
}
