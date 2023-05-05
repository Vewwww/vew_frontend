import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/model/car_type.dart';
import '../bloc/select_choice_cubit/select_choice_cubit.dart';
import '../core/components/custom_app_bar.dart';
import '../core/style/app_text_style/app_text_style.dart';

class SelectCarModelScreen extends StatelessWidget {
  const SelectCarModelScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SelectChoiceCubit selectChoiceCubit = SelectChoiceCubit.get(context);
    return Scaffold(
      //appBar:
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 45),
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: carTyps.length,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        selectChoiceCubit.chose(index);
                      },
                      child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                //width: double.infinity,
                                child: Text(
                                  carTyps[index].type,
                                  style: AppTextStyle.greyStyle(size: 20),
                                ),
                              ),
                              Container(
                                height: 15,
                                width: 15,
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    border: Border.all(color: mainColor),
                                    borderRadius: BorderRadius.circular(20)),
                                child: BlocConsumer<SelectChoiceCubit,
                                        SelectChoiceState>(
                                    listener: (context, state) {},
                                    builder: (context, snapshot) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: (selectChoiceCubit.choice ==
                                                    index)
                                                ? mainColor
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
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
                  "Car Type",
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
                  NavigationUtils.navigateBack(context: context);
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
