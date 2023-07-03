import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/core/utils/sp_helper/cache_helper.dart';
import '../../bloc/car_cubit/car_cubit.dart';
import '../../bloc/select_choice_cubit/select_choice_cubit.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/style/app_text_style/app_text_style.dart';

class SelectCarModelScreen extends StatefulWidget {
  SelectCarModelScreen(
      {required this.id, this.index, this.destinationScreen, Key? key})
      : super(key: key);
  Widget? destinationScreen;
  String id;
  int? index;

  @override
  State<SelectCarModelScreen> createState() => _SelectCarModelScreenState(id,
      destinationScreen: destinationScreen, index: this.index);
}

class _SelectCarModelScreenState extends State<SelectCarModelScreen> {
  _SelectCarModelScreenState(this.id, {this.destinationScreen, this.index});
  String id;
  int? index;
  Widget? destinationScreen;

  @override
  void initState() {
    super.initState();
    var carModelCubit = context.read<SelectChoiceCubit>();
    print("id:$id");
    carModelCubit.getAllCarModels(id);
  }

  @override
  Widget build(BuildContext context) {
    SelectChoiceCubit selectChoiceCubit = SelectChoiceCubit.get(context);
    return Scaffold(
      //appBar:
      body: BlocConsumer<SelectChoiceCubit, SelectChoiceState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (selectChoiceCubit.state is GetAllCarModelsSuccessState ||
              selectChoiceCubit.state is CarModelChoiceSelected) {
            return Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 45),
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount:
                          selectChoiceCubit.carModelResponse!.carModels!.length,
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              selectChoiceCubit.choseCarModel(index);
                            },
                            child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      //width: double.infinity,
                                      child: Text(
                                          selectChoiceCubit.carModelResponse!
                                              .carModels![index].name!,
                                          style:
                                              AppTextStyle.greyStyle(size: 20)),
                                    ),
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
                                                              .carModelChoice ==
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
                        "Car Model",
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
                        if (this.index != null &&
                            selectChoiceCubit
                                    .carModelResponse!.carModels!.length >
                                0)
                          CarCubit.get(context).updatedCars![index!].carModel =
                              selectChoiceCubit.carModelResponse!
                                  .carModels![selectChoiceCubit.carModelChoice];
                        if (destinationScreen == null) {
                          NavigationUtils.navigateBack(context: context);
                        } else
                          NavigationUtils.navigateAndClearStack(
                              context: context,
                              destinationScreen: destinationScreen!);
                      },
                      child: const Text("Done"),
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
