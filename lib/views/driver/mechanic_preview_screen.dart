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
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:vewww/views/driver/pendding_requests_screen.dart';
import '../../controllers/controller.dart';
import '../../core/components/rating_bar.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/name.dart';
import '../../model/repairer.dart' as repairer;
import 'which_car_screen.dart';

class MechanicPreviewScreen extends StatefulWidget {
  repairer.Mechanic mechanic;
  String carId;
  MechanicPreviewScreen(
      {required this.mechanic, super.key, required this.carId});

  @override
  State<MechanicPreviewScreen> createState() =>
      _MechanicPreviewScreenState(carId);
}

class _MechanicPreviewScreenState extends State<MechanicPreviewScreen> {
  _MechanicPreviewScreenState(this.carId);
  IO.Socket? socket;
  String carId;
  initSocket(String id) {
    socket = IO.io("https://vewwwapi.onrender.com/", <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket!.connect();
    socket!.onConnect((_) {
      socket!.emit('join-room', {'room': id});
    });
    socket!.on("request-accepted-or-rejected", (data) {
      var requestCubit = context.read<RequestCubit>();
      requestCubit.getDriverCurrentReq();
      requestCubit.getDriverPendingReq();
    });

    socket!.onDisconnect((_) => debugPrint('Connection Disconnection'));
    socket!.onConnectError((err) => debugPrint(err));
    socket!.onError((err) => debugPrint(err));
  }

  @override
  Widget build(BuildContext context) {
    RequestCubit requestCubit = RequestCubit.get(context);
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(children: [
        Expanded(
          child: SizedBox(
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
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.mechanic.name!.en ?? widget.mechanic.name!.ar!,
                  style: AppTextStyle.whiteTextStyle(20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Owner : ${widget.mechanic.ownerName!}",
                  style: AppTextStyle.greyStyle(size: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                AppRatingBar(widget.mechanic.rate!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () async {
                        if (widget.mechanic.phoneNumber != null) {
                          await Controller.call(widget.mechanic.phoneNumber!);
                        }
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
                      height: MediaQuery.of(context).size.height / 3 - 80,
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
                          text: (state is CreateMechanicRequestLoadingState)
                              ? "Loading..."
                              : 'Request Mechanic',
                          width: 390,
                          function: () async {
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
                              car: carId,
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
                            if (requestCubit.state
                                is CreateMechanicRequestSuccessState) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          PenddingRequestsScreen())));
                            }
                          },
                        );
                      })
                    : defaultButton(
                        text: 'Request Winch',
                        width: 390,
                        function: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => WhichCarScreen(
                                      id: SharedPreferencesHelper.getData(
                                          key: "vewId"),
                                      isWinch: true,
                                    ))))),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
