import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_cubit/auth_cubit.dart';
import '../../bloc/loaction_cubit/loaction_cubit.dart';
import '../../bloc/select_choice_cubit/select_choice_cubit.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/logo.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';
import '../common/map_screen.dart';
import '../driver/sign_in_screen.dart';

class MechanicSignup extends StatelessWidget {
  MechanicSignup({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _mechanicPhone = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _ownerName = TextEditingController();
  // {
  //   "hasDelivery": true,
  //   "location": {
  //       "description": {
  //           "ar": "مجمع الفردوس بجوار نادي السكه خلف ورشة",
  //           "en": " Al-Firdous Complex, next to Al-Sekka Club, behind Taqah workshop "
  //       },
  //       "latitude": 30.0496509,
  //       "longitude": 31.27362904
  //   },
  //   "service": [
  //       "64837b8cd4a3c95f4207e9e2",
  //       "64837b87d4a3c95f4207e9df"
  //   ]
  // }

  @override
  Widget build(BuildContext context) {
    double constraintsHight = MediaQuery.of(context).size.height;
    AuthCubit authCubit = AuthCubit.get(context);
    SelectChoiceCubit selectChoiceCubit = SelectChoiceCubit.get(context);
    LocationCubit locationCubit = LocationCubit.get(context);
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
                    label: "اسم الورشة",
                    isArabic: true,
                    validator: (value) {
                      if (value!.length < 1 || value == null) {
                        return 'برجاء ادخال اسم الورشة"';
                      }
                    },
                  ),
                  CustomTextField(
                    controller: _mechanicPhone,
                    label: "رقم الهاتف",
                    isArabic: true,
                    validator: (value) {
                      if (value!.length < 1 || value == null) {
                        return 'برجاء ادخال رقم الهاتف';
                      }
                    },
                  ),
                  CustomTextField(
                    controller: _ownerName,
                    label: "اسم المالك",
                    isArabic: true,
                    validator: (value) {
                      if (value!.length < 1 || value == null) {
                        return 'برجاء ادخال اسم المالك"';
                      }
                    },
                  ),
                  CustomTextField(
                    controller: _phoneNumber,
                    label: "رقم الهاتف المالك",
                    isArabic: true,
                    validator: (value) {
                      if (value!.length < 1 || value == null) {
                        return 'برجاء ادخال رقم الهاتف المالك';
                      }
                    },
                  ),
                  CustomTextField(
                    label: "الايميل",
                    controller: _email,
                    isArabic: true,
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
                    isArabic: true,
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
                    isArabic: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'برجاء اعد ادخال كلمة السر';
                      } else if (value != _password.text) {
                        return 'لا تطابق كلمة السر التى ادخلتها';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            NavigationUtils.navigateTo(
                                context: context,
                                destinationScreen: MapScreen(
                                  locationCubit: locationCubit,
                                ));
                          },
                          icon: Icon(Icons.location_on)),
                      Expanded(child: Container()),
                      Text("الموقع"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () async {
                              print(
                                  "lat:${locationCubit.lat} , address:${locationCubit.address}");
                              if (_formKey.currentState!.validate()) {
                                // WinchDriver winch = WinchDriver(
                                //       name: _name.text,
                                //       email: _email.text,
                                //       password: _password.text,
                                //       phoneNumber: _phoneNumber.text,
                                //       plateNumber: _carPlateNum.text,
                                //       location: Location(
                                //           latitude: locationCubit.lat,
                                //           longitude: locationCubit.long));
                                //   await authCubit.winchSignUp(winch);
                                //   if (state is SignUpSuccessState) {
                                //     NavigationUtils.navigateAndClearStack(
                                //         context: context,
                                //         destinationScreen: SignInScreen());
                                //   } else if (state is SignUpErrorState) {
                                //     var snackBar =
                                //         SnackBar(content: Text(state.errMessage));
                                //     ScaffoldMessenger.of(context)
                                //         .showSnackBar(snackBar);
                                //   }
                              }
                            },
                            child: BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state is SignUpLoadingState)
                                  return CircularProgressIndicator();
                                else
                                  return Text("انشاء حساب");
                              },
                            ),
                          );
                        },
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
                        style: AppTextStyle.greyStyle(size: 14),
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
                          style: AppTextStyle.greyStyle(size: 12),
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