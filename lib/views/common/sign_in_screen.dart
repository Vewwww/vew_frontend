import 'package:flutter/material.dart';
import 'package:vewww/views/winch/winch_home_page.dart';
import '../../bloc/add_car_cubit/add_car_cubit.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/logo.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';
import '../winch/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  SignInScreen({Key? key}) : super(key: key);

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
                  SizedBox(height: constraintsHight / 10),
                  Center(child: Logo()),
                  SizedBox(height: constraintsHight / 60),
                  Text(
                    " تسحيل الدخول",
                    style: AppTextStyle.titleTextStyle(20),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 1.2,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: "الايميل",
                    controller: _email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'برجاء ادخال الايميل';
                      }
                    },
                  ),
                  CustomTextField(
                    controller: _password,
                    label: "كلمة السر",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                    },
                  ),
                  SizedBox(height: 10),
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
                        child: Text("دخول"),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: Text("انشاء حساب",
                            style: AppTextStyle.titleTextStyle(14)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WinchSignUpScreen()),
                          );
                        },
                      ),
                      Text(
                        "لا تمتلك حساب ؟",
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
