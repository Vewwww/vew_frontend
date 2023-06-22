import 'package:flutter/material.dart';
import 'package:vewww/core/components/logo.dart';
import 'package:vewww/core/style/app_colors.dart';

import '../../core/components/custom_app_bar.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';
import '../common/select_color_screen.dart';

class WinchEditProfileScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  WinchEditProfileScreen({Key? key}) : super(key: key);

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
                Text("Edit Profile", style: AppTextStyle.mainStyle(size: 20)),
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
                    controller: _password,
                    label: "رقم السيارة",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'برجاء ادخال رقم السيارة';
                      }
                      return null;
                    }),
                CustomTextField(
                  label: "نوع السيارة",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'برجاء ادخال نوع السيارة';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  label: "موديل السيارة",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'برجاء ادخال موديل السيارة';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            NavigationUtils.navigateTo(
                                context: context,
                                destinationScreen: const SelectColorScreen());
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: mainColor,
                          )),
                      Expanded(child: Container()),
                      Text(
                        "لون السيارة",
                        style: AppTextStyle.greyStyle(size: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        /*  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        ); */
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
