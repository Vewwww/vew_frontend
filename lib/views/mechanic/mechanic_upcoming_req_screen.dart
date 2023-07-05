import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/new_request_cubit/new_request_cubit.dart';
import 'package:vewww/views/mechanic/mechanic_home_screen.dart';
import 'package:vewww/views/mechanic/mechanic_profile.dart';
import '../../bloc/chat_cubit/chat_cubit.dart';
import '../../bloc/repairer_requests_cubit.dart/repairer_requests_cubit.dart';
import '../../core/components/app_nav_bar.dart';
import '../../core/components/coming_request_card.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/empty_requests.dart';
import '../../core/components/sidebar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MechanicUpComingReqScreen extends StatefulWidget {
  MechanicUpComingReqScreen({super.key});

  @override
  State<MechanicUpComingReqScreen> createState() =>
      _MechanicUpComingReqScreenState();
}

class _MechanicUpComingReqScreenState extends State<MechanicUpComingReqScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    initSocket();
    var chatCubit = context.read<ChatCubit>();
    chatCubit.getMechanicChats();
    var newRequestCubit = context.read<NewRequestCubit>();
    newRequestCubit.setHaveNew(false);
    var repairerRequestsCubit = context.read<RepairerRequestsCubit>();
    repairerRequestsCubit.mechanicUpComingRequests();
  }

  IO.Socket? socket;
  initSocket() {
    String id = SharedPreferencesHelper.getData(key: "vewId");
    socket = IO.io("https://vewwwapi.onrender.com/", <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket!.connect();
    socket!.onConnect((_) {
      print('Connection established');
      socket!.emit('join-room', {'room': id});
      print('joined room');
    });
    socket!.on("new-request", (data) {
      print("new request created");
      var requestCubit = context.read<RepairerRequestsCubit>();
      var newRequestCubit = context.read<NewRequestCubit>();
      newRequestCubit.setHaveNew(false);
        requestCubit.mechanicUpComingRequests();
    });
    socket!.onDisconnect((_) => print('Connection Disconnection'));
    socket!.onConnectError((err) => print(err));
    socket!.onError((err) => print(err));
  }

  @override
  Widget build(BuildContext context) {
    RepairerRequestsCubit repairerRequestsCubit =
        RepairerRequestsCubit.get(context);
    return Scaffold(
      endDrawer: Sidebar(
        function: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MechanicProfile()),
              (route) => true);
        },
      ),
      bottomNavigationBar: AppNavigationBar(
        homeFunction: () {
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
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 20),
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
          Expanded(child: Container()),
          //TODO::uncomment
          //(comingRequests.length > 0)?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Text(
              "الطلبات القادمة",
              style: AppTextStyle.titleTextStyle(18),
            ),
          ),
          Expanded(child: Container()),
          BlocBuilder<RepairerRequestsCubit, RepairerRequestsState>(
            builder: (context, state) {
              print(state);
              if (state
                  is GettingUpComingRequestsSuccessState) if (repairerRequestsCubit
                      .upcomingRequestsResponse!.data!.length >
                  0)
                return Expanded(
                    flex: 70,
                    child: ListView.builder(
                        itemCount: repairerRequestsCubit
                            .upcomingRequestsResponse!.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ComingRequestCard(
                              mechanicRequestsData: repairerRequestsCubit
                                  .upcomingRequestsResponse!.data![index]);
                        }));
              else
                return SizedBox(height: 500, child: EmptyRequests());
              else
                return Center(
                    child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 3),
                    CircularProgressIndicator(),
                  ],
                ));
            },
          ),
          Expanded(child: Container()),
        ],
      )),
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
