import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:vewww/bloc/repairer_requests_cubit.dart/repairer_requests_cubit.dart';
import 'package:vewww/controllers/controller.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/model/accepted_requests_response.dart';
import '../../views/common/chats_screen.dart';
import '../../views/winch/single_request_screen.dart';
import '../style/app_Text_Style/app_text_style.dart';
import '../utils/navigation.dart';
import 'rating_bar.dart';

class AcceptedRequestCard extends StatefulWidget {
  MechanicRequestsData acceptedRequestData;
  AcceptedRequestCard(this.acceptedRequestData, {Key? key}) : super(key: key);

  @override
  State<AcceptedRequestCard> createState() => _AcceptedRequestCardState();
}

class _AcceptedRequestCardState extends State<AcceptedRequestCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationUtils.navigateTo(
            context: context,
            destinationScreen: SingleRequestScreen(widget.acceptedRequestData));
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
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.acceptedRequestData.driver!.person!.name!,
                  style: AppTextStyle.titleTextStyle(20),
                ),
                RatingBar(4.4, size: 15),
                Text(
                  "السيارة: ${widget.acceptedRequestData.car!.carType!.name!.ar}",
                  style: AppTextStyle.darkGreyStyle(size: 13),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          await Controller.call(
                              widget.acceptedRequestData.driver!.phoneNumber!);
                        },
                        icon: Icon(
                          Icons.call,
                          size: 17,
                          color: mainColor,
                        )),
                    IconButton(
                        onPressed: () async {
                          await Controller.goToGoogleMaps(
                              widget.acceptedRequestData.location!);
                        },
                        icon: Icon(
                          Icons.location_on,
                          size: 17,
                          color: mainColor,
                        )),
                    IconButton(
                        onPressed: () {
                          NavigationUtils.navigateTo(
                              context: context,
                              destinationScreen: const ChatsScreen());
                        },
                        icon: Icon(
                          Icons.chat_rounded,
                          size: 17,
                          color: mainColor,
                        )),
                  ],
                ),
                Container(
                  width: 180,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                      ),
                      onPressed: () async {
                        RepairerRequestsCubit repairerRequestsCubit =
                            RepairerRequestsCubit.get(context);
                        await repairerRequestsCubit.mechanicCompleteRequest(
                            widget.acceptedRequestData.sId!);
                      },
                      child: const Text(
                        "تم",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
            Container(
              width: 140,
              height: 140,
              margin: const EdgeInsets.fromLTRB(3, 7, 0, 3),
              decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: const Icon(
                Icons.car_repair,
                size: 50,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
