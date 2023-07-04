import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/views/mechanic/mechanic_profile.dart';
import '../../bloc/chat_cubit/chat_cubit.dart';
import '../../bloc/repairer_requests_cubit.dart/repairer_requests_cubit.dart';
import '../../core/components/accepted_request_card.dart';
import '../../core/components/app_nav_bar.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/sidebar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import 'mechanic_upcoming_req_screen.dart';

class MechanicHomeScreen extends StatefulWidget {
  MechanicHomeScreen({super.key});

  @override
  State<MechanicHomeScreen> createState() => _MechanicHomeScreenState();
}

class _MechanicHomeScreenState extends State<MechanicHomeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    var chatCubit = context.read<ChatCubit>();
    chatCubit.getMechanicChats();
    var repairerRequestsCubit = context.read<RepairerRequestsCubit>();
    repairerRequestsCubit.mechanicAcceptedRequests();
  }

  @override
  Widget build(BuildContext context) {
    RepairerRequestsCubit repairerRequestsCubit =
        RepairerRequestsCubit.get(context);
    return Scaffold(
      bottomNavigationBar: AppNavigationBar(
        homeFunction: () {
          print("here x");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MechanicHomeScreen()),
              (route) => false);
        },
        upComingReqFunction: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MechanicUpComingReqScreen(),
              ));
        },
      ),
      key: _globalKey,
      endDrawer: Sidebar(
        function: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MechanicProfile()),
              (route) => true);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 20),
              CustomAppBar(
                leading: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    return InkWell(
                        onTap: () {
                          _globalKey.currentState!.openEndDrawer();
                        },
                        child: ((state is GettingChatsSuccessState &&
                                ChatCubit.get(context).chatResponse!.newChats!))
                            ? Stack(
                                children: [
                                  Icon(
                                    Icons.menu,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 1,
                                    child: CircleAvatar(
                                      radius: 7,
                                      backgroundColor: Colors.red.shade900,
                                    ),
                                  )
                                ],
                              )
                            : Icon(
                                Icons.menu,
                                size: 30,
                                color: Colors.grey,
                              ));
                  },
                ),
                haveLogo: true,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Text(
                  "الطلبات المقبولة",
                  style: AppTextStyle.titleTextStyle(18),
                ),
              ),
              BlocBuilder<RepairerRequestsCubit, RepairerRequestsState>(
                builder: (context, state) {
                  if (state is GettingAcceptedRequestsSuccessState ||
                      state is CancelingRequestSuccessState) if (repairerRequestsCubit
                          .acceptedRequestsResponse!.data!.length >
                      0)
                    return Expanded(
                        child: ListView.builder(
                            itemCount: repairerRequestsCubit
                                .acceptedRequestsResponse!.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AcceptedRequestCard( mechanicRequestsData: repairerRequestsCubit
                                  .acceptedRequestsResponse!.data![index]);
                            }));
                  else
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/Empty.png"),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "You have no requests right now",
                          style: AppTextStyle.greyStyle(),
                        ),
                      ],
                    );
                  else
                    return Center(
                        child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 3),
                        CircularProgressIndicator(),
                      ],
                    ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
