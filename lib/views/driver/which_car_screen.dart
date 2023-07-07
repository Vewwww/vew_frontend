import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/model/repairer.dart';
import 'package:vewww/views/driver/mechanic_preview_screen.dart';

import '../../bloc/car_cubit/car_cubit.dart';
import '../../core/components/which_car_card.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';
import 'nearest_winch_screen.dart';

class WhichCarScreen extends StatefulWidget {
  String id;
  Repairer? repairer;
  bool isWinch;
  WhichCarScreen({super.key, required this.id, this.repairer, required this.isWinch});

  @override
  State<WhichCarScreen> createState() => _WhichCarScreenState(id, isWinch);
}

class _WhichCarScreenState extends State<WhichCarScreen> {
  String id;
  bool isWinch;
  _WhichCarScreenState(this.id, this.isWinch);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final carCubit = context.read<CarCubit>();
    carCubit.getAllDriverCars(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            haveBackArrow: true,
            title: Text(
              'Choose which car',
              style: AppTextStyle.mainStyle(size: 25),
            ),
          ),
          Image.asset(
            'assets/images/Logo(1).png',
            height: 120,
            width: 150,
          ),
          BlocBuilder<CarCubit, CarState>(
            builder: (context, state) {
              if (state is GetAllDriverCarsSuccessState) {
                return Expanded(
                    child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: state.allCars.length,
                        separatorBuilder: (context, index) => SizedBox(
                              height: 15,
                            ),
                        itemBuilder: (context, index) {
                          return whichCarCard(
                            function: () {
                              if(isWinch){
                              NavigationUtils.navigateTo(
                                  context: context,
                                  destinationScreen: NearestWinchScreen(
                                      carId: state.allCars[index].sId!));
                              }else{
                                NavigationUtils.navigateTo(
                                  context: context,
                                  destinationScreen: MechanicPreviewScreen(
                                      carId: state.allCars[index].sId!,
                                      mechanic:widget.repairer as Mechanic,
                                      ));
                              }
                            },
                            carColor:state.allCars[index].color!.code!,
                            carModel: state.allCars[index].carModel!.name!,
                            carType: state.allCars[index].carType!.name!.en!,
                          );
                        }));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
