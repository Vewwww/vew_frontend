import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/car_cubit/car_cubit.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/navigation.dart';
import '../../bloc/select_choice_cubit/select_choice_cubit.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/style/app_text_style/app_text_style.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/profile_response.dart';
import 'edit_driver_profile.dart';

class SelectCarTypeScreen extends StatelessWidget {
  SelectCarTypeScreen(
      {this.destinationScreen, this.driver, this.index, Key? key})
      : super(key: key) {
    isArabic = (SharedPreferencesHelper.getData(key: "vewRole") != null &&
        SharedPreferencesHelper.getData(key: "vewRole") != "user");
  }
  Widget? destinationScreen;
  late bool isArabic;
  ProfileData? driver;
  int? index;
  @override
  Widget build(BuildContext context) {
    SelectChoiceCubit selectChoiceCubit = SelectChoiceCubit.get(context);
    return Scaffold(
      //appBar:
      body: BlocConsumer<SelectChoiceCubit, SelectChoiceState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (selectChoiceCubit.state is GetAllCarTypesSuccessState ||
              selectChoiceCubit.state is CarTypeChoiceSelected) {
            return Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 45),
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount:
                          selectChoiceCubit.carTypeResponse!.carType!.length,
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              selectChoiceCubit.choseCarType(index);
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
                                              ? selectChoiceCubit
                                                  .carTypeResponse!
                                                  .carType![index]
                                                  .name!
                                                  .ar!
                                              : selectChoiceCubit
                                                  .carTypeResponse!
                                                  .carType![index]
                                                  .name!
                                                  .en!,
                                          style:
                                              AppTextStyle.greyStyle(size: 20)),
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
                                      child: BlocConsumer<SelectChoiceCubit,
                                              SelectChoiceState>(
                                          listener: (context, state) {},
                                          builder: (context, snapshot) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  color: (selectChoiceCubit
                                                              .carTypeChoice ==
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
                          )),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: CustomAppBar(
                      haveBackArrow: true,
                      title: Text(
                        (isArabic) ? "نوع السيارة" : "Car Type",
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
                      onPressed: () async {
                        if (this.index != null)
                          CarCubit.get(context).updatedCars![index!].carType =
                              selectChoiceCubit.carTypeResponse!
                                  .carType![selectChoiceCubit.carTypeChoice];
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
                      child: Text((isArabic) ? "تم" : "Done"),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
                child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 3),
                CircularProgressIndicator(),
              ],
            ));
          }
        },
      ),
    );
  }
}
