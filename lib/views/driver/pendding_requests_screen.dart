import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';
import '../../bloc/request_cubit/request_cubit.dart';
import '../../core/components/empty_requests.dart';
import '../../core/components/request_card.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class PenddingRequestsScreen extends StatefulWidget {
  bool? isWinch;
  PenddingRequestsScreen({super.key, this.isWinch});

  @override
  State<PenddingRequestsScreen> createState() =>
      _PenddingRequestsScreenState(isWinch);
}

class _PenddingRequestsScreenState extends State<PenddingRequestsScreen> {
  bool? isWinch;
  _PenddingRequestsScreenState(this.isWinch);
  @override
  void initState() {
    super.initState();
    initSocket();
    final requestCubit = context.read<RequestCubit>();
    requestCubit.getDriverPendingReq();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, initSocket);
  }

  IO.Socket? socket;

  initSocket() {
    socket = IO.io("https://vewwwapi.onrender.com/", <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket!.connect();
    var cubit = context.read<RequestCubit>();
    socket!.onConnect((_) {
      if (cubit.reqResponse != null &&
          cubit.reqResponse!.previousRequests != null) {
        for (var req in cubit.reqResponse!.previousRequests!) {
          socket!.emit('join-room', {'room': req.sId});
        }
      }
    });
    socket!.on("request-accepted-or-rejected", (data) {
      cubit.reqResponse = null;
      cubit.getDriverPendingReq();
    });
    socket!.onDisconnect((_) => debugPrint('Connection Disconnection'));
    socket!.onConnectError((err) => debugPrint(err));
    socket!.onError((err) => debugPrint(err));
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
                  MaterialPageRoute(builder: (context) => const DriverHomeScreen()),
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
            'Pending Requests',
            style: AppTextStyle.mainStyle(),
          ),
        ),
        BlocBuilder<RequestCubit, RequestState>(
          builder: (context, state) {
            if (state is! GetDriverPendingReqErrorState &&
                state is! GetDriverPendingReqLoadingState &&
                state is GetDriverReqSuccessState) {
              if (state.previousRequests.isNotEmpty) {
                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: state.previousRequests.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool isWinch =
                          state.previousRequests[index].winch != null;
                      if (isWinch) {
                        return requestCard(
                            function: () {
                              requestCubit.cancelRequest(
                                  state.previousRequests[index].sId!);
                              requestCubit.getDriverPendingReq();
                            },
                            isWinch: isWinch,
                            name: state.previousRequests[index].winch!.name!,
                            rate: state.previousRequests[index].winch!.rate!,
                            thirdVal: state
                                .previousRequests[index].winch!.plateNumber!,
                            requestState: 'pendding');
                      } else {
                        return requestCard(
                            function: () {
                              requestCubit.cancelRequest(
                                  state.previousRequests[index].sId!);
                              requestCubit.getDriverPendingReq();
                            },
                            isWinch: isWinch,
                            name: state.previousRequests[index].mechanic!.name!,
                            rate: state.previousRequests[index].mechanic!.rate!,
                            thirdVal:
                                state.previousRequests[index].mechanic!.service,
                            requestState: 'pendding');
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
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
              return const CircularProgressIndicator();
            }
          },
        ),
      ]),
    );
  }

  void disconnect() {
    socket!.disconnect();
    socket!.dispose();
  }

  @override
  void dispose() {
    socket!.disconnect();
    socket!.dispose();
    super.dispose();
  }
}
