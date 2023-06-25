import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../core/components/custom_app_bar.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/style/app_colors.dart';
import '../../core/utils/navigation.dart';

class MechanicEditProfile extends StatelessWidget {
  MechanicEditProfile({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
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
                Text("تعديل الملف الشخصي", style: AppTextStyle.mainStyle(size: 20), textDirection: TextDirection.rtl,),
                const SizedBox(height: 10),
                const Divider(thickness: 2),
                const SizedBox(height: 10),
                CustomTextField(
                    isArabic: true,
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
                    Text("الخدمات", style: AppTextStyle.lightGrayTextStyle(14), textDirection: TextDirection.rtl,),
                  ],
                ),
                CustomTextField(
                    controller: _password,
                    label: "الخدمات",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'برجاء ادخال الخدمات ';
                      }
                      return null;
                    }),
    
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