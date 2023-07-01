import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/profile_cubit/profile_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/views/admin/admin_edit_profile.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/style/app_colors.dart';
import '../../core/utils/navigation.dart';
import '../../model/admin.dart';

class AdminProfile extends StatefulWidget {
  AdminProfile({Key? key}) : super(key: key) {
    // _name.text = admin .name!;
    // _email.text = admin.email!;
    // _phone.text = admin.phoneNumber!;
  }

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _phone = TextEditingController();
  @override
  void initState() {
    super.initState();
    var profileCubit = context.read<ProfileCubit>();
    profileCubit.getAdminProfile();
  }

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
                CustomAppBar(
                  haveBackArrow: true,
                  iconColor: Colors.white,
                ),
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
                  _name.text,
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
                              if(profileCubit.state is GettingProfileSuccessState)
                              NavigationUtils.navigateTo(
                                  context: context,
                                  destinationScreen: AdminEditProfile( profileCubit.adminProfileResponse.admin ));
                            },
                          )),
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          if (state is GettingProfileSuccessState) {
                            return Column(
                              children: [
                                CustomTextField(
                                  readOnly: true,
                                  label: "Name",
                                  //controller: _name,
                                  hint: profileCubit
                                      .adminProfileResponse!.admin!.name,
                                  validator: (value) {},
                                ),
                                CustomTextField(
                                  readOnly: true,
                                  label: "Email",
                                  //controller: _email,
                                  hint: profileCubit
                                      .adminProfileResponse!.admin!.email,
                                  validator: (value) {},
                                ),
                                CustomTextField(
                                  readOnly: true,
                                  label: "Phone Number",
                                  hint: profileCubit
                                      .adminProfileResponse!.admin!.phoneNumber,
//controller: _phone,
                                  validator: (value) {},
                                ),
                              ],
                            );
                          } else {
                            return Center(
                                child: Column(
                              children: [
                                SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 3),
                                CircularProgressIndicator(),
                              ],
                            ));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
