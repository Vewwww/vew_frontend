import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/admin_analysis_cubit/admin_analysis_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';


class UsersAnalysisScreen extends StatelessWidget {
  UsersAnalysisScreen({super.key});

  List<Color> colors = [
    Color.fromRGBO(2, 113, 106, 1),
    Color.fromRGBO(15, 150, 156, 1),
    Color.fromARGB(255, 2, 87, 87)
  ];

  // void initState() {
  //   super.initState();
  //   final adminAnalysisCubit = context.read<AdminAnalysisCubit>();
  //   adminAnalysisCubit.getUserAnalysis();
  // }

  @override
  Widget build(BuildContext context) {
    AdminAnalysisCubit adminAnalysisCubit = AdminAnalysisCubit.get(context);
    return Scaffold(
      body: BlocBuilder<AdminAnalysisCubit, AdminAnalysisState>(
        builder: (context, state) {
          if (state is GetUserAnalysisSuccessState) {
            print(state);
            return Column(children: [
              CustomAppBar(
                haveLogo: true,
                haveBackArrow: true,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'This pie chart show the percentage of drivers, winch drivers and mechanics using Vewww.',
                style: AppTextStyle.boldStyle(size: 20),
              ),
              SizedBox(
                height: 10,
              ),
              PieChart(
                dataMap: {
                  "Driver": state.userAnalysisResponse.numOfDrivers!,
                  "Winch": state.userAnalysisResponse.numOfWinches!,
                  "Mechanic":
                      state.userAnalysisResponse.numOfMechanists! as double,
                },
                animationDuration: Duration(milliseconds: 800),
                //chartLegendSpacing: 42,
                chartRadius: MediaQuery.of(context).size.width / 2,
                colorList: colors,
                //initialAngleInDegree: 0,
                chartType: ChartType.disc,
                ringStrokeWidth: 32,
                //centerText: "Users",
                legendOptions: LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: true,
                  //legendShape: _BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                  decimalPlaces: 1,
                ),
                // gradientList: ---To add gradient colors---
                // emptyColorGradient: ---Empty Color gradient---
              )
            ]);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}