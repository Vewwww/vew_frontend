import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/model/winch_accepted_requests_response.dart';
//import 'package:vewww/model/accepted_requests_response.dart';
import 'package:vewww/views/winch/winch_profile.dart';
import 'package:vewww/views/winch/winch_upcoming_requests_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../bloc/chat_cubit/chat_cubit.dart';
import '../../bloc/new_request_cubit/new_request_cubit.dart';
import '../../bloc/repairer_requests_cubit.dart/repairer_requests_cubit.dart';
import '../../core/components/accepted_request_card.dart';
import '../../core/components/app_nav_bar.dart';
import '../../core/components/coming_request_card.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/sidebar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/sp_helper/cache_helper.dart';

class WinchHomePage extends StatefulWidget {
  WinchHomePage({Key? key}) : super(key: key);

  @override
  State<WinchHomePage> createState() => _WinchHomePageState();
}

class _WinchHomePageState extends State<WinchHomePage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    initSocket();
    var chatCubit = context.read<ChatCubit>();
    chatCubit.getWinchChats();
    var repairerRequestsCubit = context.read<RepairerRequestsCubit>();
    repairerRequestsCubit.winchAcceptedRequests();
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
      var requestCubit = context.read<NewRequestCubit>();
      requestCubit.setHaveNew(true);
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
      bottomNavigationBar: AppNavigationBar(
        homeFunction: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => WinchHomePage()),
              (route) => false);
        },
        upComingReqFunction: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WinchUpcomingRequestsScreen(),
              ));
        },
      ),
      key: _globalKey,
      endDrawer: Sidebar(
        function: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const WinchProfile()),
              (route) => true);
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 20),
            CustomAppBar(
              leading: IconButton(onPressed: () {
                _globalKey.currentState!.openEndDrawer();
              }, icon: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  if (state is GettingChatsSuccessState &&
                      ChatCubit.get(context).chatResponse!.newChats!)
                    return Stack(
                      children: [
                        Icon(
                          Icons.menu,
                          size: 30,
                          color: Colors.grey,
                        ),
                        Positioned(
                          right: 0,
                          top: 1,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.red.shade900,
                          ),
                        )
                      ],
                    );
                  else
                    return Icon(
                      Icons.menu,
                      size: 30,
                      color: Colors.grey,
                    );
                },
              )),
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
                if (state is GettingWinchAcceptedRequestsSuccessState) {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: repairerRequestsCubit
                              .winchacceptedRequestsResponse!
                              .winchRequestData!
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            return AcceptedRequestCard(
                                winchRequestData: repairerRequestsCubit
                                    .winchacceptedRequestsResponse!
                                    .winchRequestData![index]);
                          }));
                } else {
                  return Center(
                      child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 3),
                      CircularProgressIndicator(),
                    ],
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

/*
Expanded(child: Container()),
            Image.asset(
              "assets/images/Empty.png",
              width: 300,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Requests will be here",
              style: AppTextStyle.lightGrayTextStyle(25),
            ),
            Expanded(child: Container()),
*/ 
