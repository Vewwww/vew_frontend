import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/profile_cubit/profile_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/rating_bar.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/views/winch/winch_home_page.dart';

import '../../core/components/backward_arrow.dart';
import '../../core/components/data_element.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';
import 'winch_edit_profile_screen.dart';

class WinchProfile extends StatefulWidget {
  const WinchProfile({Key? key}) : super(key: key);

  @override
  State<WinchProfile> createState() => _WinchProfileState();
}

class _WinchProfileState extends State<WinchProfile> {
  @override
  void initState() {
    super.initState();
    var winchProfileCubit = context.read<ProfileCubit>();
    winchProfileCubit.getWinchProfile();
  }

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = ProfileCubit.get(context);
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  tileMode: TileMode.repeated,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    mainColor,
                    mainColor.withOpacity(0.8),
                    const Color.fromARGB(200, 4, 237, 222),
                    const Color.fromARGB(200, 4, 237, 222),
                    Colors.white
                  ]),
            ),
            child: Stack(children: [
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: Column(children: [
                    const SizedBox(height: 20),
                    Row(children: [
                      backwardArrow(
                          iconColor: Colors.white,
                          function: () {
                            NavigationUtils.navigateAndClearStack(
                                context: context,
                                destinationScreen: WinchHomePage());
                          })
                    ]),
                    const SizedBox(height: 10),
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Color.fromARGB(255, 2, 113, 106),
                      ),
                    ),
                    BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                      if (state is GettingProfileSuccessState)
                        return Column(
                          children: [
                            Text(
                              profileCubit.winchDriverResponse!.winch!.name!,
                              style: AppTextStyle.whiteTextStyle(28),
                            ),
                            AppRatingBar(
                              profileCubit.winchDriverResponse!.winch!.rate!,
                              size: 20,
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
                    }),
                  ]),
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Stack(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 2 * MediaQuery.of(context).size.height / 3,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          child: SingleChildScrollView(child:
                              BlocBuilder<ProfileCubit, ProfileState>(
                                  builder: (context, state) {
                            if (state is GettingProfileSuccessState)
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    DataElement(
                                        "الايميل",
                                        profileCubit.winchDriverResponse!.winch!
                                            .email!),
                                    DataElement(
                                        "رقم الهاتف",
                                        profileCubit.winchDriverResponse!.winch!
                                            .phoneNumber!),
                                    const Divider(
                                        color: Colors.grey, thickness: 0.8),
                                    Text("السيارة",
                                        style: AppTextStyle.lightGrayTextStyle(
                                            14)),
                                    DataElement(
                                        "رقم السيارة",
                                        profileCubit.winchDriverResponse!.winch!
                                            .plateNumber!),
                                  ]);
                            else
                              return Center(
                                  child: Column(
                                children: [
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3),
                                  CircularProgressIndicator(),
                                ],
                              ));
                          }))),
                      Positioned(
                          child: Container(
                        height: 30,
                        width: 40,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: mainColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: IconButton(
                            onPressed: () {
                              if (profileCubit.state
                                  is GettingProfileSuccessState)
                                NavigationUtils.navigateTo(
                                    context: context,
                                    destinationScreen: WinchEditProfileScreen(
                                        profileCubit
                                            .winchDriverResponse!.winch!));
                            },
                            icon: Icon(Icons.edit_outlined,
                                color: mainColor, size: 15)),
                      ))
                    ],
                  ))
            ])));
  }
}
