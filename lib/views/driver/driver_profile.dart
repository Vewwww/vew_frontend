import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/profile_cubit/profile_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/model/car.dart';
import 'package:vewww/model/driver.dart';
import 'package:vewww/views/driver/edit_driver_profile.dart';
import '../../core/components/custom_text_field.dart';

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
    // _email.text = driver.person!.email!;
    // _phone.text = driver.phoneNumber!;
    // _licenseRenewalDate.text = driver.lisenceRenewalDate!;
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
                      if (state is GettingProfileSuccessState)
                        return Stack(
                          children: [
                            Positioned(
                                right: 5,
                                top: -10,
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    NavigationUtils.navigateTo(
                                        context: context,
                                        destinationScreen: EditDriverProfile(
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
                                CustomTextField(
                                  readOnly: true,
                                  label: "Driving license renewal date",
                                  controller: _licenseRenewalDate,
                                  hint: profileCubit.profileResponse!.data!
                                      .user!.lisenceRenewalDate,
                                  validator: (value) {},
                                ),
                                const SizedBox(height: 20),
                                // (widget.driver.cars != null)
                                //     ? ListView.builder(
                                //         shrinkWrap: true,
                                //         primary: false,
                                //         physics:
                                //             const NeverScrollableScrollPhysics(),
                                //         padding: EdgeInsets.zero,
                                //         itemCount: 0,//widget.driver.cars!.length,
                                //         itemBuilder:
                                //             (BuildContext context, int index) {
                                //           return buildCarDetails(
                                //               widget.driver.cars![index],
                                //               index + 1);
                                //         },
                                //       )
                                //:
                                Container(),
                              ],
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
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget buildCarDetails(Car car, index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Car $index",
          style: AppTextStyle.mainStyle(size: 14),
        ),
        const Divider(
          thickness: 1,
        ),
        Center(
            child: CircleAvatar(
                radius: 30,
                backgroundColor: mainColor.withOpacity(0.3),
                child: const Icon(Icons.drive_eta,
                    size: 30, color: Colors.black //car.color,
                    ))),
        CustomTextField(
          readOnly: true,
          label: "Car Type",
          controller: TextEditingController(text: car.carType),
          validator: (value) {},
        ),
        CustomTextField(
          readOnly: true,
          label: "Car Model",
          controller: TextEditingController(text: "car.carModel"),
          validator: (value) {},
        ),
        CustomTextField(
          readOnly: true,
          label: "Last Periodic Maintenance Date",
          controller:
              TextEditingController(text: "car.lastPeriodicMaintenanceDate"),
          validator: (value) {},
        ),
        CustomTextField(
          readOnly: true,
          label: "License renewal date",
          controller: TextEditingController(text: "car.licenseRenewalDate"),
          validator: (value) {},
        ),
        CustomTextField(
          readOnly: true,
          label: "Current Miles",
          controller: TextEditingController(text: "car.currentMiles"),
          validator: (value) {},
        ),
        CustomTextField(
          readOnly: true,
          label: "Average Mile per Week ",
          controller: TextEditingController(text: "car.averageMileperWeek"),
          validator: (value) {},
        ),
        CustomTextField(
          readOnly: true,
          label: "Remind you before",
          controller: TextEditingController(text: "car.remindYouBefore"),
          validator: (value) {},
        ),
      ],
    );
  }
}
