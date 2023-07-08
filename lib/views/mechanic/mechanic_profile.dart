import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/profile_cubit/profile_cubit.dart';
import 'package:vewww/views/mechanic/mechanic_home_screen.dart';
import '../../core/components/backward_arrow.dart';
import '../../core/components/data_element.dart';
import '../../core/components/rating_bar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/style/app_colors.dart';
import '../../core/utils/navigation.dart';
import 'mechanic_edit_profile_screen.dart';

class MechanicProfile extends StatefulWidget {
  const MechanicProfile({super.key});

  @override
  State<MechanicProfile> createState() => _MechanicProfileState();
}

class _MechanicProfileState extends State<MechanicProfile> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    var profileCubit = context.read<ProfileCubit>();
    profileCubit.getMechanicProfile();
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
                                destinationScreen: const MechanicHomeScreen());
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
                      if (state is GettingProfileSuccessState) {
                        return Column(
                          children: [
                            Text(
                              profileCubit
                                  .mechanicProfileResponse!.mechanicShop!.name!,
                              style: AppTextStyle.whiteTextStyle(28),
                            ),
                            AppRatingBar(
                                profileCubit.mechanicProfileResponse!
                                    .mechanicShop!.rate!,
                                size: 20),
                          ],
                        );
                      } else {
                        return Center(
                            child: Column(
                          children: [
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 3),
                            const CircularProgressIndicator(),
                          ],
                        ));
                      }
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
                            if (state is GettingProfileSuccessState) {
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    DataElement(
                                        "الايميل",
                                        profileCubit.mechanicProfileResponse!
                                            .mechanicShop!.email!),
                                    DataElement(
                                        "رقم الهاتف",
                                        profileCubit.mechanicProfileResponse!
                                            .mechanicShop!.phoneNumber!),
                                    DataElement(
                                        "اسم المالك",
                                        profileCubit.mechanicProfileResponse!
                                            .mechanicShop!.ownerName!),
                                    DataElement(
                                        "رقم هاتف المالك",
                                        profileCubit.mechanicProfileResponse!
                                            .mechanicShop!.mechanicPhone!),
                                    const Divider(
                                        color: Colors.grey, thickness: 0.8),
                                    Text("الخدمات",
                                        style: AppTextStyle.lightGrayTextStyle(
                                            14)),
                                    ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: profileCubit
                                            .mechanicProfileResponse!
                                            .mechanicShop!
                                            .service!
                                            .length,
                                        itemBuilder: (context, index) {
                                          return DataElement(
                                              " ",
                                              profileCubit
                                                  .mechanicProfileResponse!
                                                  .mechanicShop!
                                                  .service![0]
                                                  .name!
                                                  .ar!);
                                        }),
                                  ]);
                            } else {
                              return Center(
                                  child: Column(
                                children: [
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3),
                                  const CircularProgressIndicator(),
                                ],
                              ));
                            }
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
                                  is GettingProfileSuccessState) {
                                NavigationUtils.navigateTo(
                                    context: context,
                                    destinationScreen: MechanicEditProfile(
                                        profileCubit.mechanicProfileResponse!
                                            .mechanicShop!));
                              }
                            },
                            icon: Icon(Icons.edit_outlined,
                                color: mainColor, size: 15)),
                      ))
                    ],
                  ))
            ])));
  }
}
