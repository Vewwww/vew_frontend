import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/profile_cubit/profile_cubit.dart';
import 'package:vewww/bloc/service_cubit/services_cubit.dart';
import 'package:vewww/model/mechanic_shop.dart';
import 'package:vewww/views/common/services_screen.dart';
import 'package:vewww/views/mechanic/mechanic_home_screen.dart';
import 'package:vewww/views/mechanic/mechanic_profile.dart';

import '../../core/components/custom_app_bar.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/style/app_colors.dart';
import '../../core/utils/navigation.dart';
import '../../model/services.dart';

class MechanicEditProfile extends StatefulWidget {
  MechanicEditProfile(this.mechanicShop, {super.key});
  MechanicShop mechanicShop;

  @override
  State<MechanicEditProfile> createState() =>
      _MechanicEditProfileState(mechanicShop);
}

class _MechanicEditProfileState extends State<MechanicEditProfile> {
  MechanicShop mechanicShop;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _name = TextEditingController();

  final TextEditingController _phone = TextEditingController();

  final TextEditingController _ownerName = TextEditingController();

  final TextEditingController _ownerPhone = TextEditingController();
  _MechanicEditProfileState(this.mechanicShop);
  @override
  void initState() {
    super.initState();
    var servicesCubit = context.read<ServicesCubit>();
    servicesCubit.selectedServices = mechanicShop.service ?? [];
    _email.text = mechanicShop.email!;
    _name.text = mechanicShop.name!;
    _phone.text = mechanicShop.phoneNumber!;
    _ownerName.text = mechanicShop.ownerName!;
    _ownerPhone.text = mechanicShop.mechanicPhone!;
  }

  @override
  Widget build(BuildContext context) {
    double constraintsHight = MediaQuery.of(context).size.height;
    ServicesCubit servicesCubit = ServicesCubit.get(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  CustomAppBar(
                    //haveBackArrow: true,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: mainColor,
                      ),
                      onPressed: () {
                        NavigationUtils.navigateAndClearStack(
                            context: context,
                            destinationScreen: MechanicProfile());
                      },
                    ),
                    haveLogo: true,
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      "تعديل الملف الشخصي",
                      style: AppTextStyle.mainStyle(size: 20),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 2),
                  const SizedBox(height: 10),
                  CustomTextField(
                      isArabic: true,
                      controller: _name,
                      label: "اسم الورشة",
                      validator: (value) {
                        if (value!.length < 1 || value == null) {
                          return 'برجاء ادخال الاسم';
                        }
                      }),
                  CustomTextField(
                      label: "الايميل",
                      isArabic: true,
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      hint: "example@mail.com",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'برجاء ادخال الايميل';
                        } else if (!value.contains('@') ||
                            !value.contains('.')) {
                          return 'برجاء ادخال ايميل صحيح ';
                        }
                        return null;
                      }),
                  CustomTextField(
                      isArabic: true,
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
                  CustomTextField(
                      isArabic: true,
                      controller: _ownerName,
                      label: "اسم المالك",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'برجاء ادخال اسم المالك ';
                        }
                        return null;
                      }),
                  CustomTextField(
                      controller: _ownerPhone,
                      isArabic: true,
                      label: "رقم هاتف المالك",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'برجاء ادخال رقم الهاتف';
                        } else if (value.length != 11) {
                          return "يجب ان يكون رقم الهاتف مكون من 11 رقم  ";
                        }
                        return null;
                      }),
                  const Divider(color: Colors.grey, thickness: 0.8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            MechanicShop m = widget.mechanicShop;
                            m.email = _email.text;
                            m.name = _name.text;
                            m.phoneNumber = _phone.text;
                            m.ownerName = _ownerName.text;
                            m.mechanicPhone = _ownerPhone.text;
                            NavigationUtils.navigateTo(
                                context: context,
                                destinationScreen: ServicesScreen(
                                  mechanicShop: m,
                                  multiSelect: true,
                                ));
                          },
                          child: Text(
                            "Add Service",
                            style: AppTextStyle.mainStyle(size: 12),
                          )),
                      Text(
                        "الخدمات",
                        style: AppTextStyle.lightGrayTextStyle(20),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                  (servicesCubit.selectedServices != null &&
                          servicesCubit.selectedServices.length > 0)
                      ? BlocConsumer<ServicesCubit, ServicesState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount:
                                    servicesCubit.selectedServices.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              servicesCubit.removeWithId(
                                                  servicesCubit
                                                      .selectedServices[index]
                                                      .sId);
                                            },
                                            child: Text(
                                              "remove",
                                              style: AppTextStyle.greyStyle(
                                                  size: 12),
                                            )),
                                        Text(servicesCubit
                                            .selectedServices[index].name!.ar!)
                                      ],
                                    ));
                          })
                      : Center(
                          child: Text("No Services"),
                        ),
                  (servicesCubit.selectedServices.length > 0)
                      ? Column(
                          children: [],
                        )
                      : Container(),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (servicesCubit.selectedServices.length > 0) {
                            MechanicShop m = widget.mechanicShop;
                            m.email = _email.text;
                            m.name = _name.text;
                            m.phoneNumber = _phone.text;
                            m.ownerName = _ownerName.text;
                            m.mechanicPhone = _ownerPhone.text;
                            m.service = servicesCubit.selectedServices;
                            print("editted version : ${m.toJson()}");
                            ProfileCubit profileCubit =
                                ProfileCubit.get(context);
                            await profileCubit.updateMechanicProfile(m);
                            if (profileCubit.state
                                is EdittingProfileSuccessState)
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MechanicHomeScreen()),
                              );
                          } else {
                            const snackBar = SnackBar(
                                content: Text("Please choose service first"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      },
                      child: BlocConsumer<ProfileCubit, ProfileState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return Text((state is EdittingProfileLoadingState)
                                ? "Loading..."
                                : "حفظ");
                          }),
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
      ),
    );
  }
}
