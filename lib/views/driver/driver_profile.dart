import 'package:flutter/material.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/model/car.dart';
import 'package:vewww/model/driver.dart';
import 'package:vewww/views/driver/edit_driver_profile.dart';
import '../../core/components/custom_text_field.dart';

class DriverProfile extends StatelessWidget {
  Driver driver;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _licenseRenewalDate = TextEditingController();
  DriverProfile({required this.driver, Key? key}) : super(key: key) {
    _email.text = driver.email!;
    _phone.text = driver.phoneNumber!;
    _licenseRenewalDate.text = driver.lisenceRenewalDate!;
  }

  @override
  Widget build(BuildContext context) {
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
                Text(
                  "Sameh Mohamed",
                  style: AppTextStyle.whiteTextStyle(20),
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
                  child: Stack(
                    children: [
                      Positioned(
                          right: 5,
                          top: -10,
                          child: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              NavigationUtils.navigateTo(
                                  context: context,
                                  destinationScreen:
                                      EditDriverProfile(driver: driver));
                            },
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          CustomTextField(
                            readOnly: true,
                            label: "Email",
                            controller: _email,
                            validator: (value) {},
                          ),
                          CustomTextField(
                            readOnly: true,
                            controller: _phone,
                            label: "Phone",
                            validator: (value) {},
                          ),
                          CustomTextField(
                            readOnly: true,
                            label: "Driving license renewal date",
                            controller: _licenseRenewalDate,
                            validator: (value) {},
                          ),
                          const SizedBox(height: 20),
                          ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: driver.cars!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return buildCarDetails(
                                  driver.cars![index], index + 1);
                            },
                          ),
                        ],
                      ),
                    ],
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
                child: const Icon(
                  Icons.drive_eta,
                  size: 30,
                  color: Colors.black //car.color,
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
