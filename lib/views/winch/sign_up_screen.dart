import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/views/winch/winch_home_page.dart';

import '../../bloc/add_car_cubit/add_car_cubit.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/logo.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/style/app_colors.dart';
import '../../core/utils/navigation.dart';
import '../common/sign_in_screen.dart';


class WinchSignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  WinchSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double constraintsHight = MediaQuery.of(context).size.height;
    AddCarCubit addCarCubit = AddCarCubit.get(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: constraintsHight / 30),
                  Center(child: Logo()),
                  SizedBox(height: constraintsHight / 60),
                  Text(
                    "أنشاء حساب",
                    style: AppTextStyle.titleTextStyle(20),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 1.2,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _name,
                    label: "الاسم",
                    validator: (value) {
                      if (value!.length < 1 || value == null) {
                        return 'برجاء ادخال الاسم';
                      }
                    },
                  ),
                  CustomTextField(
                    label: "الايميل",
                    controller: _email,
                    hint: "example@mail.com",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'برجاء ادخال الايميل';
                      } else if (!value.contains('@') || !value.contains('.')) {
                        return 'برجاء ادخال ايميل صحيح"';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    controller: _password,
                    label: "كلمة السر",
                    validator: (value) {
                      RegExp regex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])');
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (!regex.hasMatch(value)) {
                        return ':يجب ان تكون كلمة السر: \n مكونة من 8 احرف على الاقل\n تحتوى على حرف كبير\n تحتوى على حرف صغير \n تحتوى على رقم \n تحتوى على حرف مميز';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    label: "تأكيد كلمة السر",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'برجاء اعد ادخال كلمة السر';
                      } else if (value != _password.text) {
                        return 'لا تطابق كلمة السر التى ادخلتها';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      const Divider(
                        color: Colors.grey,
                      ),
                      BlocConsumer<AddCarCubit, AddCarState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              if (!addCarCubit.carExist)
                                addCarCubit.add();
                              else
                                addCarCubit.remove();
                            },
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: (addCarCubit.carExist)
                                  ? Colors.grey
                                  : mainColor,
                              child: Icon(
                                (!addCarCubit.carExist)
                                    ? Icons.add
                                    : Icons.remove,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  BlocConsumer<AddCarCubit, AddCarState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (!addCarCubit.carExist) {
                        return Text(
                          "لم يتم اضافة سيارة",
                          style: AppTextStyle.greyStyle(size:18),
                        );
                      } else {
                        return Column(
                          children: [
                            CustomTextField(
                              label: "رقم السيارة",
                              validator: (value) {
                                if (addCarCubit.carExist) {
                                  if (value!.length < 1 || value == null) {
                                    return 'برجاء اختيار نوع السيارة';
                                  }
                                }
                              },
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            NavigationUtils.navigateAndClearStack(
                                context: context,
                                destinationScreen: WinchHomePage());
                          }
                        },
                        child: const Text("انشاء حساب"),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: Text("تسجيل الدخول",
                            style: AppTextStyle.titleTextStyle(14)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()),
                          );
                        },
                      ),
                      Text(
                        "تمتلك بالفعل حساب؟",
                        style: AppTextStyle.greyStyle(size:14),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Divider(
                        color: Color.fromARGB(255, 151, 151, 151),
                        thickness: 1,
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          "أو",
                          style: AppTextStyle.greyStyle(size:12),
                        ),
                      ),
                      const Expanded(
                          child: Divider(
                        color: Color.fromARGB(255, 151, 151, 151),
                        thickness: 1,
                      )),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Image.asset("assets/images/google.png")),
                      InkWell(
                          onTap: () async {},
                          child: Image.asset("assets/images/Facebook.png")),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
