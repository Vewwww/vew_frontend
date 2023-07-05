import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vewww/bloc/request_cubit/request_cubit.dart';
import 'package:vewww/bloc/service_cubit/services_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/model/location.dart';
import 'package:vewww/model/requests.dart';
import 'package:vewww/views/driver/requests_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../bloc/repairer_requests_cubit.dart/repairer_requests_cubit.dart';
import '../../controllers/controller.dart';
import '../../core/components/rating_bar.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/name.dart';
import '../../model/repairer.dart' as repairer;

class MechanicPreviewScreen extends StatefulWidget {
  repairer.Mechanic mechanic;
  MechanicPreviewScreen({required this.mechanic, super.key}) {
    print("current mechanic : ${mechanic.toJson()}");
  }

  @override
  State<MechanicPreviewScreen> createState() => _MechanicPreviewScreenState();
}

// 649ee904e9d7a001ee231275
// 649ee904e9d7a001ee231275
class _MechanicPreviewScreenState extends State<MechanicPreviewScreen> {
  IO.Socket? socket;
  initSocket(String id) {
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
    socket!.on("request-accepted-or-rejected", (data) {
      print("request-accepted-or-rejected  :$data");
      var requestCubit = context.read<RequestCubit>();
      requestCubit.getDriverCurrentReq();
      requestCubit.getDriverPendingReq();
    });

    socket!.onDisconnect((_) => print('Connection Disconnection'));
    socket!.onConnectError((err) => print(err));
    socket!.onError((err) => print(err));
  }

  @override
  Widget build(BuildContext context) {
    RequestCubit requestCubit = RequestCubit.get(context);
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(children: [
        Expanded(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                CustomAppBar(
                  haveBackArrow: true,
                  backgroundcolor: mainColor,
                  iconColor: Colors.white,
                ),
                Image.asset(
                  'assets/images/shop.png',
                  height: 100,
                  width: 100,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.mechanic.name!.en ?? widget.mechanic.name!.ar!,
                  style: AppTextStyle.whiteTextStyle(20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Owner : ${widget.mechanic.ownerName!}",
                  style: AppTextStyle.greyStyle(size: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                RatingBar(widget.mechanic.rate!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () async {
                        if (widget.mechanic.phoneNumber != null)
                          await Controller.call(widget.mechanic.phoneNumber!);
                      },
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () async {
                          await Controller.goToGoogleMaps(
                              widget.mechanic.location!);
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0),
              ),
              color: Colors.white,
            ),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Services:',
                      style: AppTextStyle.mainStyle(size: 20),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: widget.mechanic.service!.length,
                        separatorBuilder: (context, int index) =>
                            const SizedBox(height: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                            widget.mechanic.service![index].name!.en ??
                                widget.mechanic.service![index].name!.ar!,
                            style: AppTextStyle.darkGreyStyle(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                (widget.mechanic.hasDelivery == true)
                    ? BlocBuilder<RequestCubit, RequestState>(
                        builder: (context, state) {
                        return defaultButton(
                          text: 'Request Mechanic',
                          width: 390,
                          function: () async {
                            print(
                                "in mechanic preview screen ${SharedPreferencesHelper.getData(key: "vewToken")}");
                            ServicesCubit servicesCubit =
                                ServicesCubit.get(context);
                            Position position = await Controller.getLocation();
                            String address =
                                await Controller.getAddress(position);
                            Location location = Location(
                                latitude: position.latitude,
                                longitude: position.longitude,
                                description: Name(ar: address, en: address));
                            CreateRequest createRequest = CreateRequest(
                              driver:
                                  SharedPreferencesHelper.getData(key: 'vewId'),
                              //Todo:: add car id
                              car: '6484789db6fc5a39cbe4e3d8',
                              location: location,
                              mechanic: widget.mechanic.sId,
                              service: (servicesCubit.selectedServices !=
                                          null &&
                                      servicesCubit.selectedServices[0].sId !=
                                          null)
                                  ? servicesCubit.selectedServices[0].sId
                                  : "",
                            );
                            await requestCubit
                                .createMechanicRequest(createRequest);
                            if (requestCubit
                                is CreateMechanicRequestSuccessState) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => RequestScreen(
                                            isWinch: false,
                                          ))));
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        );
                      })
                    : defaultButton(text: 'Request Winch', width: 390),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
