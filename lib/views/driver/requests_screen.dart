import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/horizontal_line.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';
import 'package:vewww/views/driver/nearest_winch_screen.dart';
import '../../bloc/request_cubit/request_cubit.dart';
import '../../core/components/request_card.dart';

class RequestScreen extends StatefulWidget {
  bool isWinch ;
   RequestScreen({super.key, required this.isWinch});

  @override
  State<RequestScreen> createState() => _RequestScreenState(isWinch);
}

class _RequestScreenState extends State<RequestScreen> {
  bool isWinch ;
  _RequestScreenState(this.isWinch);
  @override
  void initState() {
    super.initState();
    final requestCubit = context.read<RequestCubit>();
    requestCubit.getDriverCurrentReq();
    requestCubit.getDriverPendingReq();
  }

  @override
  Widget build(BuildContext context) {
    RequestCubit requestCubit =RequestCubit.get(context);
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
          haveLogo: true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            'Pending Requests',
            style: AppTextStyle.darkGreyStyle(),
          ),
        ),
        HorizontalLine(),
        BlocBuilder<RequestCubit, RequestState>(
          builder: (context, state) {
            if (state is GetDriverPendingReqSuccessState) {
              return Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: state.previousRequests.length,
                  itemBuilder: (BuildContext context, int index) {
                    if(isWinch){
                    return requestCard(
                        function: () {
                          requestCubit.cancelRequest(state.previousRequests[index].winch!.sId!);
                        },
                        isWinch: isWinch,
                        name: state.previousRequests[index].winch!.name!,
                        rate: state.previousRequests[index].winch!.rate!,
                        thirdVal:
                            state.previousRequests[index].winch!.plateNumber!,
                        distance: 0.8,
                        requestState: 'On his way');
                    }else{
                      return requestCard(
                        function: () {
                          requestCubit.cancelRequest(state.previousRequests[index].mechanic!.sId!);
                        },
                        isWinch: isWinch,
                        name: state.previousRequests[index].mechanic!.name!,
                        rate: state.previousRequests[index].mechanic!.rate!,
                        thirdVal:
                            state.previousRequests[index].mechanic!.service!,
                        distance: 0.8,
                        requestState: 'On his way');
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 15,
                  ),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            'Current Requests',
            style: AppTextStyle.darkGreyStyle(),
          ),
        ),
        HorizontalLine(),
        BlocBuilder<RequestCubit, RequestState>(
          builder: (context, state) {
            if (state is GetDriverCurrentReqSuccessState) {
              return Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: state.previousRequests.length,
                  itemBuilder: (context, index) {
                    if(isWinch){
                    return requestCard(
                        function: () {
                          requestCubit.cancelRequest(state.previousRequests[index].winch!.sId!);
                        },
                        isWinch: isWinch,
                        name: state.previousRequests[index].winch!.name!,
                        rate: state.previousRequests[index].winch!.rate!,
                        thirdVal:
                            state.previousRequests[index].winch!.plateNumber!,
                        distance: 0.8,
                        requestState: 'On his way');
                    }else{
                      return requestCard(
                        function: () {
                          requestCubit.cancelRequest(state.previousRequests[index].mechanic!.sId!);
                        },
                        isWinch: isWinch,
                        name: state.previousRequests[index].mechanic!.name!,
                        rate: state.previousRequests[index].mechanic!.rate!,
                        thirdVal:
                            state.previousRequests[index].mechanic!.service!,
                        distance: 0.8,
                        requestState: 'On his way');
                    }
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ]),
    );
  }
}
