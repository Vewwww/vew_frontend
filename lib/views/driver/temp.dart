// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vewww/bloc/car_cubit/car_cubit.dart';
// import 'package:vewww/views/driver/select_car_model.dart';
// import 'package:vewww/views/driver/select_car_type_screen.dart';

// import '../../bloc/add_car_cubit/add_car_cubit.dart';
// import '../../bloc/gender_cubit/gender_cubit.dart';
// import '../../bloc/reminder_cubit/reminder_cubit.dart';
// import '../../bloc/select_choice_cubit/select_choice_cubit.dart';
// import '../../bloc/select_color_cubit/select_color_cubit.dart';
// import '../../core/components/custom_text_field.dart';
// import '../../core/components/logo.dart';
// import '../../core/style/app_Text_Style/app_text_style.dart';
// import '../../core/style/app_colors.dart';
// import '../../core/utils/navigation.dart';
// import '../../model/car.dart';
// import '../../model/car_type.dart';
// import '../../model/driver.dart';
// import '../../model/profile_response.dart';
// import 'driver_home_screen.dart';
// import '../common/select_color_screen.dart';

// class EditDriverProfile extends StatefulWidget {
//   String? color;
//   ProfileData driver;

//   EditDriverProfile({required this.driver, this.color, Key? key})
//       : super(key: key) {
//     print("from edit const ${driver.toJson()}");
//   }

//   @override
//   State<EditDriverProfile> createState() => _EditDriverProfileState(driver);
// }

// class _EditDriverProfileState extends State<EditDriverProfile> {
//   String? carType;
//   ProfileData driver;

//   _EditDriverProfileState(this.driver) {
//     print("from state const ${driver.user.toString()}");
//     print("from state const ${driver.cars!.length}");
//     _email.text = driver.user!.email!;
//     _name.text = driver.user!.name!;
//     _phone.text = driver.user!.phoneNumber!;
//   }
//   final GlobalKey<FormState> _formKey = GlobalKey();

//   final TextEditingController _email = TextEditingController();

//   final TextEditingController _name = TextEditingController();

//   final TextEditingController _phone = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     var genderCubit = context.read<GenderCubit>();
//     int c = (widget.driver.user!.gender == "male") ? 1 : 0;
//     genderCubit.choseGender(c);
//     var carCubit = context.read<AddCarCubit>();
//     carCubit.cars = (driver.cars != null) ? driver.cars! : [];
//   }

//   @override
//   Widget build(BuildContext context) {
//     var constraintsHight = MediaQuery.of(context).size.height;
//     AddCarCubit addCarCubit = AddCarCubit.get(context);
//     GenderCubit genderCubit = GenderCubit.get(context);
//     ReminderCubit reminderCubit = ReminderCubit.get(context);
//     SelectChoiceCubit selectChoiceCubit = SelectChoiceCubit.get(context);
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
//           child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: constraintsHight / 30),
//                   Center(child: Logo(size: 170)),
//                   SizedBox(height: constraintsHight / 60),
//                   const Divider(
//                     thickness: 1.2,
//                     color: Color.fromARGB(255, 209, 209, 209),
//                   ),
//                   const SizedBox(height: 10),
//                   CustomTextField(
//                     controller: _name,
//                     label: "Name",
//                     validator: (value) {
//                       if (value!.isEmpty || value == null) {
//                         return 'Name is required';
//                       }
//                     },
//                   ),
//                   CustomTextField(
//                     label: "Email",
//                     controller: _email,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Email is required';
//                       } else if (!value.contains('@') || !value.contains('.')) {
//                         return 'Please Enter Valid Email';
//                       }
//                       return null;
//                     },
//                   ),
//                   Text(
//                     "Gender",
//                     style: AppTextStyle.darkGreyStyle(size: 14),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   SizedBox(
//                     height: 20,
//                     //TODO::Send gender as male or female
//                     child: BlocConsumer<GenderCubit, GenderState>(
//                         listener: (context, snapshot) {},
//                         builder: (context, snapshot) {
//                           return Row(
//                             children: [
//                               Radio<int>(
//                                   value: 1,
//                                   activeColor: mainColor,
//                                   groupValue: genderCubit.gender,
//                                   onChanged: (val) {
//                                     (val != null)
//                                         ? genderCubit.choseGender(1)
//                                         : genderCubit.choseGender(-1);
//                                   }),
//                               const Text("Male"),
//                               const Expanded(child: SizedBox()),
//                               Radio<int>(
//                                   activeColor: mainColor,
//                                   value: 2,
//                                   groupValue: genderCubit.gender,
//                                   onChanged: (val) {
//                                     (val != null)
//                                         ? genderCubit.choseGender(2)
//                                         : genderCubit.choseGender(-1);
//                                   }),
//                               const Text("Female"),
//                             ],
//                           );
//                         }),
//                   ),
//                   CustomTextField(
//                     label: "Phone Number",
//                     controller: _phone,
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value!.isEmpty || value == null) {
//                         return 'Phone number is required';
//                       }
//                     },
//                   ),
//                   CustomTextField(
//                     label: "License Renewal Date",
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value!.isEmpty || value == null) {
//                         return 'License Renewal Date is required';
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   /*(addCarCubit.cars.length == 0)
//                                   ? Text(
//                                       "No cars",
//                                       style: AppTextStyle.greyStyle(size: 18),
//                                     )
//                                   : */
//                   SizedBox(
//                     height: 500,
//                     child: ListView.builder(
//                         itemCount: addCarCubit.cars.length + 1,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             children: [
//                               Stack(
//                                 children: [
//                                   const Divider(
//                                     color: Colors.grey,
//                                   ),
//                                   BlocConsumer<AddCarCubit, AddCarState>(
//                                     listener: (context, state) {},
//                                     builder: (context, state) {
//                                       return InkWell(
//                                         onTap: () {
//                                           (index == addCarCubit.cars.length)
//                                               ? addCarCubit.remove(index)
//                                               : addCarCubit.add(Car());
//                                         },
//                                         child: CircleAvatar(
//                                           radius: 14,
//                                           backgroundColor:
//                                               (index != addCarCubit.cars.length)
//                                                   ? Colors.grey
//                                                   : mainColor,
//                                           child: Icon(
//                                             (index == addCarCubit.cars.length)
//                                                 ? Icons.add
//                                                 : Icons.remove,
//                                             size: 15,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 10),
//                               (index != addCarCubit.cars.length)
//                                   ? Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                           Center(
//                                               child: CircleAvatar(
//                                                   radius: 30,
//                                                   backgroundColor: mainColor
//                                                       .withOpacity(0.3),
//                                                   child: const Icon(
//                                                       Icons.drive_eta,
//                                                       size: 30,
//                                                       //TODO::confirm color structure with back team
//                                                       color: Colors
//                                                           .black // driver.cars![0].color,
//                                                       ))),
//                                           CustomTextField(
//                                             label: "Car Plat Number",
//                                             validator: (value) {
//                                               if (value!.isEmpty ||
//                                                   value == null) {
//                                                 return 'Car Number is required';
//                                               }
//                                             },
//                                           ),
//                                           CustomTextField(
//                                             label:
//                                                 "Last Periodic Maintenance Date",
//                                             validator: (value) {
//                                               if (value!.isEmpty ||
//                                                   value == null) {
//                                                 return 'Last Periodic Maintenance Date is required';
//                                               }
//                                             },
//                                           ),
//                                           CustomTextField(
//                                             label: "License renewal date",
//                                             validator: (value) {
//                                               if (value!.isEmpty ||
//                                                   value == null) {
//                                                 return 'License renewal date is required';
//                                               }
//                                             },
//                                           ),
//                                           CustomTextField(
//                                             label: "Miles",
//                                             keyboardType: TextInputType.number,
//                                             validator: (value) {
//                                               if (value!.isEmpty ||
//                                                   value == null) {
//                                                 return 'Miles is required';
//                                               }
//                                             },
//                                           ),
//                                           CustomTextField(
//                                             label: "Average Miles per week",
//                                             keyboardType: TextInputType.number,
//                                             validator: (value) {
//                                               if (value!.isEmpty ||
//                                                   value == null) {
//                                                 return 'Average Miles per week is required';
//                                               }
//                                             },
//                                           ),
//                                           BlocConsumer<SelectChoiceCubit,
//                                                   SelectChoiceState>(
//                                               listener: (context, snapshot) {},
//                                               builder: (context, snapshot) {
//                                                 return Column(
//                                                   children: [
//                                                     CustomTextField(
//                                                       label: "Car Type",
//                                                       //controller: _carType,
//                                                       hint: (selectChoiceCubit
//                                                                   .carTypeResponse !=
//                                                               null)
//                                                           ? selectChoiceCubit
//                                                               .carTypeResponse!
//                                                               .carType![SelectChoiceCubit
//                                                                       .get(
//                                                                           context)
//                                                                   .carTypeChoice]
//                                                               .name!
//                                                               .en!
//                                                           : "",
//                                                       isDroped: true,
//                                                       onDrop: () {
//                                                         selectChoiceCubit
//                                                             .getAllCarTypes();
//                                                         NavigationUtils.navigateTo(
//                                                             context: context,
//                                                             destinationScreen:
//                                                                 SelectCarTypeScreen());
//                                                       },
//                                                       validator: (value) {
//                                                         if (selectChoiceCubit
//                                                                 .carTypeResponse ==
//                                                             null) {
//                                                           return "car type is required";
//                                                         }
//                                                       },
//                                                     ),
//                                                     CustomTextField(
//                                                       label: "Car Model",
//                                                       //controller: _carModel,
//                                                       hint: (selectChoiceCubit
//                                                                   .carModelResponse !=
//                                                               null)
//                                                           ? selectChoiceCubit
//                                                               .carModelResponse!
//                                                               .carModels![SelectChoiceCubit
//                                                                       .get(
//                                                                           context)
//                                                                   .carModelChoice]
//                                                               .name!
//                                                           : "",
//                                                       isDroped: true,
//                                                       onDrop: () {
//                                                         if (selectChoiceCubit
//                                                                 .carTypeResponse !=
//                                                             null) {
//                                                           String id = selectChoiceCubit
//                                                               .carTypeResponse!
//                                                               .carType![
//                                                                   selectChoiceCubit
//                                                                       .carTypeChoice]
//                                                               .sId!;
//                                                           selectChoiceCubit
//                                                               .getAllCarModels(
//                                                                   id);
//                                                           NavigationUtils.navigateTo(
//                                                               context: context,
//                                                               destinationScreen:
//                                                                   SelectCarModelScreen(
//                                                                       id: id));
//                                                         } else {
//                                                           const snackBar = SnackBar(
//                                                               content: Text(
//                                                                   "Please chose car type first!"));
//                                                           ScaffoldMessenger.of(
//                                                                   context)
//                                                               .showSnackBar(
//                                                                   snackBar);
//                                                         }
//                                                       },
//                                                       validator: (value) {
//                                                         if (selectChoiceCubit
//                                                                 .carTypeResponse ==
//                                                             null) {
//                                                           return "car type is required";
//                                                         }
//                                                       },
//                                                     ),
//                                                   ],
//                                                 );
//                                               }),
//                                         ])
//                                   : Container()
//                             ],
//                           );
//                         }),
//                   ),
//                   // Stack(
//                   //   children: [
//                   //     const Divider(
//                   //       color: Colors.grey,
//                   //     ),
//                   //     BlocConsumer<AddCarCubit, AddCarState>(
//                   //       listener: (context, state) {},
//                   //       builder: (context, state) {
//                   //         return InkWell(
//                   //           onTap: () {
//                   //             addCarCubit.add(Car());
//                   //           },
//                   //           child: CircleAvatar(
//                   //             radius: 14,
//                   //             backgroundColor: (addCarCubit.carExist)
//                   //                 ? Colors.grey
//                   //                 : mainColor,
//                   //             child: Icon(
//                   //               (!addCarCubit.carExist)
//                   //                   ? Icons.add
//                   //                   : Icons.remove,
//                   //               size: 15,
//                   //               color: Colors.white,
//                   //             ),
//                   //           ),
//                   //         );
//                   //       },
//                   //     ),
//                   //   ],
//                   // ),
//                   // const SizedBox(height: 10),
//                   // //TODO:: add car model
//                   // BlocConsumer<AddCarCubit, AddCarState>(
//                   //   listener: (context, state) {},
//                   //   builder: (context, state) {
//                   //     if (!addCarCubit.carExist) {
//                   //       return Text(
//                   //         "No cars",
//                   //         style: AppTextStyle.greyStyle(size: 18),
//                   //       );
//                   //     } else {
//                   //       return Column(
//                   //         crossAxisAlignment: CrossAxisAlignment.start,
//                   //         children: [
//                   //           Center(
//                   //               child: CircleAvatar(
//                   //                   radius: 30,
//                   //                   backgroundColor: mainColor.withOpacity(0.3),
//                   //                   child: const Icon(Icons.drive_eta,
//                   //                       size: 30,
//                   //                       //TODO::confirm color structure with back team
//                   //                       color: Colors
//                   //                           .black // driver.cars![0].color,
//                   //                       ))),
//                   //           BlocConsumer<SelectChoiceCubit, SelectChoiceState>(
//                   //               listener: (context, snapshot) {},
//                   //               builder: (context, snapshot) {
//                   //                 return Column(
//                   //                   children: [
//                   //                     CustomTextField(
//                   //                       label: "Car Type",
//                   //                       controller: _carType,
//                   //                       hint: (selectChoiceCubit
//                   //                                   .carTypeResponse !=
//                   //                               null)
//                   //                           ? selectChoiceCubit
//                   //                               .carTypeResponse!
//                   //                               .carType![SelectChoiceCubit.get(
//                   //                                       context)
//                   //                                   .carTypeChoice]
//                   //                               .name!
//                   //                               .en!
//                   //                           : "",
//                   //                       isDroped: true,
//                   //                       onDrop: () {
//                   //                         selectChoiceCubit.getAllCarTypes();
//                   //                         NavigationUtils.navigateTo(
//                   //                             context: context,
//                   //                             destinationScreen:
//                   //                                 SelectCarTypeScreen());
//                   //                       },
//                   //                       validator: (value) {
//                   //                         if (selectChoiceCubit
//                   //                                 .carTypeResponse ==
//                   //                             null) {
//                   //                           return "car type is required";
//                   //                         }
//                   //                       },
//                   //                     ),
//                   //                     CustomTextField(
//                   //                       label: "Car Model",
//                   //                       controller: _carModel,
//                   //                       hint: (selectChoiceCubit
//                   //                                   .carModelResponse !=
//                   //                               null)
//                   //                           ? selectChoiceCubit
//                   //                               .carModelResponse!
//                   //                               .carModels![
//                   //                                   SelectChoiceCubit.get(
//                   //                                           context)
//                   //                                       .carModelChoice]
//                   //                               .name!
//                   //                           : "",
//                   //                       isDroped: true,
//                   //                       onDrop: () {
//                   //                         if (selectChoiceCubit
//                   //                                 .carTypeResponse !=
//                   //                             null) {
//                   //                           String id = selectChoiceCubit
//                   //                               .carTypeResponse!
//                   //                               .carType![selectChoiceCubit
//                   //                                   .carTypeChoice]
//                   //                               .sId!;
//                   //                           selectChoiceCubit
//                   //                               .getAllCarModels(id);
//                   //                           NavigationUtils.navigateTo(
//                   //                               context: context,
//                   //                               destinationScreen:
//                   //                                   SelectCarModelScreen(
//                   //                                       id: id));
//                   //                         } else {
//                   //                           const snackBar = SnackBar(
//                   //                               content: Text(
//                   //                                   "Please chose car type first!"));
//                   //                           ScaffoldMessenger.of(context)
//                   //                               .showSnackBar(snackBar);
//                   //                         }
//                   //                       },
//                   //                       validator: (value) {
//                   //                         if (selectChoiceCubit
//                   //                                 .carTypeResponse ==
//                   //                             null) {
//                   //                           return "car type is required";
//                   //                         }
//                   //                       },
//                   //                     ),
//                   //                   ],
//                   //                 );
//                   //               }),
//                   //*** */
//                   //           BlocConsumer<SelectColorCubit, SelectColorState>(
//                   //               listener: (context, snapshot) {},
//                   //               builder: (context, snapshot) {
//                   //                 return CustomTextField(
//                   //                   label: "Car Color",
//                   //                   // hint: colors[
//                   //                   //     SelectColorCubit.get(context).color],
//                   //                   isDroped: true,
//                   //                   onDrop: () {
//                   //                     NavigationUtils.navigateTo(
//                   //                         context: context,
//                   //                         destinationScreen:
//                   //                             SelectColorScreen());
//                   //                   },
//                   //                   validator: (value) {
//                   //                     if (selectChoiceCubit.carModelResponse ==
//                   //                         null) {
//                   //                       return "car model is required";
//                   //                     }
//                   //                   },
//                   //                 );
//                   //               }),
//                   //** */
//                   //           CustomTextField(
//                   //             label: "Car Plat Number",
//                   //             validator: (value) {
//                   //               if (addCarCubit.carExist) {
//                   //                 if (value!.isEmpty || value == null) {
//                   //                   return 'Car Number is required';
//                   //                 }
//                   //               }
//                   //             },
//                   //           ),
//                   //           CustomTextField(
//                   //             label: "Last Periodic Maintenance Date",
//                   //             validator: (value) {
//                   //               if (addCarCubit.carExist) {
//                   //                 if (value!.isEmpty || value == null) {
//                   //                   return 'Last Periodic Maintenance Date is required';
//                   //                 }
//                   //               }
//                   //             },
//                   //           ),
//                   //           CustomTextField(
//                   //             label: "License renewal date",
//                   //             validator: (value) {
//                   //               if (addCarCubit.carExist) {
//                   //                 if (value!.isEmpty || value == null) {
//                   //                   return 'License renewal date is required';
//                   //                 }
//                   //               }
//                   //             },
//                   //           ),
//                   //           CustomTextField(
//                   //             label: "Miles",
//                   //             keyboardType: TextInputType.number,
//                   //             validator: (value) {
//                   //               if (addCarCubit.carExist) {
//                   //                 if (value!.isEmpty || value == null) {
//                   //                   return 'Miles is required';
//                   //                 }
//                   //               }
//                   //             },
//                   //           ),
//                   //           CustomTextField(
//                   //             label: "Average Miles per week",
//                   //             keyboardType: TextInputType.number,
//                   //             validator: (value) {
//                   //               if (addCarCubit.carExist) {
//                   //                 if (value!.isEmpty || value == null) {
//                   //                   return 'Average Miles per week is required';
//                   //                 }
//                   //               }
//                   //             },
//                   //           ),
//                   /* */
//                   //           Text("Remind You Before?",
//                   //               style: AppTextStyle.darkGreyStyle(size: 14)),
//                   //           const SizedBox(
//                   //             height: 10,
//                   //           ),
//                   //           SizedBox(
//                   //             height: 20,
//                   //             child: BlocConsumer<ReminderCubit, ReminderState>(
//                   //                 listener: (context, snapshot) {},
//                   //                 builder: (context, snapshot) {
//                   //                   return Row(
//                   //                     children: [
//                   //                       Radio<int>(
//                   //                           value: 1,
//                   //                           activeColor: mainColor,
//                   //                           groupValue: reminderCubit.reminder,
//                   //                           onChanged: (val) {
//                   //                             (val != null)
//                   //                                 ? reminderCubit.choseTime(1)
//                   //                                 : reminderCubit.choseTime(-1);
//                   //                           }),
//                   //                       const Text("Week"),
//                   //                       const Expanded(child: SizedBox()),
//                   //                       Radio<int>(
//                   //                           activeColor: mainColor,
//                   //                           value: 2,
//                   //                           groupValue: reminderCubit.reminder,
//                   //                           onChanged: (val) {
//                   //                             (val != null)
//                   //                                 ? reminderCubit.choseTime(2)
//                   //                                 : reminderCubit.choseTime(-1);
//                   //                           }),
//                   //                       const Text("2 Weeks"),
//                   //                       const Expanded(child: SizedBox()),
//                   //                       Radio<int>(
//                   //                           activeColor: mainColor,
//                   //                           value: 3,
//                   //                           groupValue: reminderCubit.reminder,
//                   //                           onChanged: (val) {
//                   //                             (val != null)
//                   //                                 ? reminderCubit.choseTime(3)
//                   //                                 : reminderCubit.choseTime(-1);
//                   //                           }),
//                   //                       const Text("Month"),
//                   //                     ],
//                   //                   );
//                   //                 }),
//                   //           ),
//                   //         ],
//                   //       );
//                   //     }
//                   //   },
//                   // ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             NavigationUtils.navigateAndClearStack(
//                                 context: context,
//                                 destinationScreen: const DriverHomeScreen());
//                           }
//                         },
//                         child: const Text("Update"),
//                       )),
//                 ],
//               )),
//         ),
//       ),
//     );
//   }
// }
