import 'package:flutter/material.dart';
import 'package:vewww/bloc/profile_cubit/profile_cubit.dart';
import 'package:vewww/core/components/logo.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/model/winch_driver.dart';
import 'package:vewww/views/winch/winch_home_page.dart';

import '../../core/components/custom_app_bar.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';
import '../common/select_color_screen.dart';

class WinchEditProfileScreen extends StatelessWidget {
  WinchDriver winch;

  WinchEditProfileScreen(this.winch, {Key? key}) : super(key: key) {
    _email.text = winch.email!;
    _name.text = winch.name!;
    _phone.text = winch.phoneNumber!;
    _plateNumber.text = winch.plateNumber!;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _plateNumber = TextEditingController();

  final TextEditingController _name = TextEditingController();

  final TextEditingController _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double constraintsHight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 20),
                CustomAppBar(
                  haveBackArrow: true,
                  haveLogo: true,
                ),
                const SizedBox(height: 40),
                Text(
                  "تعديل الملف الشخصي",
                  style: AppTextStyle.mainStyle(size: 20),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 2),
                const SizedBox(height: 10),
                CustomTextField(
                    controller: _name,
                    label: "الاسم",
                    validator: (value) {
                      if (value!.length < 1 || value == null) {
                        return 'برجاء ادخال الاسم';
                      }
                    }),
                CustomTextField(
                    label: "الايميل",
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    hint: "example@mail.com",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'برجاء ادخال الايميل';
                      } else if (!value.contains('@') || !value.contains('.')) {
                        return 'برجاء ادخال ايميل صحيح ';
                      }
                      return null;
                    }),
                CustomTextField(
                    label: "الهاتف",
                    controller: _phone,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'برجاء ادخال رقم الهاتف';
                      } else if (value.length != 11) {
                        return "يجب ان يكون رقم الهاتف مكون من 11 رقم  ";
                      }
                      return null;
                    }),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(color: Colors.grey, thickness: 0.8),
                    Text("السيارة", style: AppTextStyle.lightGrayTextStyle(14)),
                  ],
                ),
                CustomTextField(
                    controller: _plateNumber,
                    label: "رقم السيارة",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'برجاء ادخال رقم السيارة';
                      }
                      return null;
                    }),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        WinchDriver winchDriver = WinchDriver(
                            name: _name.text,
                            phoneNumber: _phone.text,
                            email: _email.text,
                            plateNumber: _plateNumber.text);
                        await ProfileCubit.get(context)
                            .updateWinchProfile(winchDriver);
                        if (ProfileCubit.get(context).state
                            is EdittingProfileSuccessState) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WinchHomePage()));
                        } else {
                          const snackBar = SnackBar(
                              content:
                                  Text("Something went wrong try again !"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                      debugPrint("email : ${_email.text}");
                    },
                    child: const Text("حفظ"),
                  ),
                ),
                SizedBox(
                  height: constraintsHight / 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
