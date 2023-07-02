import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/get_all_cubit/get_all_cubit.dart';
import 'package:vewww/bloc/request_cubit/request_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/previous_request_card.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';
import 'package:vewww/views/driver/single_previous_request.dart';

import '../../bloc/loaction_cubit/loaction_cubit.dart';

class PreviousReqScreen extends StatefulWidget {
  const PreviousReqScreen({super.key});

  @override
  State<PreviousReqScreen> createState() => _PreviousReqScreenState();
}

class _PreviousReqScreenState extends State<PreviousReqScreen> {
  @override
  void initState() {
    super.initState();
    final requestCubit = context.read<RequestCubit>();
    requestCubit.getDriverPrevReq();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: mainColor,
                size: 20,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => DriverHomeScreen())));
              },
            ),
            title: Text(
              'Previous Requests',
              style: AppTextStyle.mainStyle(size: 25),
            ),
          ),
          BlocBuilder<RequestCubit, RequestState>(
            builder: (context, state) {
              if (state is GetDriverPrevReqSuccessState) {
                return Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        if (state.previousRequests[index].isWinch!) {
                          previousRequestCard(
                              isWinch: state.previousRequests[index].isWinch!,
                              location: state.previousRequests[index].location!
                                  .description!.en!,
                              dateTime:
                                  state.previousRequests[index].createdAt!,
                              serviceProvider:
                                  state.previousRequests[index].winch!.name!,
                              function: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            SinglePreviousRequest(
                                              location: state
                                                  .previousRequests[index]
                                                  .location!
                                                  .description!
                                                  .en!,
                                              dateTime: state.previousRequests[index].createdAt!,
                                              carType: state.previousRequests[index].car!.carType!.name!.en!,
                                              serviceProviderName: state.previousRequests[index].winch!.name!,
                                              rating: state.previousRequests[index].winch!.rate!,
                                              thirdInfo: state.previousRequests[index].winch!.plateNumber!,
                                              isWinch: true,
                                              id: state.previousRequests[index].winch!.sId!,
                                            ))));
                              });
                        } else {
                          previousRequestCard(
                              isWinch: state.previousRequests[index].isWinch!,
                              location: state.previousRequests[index].location!
                                  .description!.en!,
                              dateTime:
                                  state.previousRequests[index].createdAt!,
                              serviceProvider:
                                  state.previousRequests[index].mechanic!.name!,
                              function: () {
                                 Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            SinglePreviousRequest(
                                              location: state
                                                  .previousRequests[index]
                                                  .location!
                                                  .description!
                                                  .en!,
                                              dateTime: state.previousRequests[index].createdAt!,
                                              carType: state.previousRequests[index].car!.carType!.name!.en!,
                                              serviceProviderName: state.previousRequests[index].mechanic!.name!,
                                              rating: state.previousRequests[index].mechanic!.rate!,
                                              thirdInfo: state.previousRequests[index].mechanic!.service!,
                                              isWinch: false,
                                              id: state.previousRequests[index].mechanic!.sId!,
                                            ))));
                              });
                        }
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                      itemCount: state.previousRequests.length),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
