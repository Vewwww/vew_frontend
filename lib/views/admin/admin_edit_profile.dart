import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/profile_cubit/profile_cubit.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/views/admin/admin_home_screen.dart';
import 'package:vewww/views/admin/admin_profile.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../model/admin.dart';

class AdminEditProfile extends StatelessWidget {
  Admin admin;
  AdminEditProfile({Key? key, required this.admin}) : super(key: key) {
    _email.text = admin.email!;
    _name.text = admin.name!;
    _phone.text = admin.phoneNumber!;
  }
  final TextEditingController _name = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _phone = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = ProfileCubit.get(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomAppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    NavigationUtils.navigateTo(
                        context: context, destinationScreen: AdminProfile());
                  },
                ),
                haveLogo: true,
              ),
              Text(
                'Edit Profile',
                style: AppTextStyle.mainStyle(size: 20),
              ),
              const SizedBox(height: 10),
              const Divider(thickness: 2),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: _name,
                  label: "Name",
                  validator: (value) {
                    if (value!.length < 1 || value == null) {
                      return '*Required';
                    }
                  }),
              CustomTextField(
                  label: "Email",
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  hint: "example@mail.com",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    } else if (!value.contains('@') || !value.contains('.')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  }),
              CustomTextField(
                  label: 'Phone Number',
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    } else if (value.length != 11) {
                      return 'Please enter a valid phone number of 11 numbers';
                    }
                    return null;
                  }),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return defaultButton(
                      text: 'Update',
                      function: () async {
                        if (_formKey.currentState!.validate()) {
                          Admin admin = Admin(
                              name: _name.text,
                              email: _email.text,
                              phoneNumber: _phone.text);
                          await profileCubit.updateAdminProfile(admin);
                          if (state is EdittingProfileSuccessState) {
                            NavigationUtils.navigateAndClearStack(
                                context: context,
                                destinationScreen: AdminHomeScreen());
                          }
                        }
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
