import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/car_cubit/car_cubit.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/navigation.dart';
import '../../bloc/select_color_cubit/select_color_cubit.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/style/app_text_style/app_text_style.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/profile_response.dart';
import '../driver/edit_driver_profile.dart';

class SelectColorScreen extends StatelessWidget {
  Widget? destinationScreen;
  ProfileData? driver;
  int? index;
  late bool isArabic;
  SelectColorScreen({this.index, this.destinationScreen, this.driver, Key? key})
      : super(key: key) {
    isArabic = (SharedPreferencesHelper.getData(key: "vewRole") != null &&
        SharedPreferencesHelper.getData(key: "vewRole") != "user");
  }

  @override
  Widget build(BuildContext context) {
    SelectColorCubit selectColorCubit = SelectColorCubit.get(context);
    CarCubit carCubit = CarCubit.get(context);
    return Scaffold(
      //appBar:
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 45),
            height: MediaQuery.of(context).size.height,
            child: BlocConsumer<SelectColorCubit, SelectColorState>(
              listener: (context, state) {},
              builder: (context, state) {
                print(state);
                if (state is GettingColorsSuccessState ||
                    state is ColorChoiceSelected) {
                  return ListView.builder(
                      itemCount:
                          selectColorCubit.carColorResponse!.carColor!.length,
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              selectColorCubit.choseColor(index);
                            },
                            child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: Row(
                                  mainAxisAlignment: (isArabic)
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      //width: double.infinity,
                                      child: Text(
                                        (isArabic)
                                            ? selectColorCubit.carColorResponse!
                                                .carColor![index].name!.ar!
                                            : selectColorCubit.carColorResponse!
                                                .carColor![index].name!.en!,
                                        style: AppTextStyle.greyStyle(size: 20),
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Container(
                                      height: 15,
                                      width: 15,
                                      margin: const EdgeInsets.all(4),
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: mainColor),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: BlocConsumer<SelectColorCubit,
                                              SelectColorState>(
                                          listener: (context, state) {},
                                          builder: (context, snapshot) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      (selectColorCubit.color ==
                                                              index)
                                                          ? mainColor
                                                          : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            );
                                          }),
                                    ),
                                  ],
                                )),
                          ));
                } else {
                  return Center(
                      child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 3),
                      const CircularProgressIndicator(),
                    ],
                  ));
                }
              },
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: CustomAppBar(
                haveBackArrow: true,
                title: Text(
                  (isArabic) ? "لون السيارة" : "Car Color",
                  style: AppTextStyle.mainStyle(),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 11 / 12,
              child: ElevatedButton(
                onPressed: () {
                  CarCubit carCubit = CarCubit.get(context);
                  if (index != null)
                    carCubit.updatedCars![index!].color = selectColorCubit
                        .carColorResponse!.carColor![selectColorCubit.color];
                  if (destinationScreen == null)
                    NavigationUtils.navigateBack(context: context);
                  else {
                    print("des : $destinationScreen");
                    if (destinationScreen is EditDriverProfile) {
                      print("going to edit");
                      NavigationUtils.navigateAndClearStack(
                          context: context,
                          destinationScreen: EditDriverProfile(
                            driver: driver!,
                            inProgress: true,
                          ));
                    } else
                      NavigationUtils.navigateAndClearStack(
                          context: context,
                          destinationScreen: destinationScreen!);
                  }
                },
                child: const Text("Done"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
