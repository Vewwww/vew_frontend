import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/profile_cubit/profile_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/model/car.dart';
import 'package:vewww/model/driver.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';
import 'package:vewww/views/driver/edit_driver_profile.dart';
import '../../core/components/build_car.dart';
import '../../core/components/custom_text_field.dart';
import 'add_car_screen.dart';

class DriverProfile extends StatefulWidget {
  // Driver driver;

  DriverProfile({Key? key}) : super(key: key);

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _phone = TextEditingController();

  final TextEditingController _licenseRenewalDate = TextEditingController();

  @override
  void initState() {
    super.initState();
    var profileCubit = context.read<ProfileCubit>();
    profileCubit.getDriverProfile();
  }

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = ProfileCubit.get(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  tileMode: TileMode.repeated,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    mainColor,
                    mainColor.withOpacity(0.8),
                    const Color.fromARGB(255, 4, 237, 222),
                    Colors.white,
                    Colors.white,
                  ]),
            ),
            child: Column(
              children: [
                const SizedBox(height: 80),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: mainColor,
                  ),
                ),
                const SizedBox(height: 20),
                BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return (state is GettingProfileSuccessState)
                        ? Text(
                            profileCubit.profileResponse!.data!.user!.name!,
                            style: AppTextStyle.whiteTextStyle(20),
                          )
                        : Center(
                            child: Column(
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 3),
                              CircularProgressIndicator(),
                            ],
                          ));
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
              top: 20,
              left: 20,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  NavigationUtils.navigateAndClearStack(
                      context: context, destinationScreen: DriverHomeScreen());
                },
              )),
          Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 6 * 4,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15))),
                child: SingleChildScrollView(
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is GettingProfileSuccessState) {
                        return Stack(
                          children: [
                            Positioned(
                                right: 5,
                                top: -10,
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    if (profileCubit.state
                                        is GettingProfileSuccessState)
                                      // print(
                                      //     "driver cars from profile : ${profileCubit.profileResponse!.data!.cars![0].toJson()}");
                                    NavigationUtils.navigateTo(
                                        context: context,
                                        destinationScreen: EditDriverProfile(
                                          inProgress: false,
                                          driver: profileCubit
                                              .profileResponse!.data!,
                                        ));
                                  },
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                CustomTextField(
                                  readOnly: true,
                                  label: "Email",
                                  hint: profileCubit
                                      .profileResponse!.data!.user!.email,
                                  controller: _email,
                                  validator: (value) {},
                                ),
                                CustomTextField(
                                  readOnly: true,
                                  hint: profileCubit
                                      .profileResponse!.data!.user!.phoneNumber,
                                  label: "Phone",
                                  validator: (value) {},
                                ),
                                const SizedBox(height: 20),
                                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            //carCubit.add(driver.user!.sId!);
                            NavigationUtils.navigateAndClearStack(context: context , destinationScreen: AddCarScreen(profileCubit.profileResponse!.data!.user!.sId!));
                            print("test from screennnnnnnnn");
                            //carCubit.testcars();
                          },
                          child: Text(
                            "Add car",
                            style: AppTextStyle.mainStyle(size: 13),
                          )),
                      Text("Cars"),
                    ],
                  ),
                                (profileCubit.profileResponse!.data!.cars !=
                                        null)
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount: profileCubit.profileResponse!
                                            .data!.cars!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return buildCarDetails(
                                              profileCubit.profileResponse!
                                                  .data!.cars![index],
                                              index + 1);
                                        },
                                      )
                                    : Container(),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return Center(
                            child: Column(
                          children: [
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 3),
                            CircularProgressIndicator(),
                          ],
                        ));
                      }
                    },
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
