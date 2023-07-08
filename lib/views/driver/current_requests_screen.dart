import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/horizontal_line.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';
import '../../bloc/request_cubit/request_cubit.dart';
import '../../core/components/empty_requests.dart';
import '../../core/components/request_card.dart';

class CurrentRequestsScreen extends StatefulWidget {
  CurrentRequestsScreen({super.key});

  @override
  State<CurrentRequestsScreen> createState() => _CurrentRequestsScreenState();
}

class _CurrentRequestsScreenState extends State<CurrentRequestsScreen> {
  _CurrentRequestsScreenState();
  @override
  void initState() {
    super.initState();
    final requestCubit = context.read<RequestCubit>();
    requestCubit.getDriverCurrentReq();
  }

  @override
  Widget build(BuildContext context) {
    RequestCubit requestCubit = RequestCubit.get(context);
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomAppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DriverHomeScreen()),
                  (route) => false);
            },
            iconSize: 40,
            color: mainColor,
            icon: const Icon(
              Icons.keyboard_arrow_left,
            ),
          ),
          haveLogo: false,
          title: Text(
            'Current Requests',
            style: AppTextStyle.mainStyle(),
          ),
        ),
        BlocBuilder<RequestCubit, RequestState>(
          builder: (context, state) {
            print(state);
            if (state is! GetDriverCurrentReqErrorState &&
                state is! GetDriverCurrentReqLoadingState &&
                state is GetDriverReqSuccessState) {
              if (state.previousRequests.length > 0) {
                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: state.previousRequests.length,
                    itemBuilder: (context, index) {
                      bool isWinch =
                          state.previousRequests[index].winch != null;
                      if (isWinch) {
                        return requestCard(
                            function: () {
                              requestCubit.cancelRequest(
                                  state.previousRequests[index].sId!);
                              requestCubit.getDriverCurrentReq();
                            },
                            isWinch: isWinch,
                            name: state.previousRequests[index].winch!.name!,
                            rate: state.previousRequests[index].winch!.rate!,
                            thirdVal: state
                                .previousRequests[index].winch!.plateNumber!,
                            requestState: 'On his way');
                      } else {
                        return requestCard(
                            function: () {
                              requestCubit.cancelRequest(
                                  state.previousRequests[index].sId!);
                              requestCubit.getDriverCurrentReq();
                            },
                            isWinch: isWinch,
                            name: state.previousRequests[index].mechanic!.name!,
                            rate: state.previousRequests[index].mechanic!.rate!,
                            thirdVal:
                                state.previousRequests[index].mechanic!.service,
                            requestState: 'On his way');
                      }
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                  ),
                );
              } else {
                return SizedBox(
                    height: 400,
                    child: EmptyRequests(
                      text: "No Pendding Requests",
                    ));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ]),
    );
  }
}
