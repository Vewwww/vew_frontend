import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/admin_analysis_cubit/admin_analysis_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';

class UsersAnalysisScreen extends StatefulWidget {
  UsersAnalysisScreen({super.key});

  @override
  State<UsersAnalysisScreen> createState() => _UsersAnalysisScreenState();
}

class _UsersAnalysisScreenState extends State<UsersAnalysisScreen> {
  List<Color> colors = [
    Color.fromRGBO(2, 113, 106, 1),
    Color.fromRGBO(15, 150, 156, 1),
    Color.fromARGB(255, 2, 87, 87)
  ];

  void initState() {
    super.initState();
    final adminAnalysisCubit = context.read<AdminAnalysisCubit>();
    adminAnalysisCubit.getUserAnalysis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AdminAnalysisCubit, AdminAnalysisState>(
        builder: (context, state) {
          if (state is GetUserAnalysisSuccessState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomAppBar(
                      haveLogo: true,
                      haveBackArrow: true,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      'This pie chart show the percentage of drivers, winch drivers and \nmechanics using Vewww.',
                      style: AppTextStyle.darkGreyStyle(size: 20),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    PieChart(
                      dataMap: {
                        "Driver": state.userAnalysisResponse.numOfDrivers!,
                        "Winch": state.userAnalysisResponse.numOfWinches!,
                        "Mechanic": state.userAnalysisResponse.numOfMechanists!,
                      },
                      animationDuration: Duration(milliseconds: 800),
                      chartRadius: MediaQuery.of(context).size.width / 2,
                      colorList: colors,
                      chartType: ChartType.disc,
                      ringStrokeWidth: 32,
                      legendOptions: LegendOptions(
                        showLegendsInRow: false,
                        legendPosition: LegendPosition.right,
                        showLegends: true,
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
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(),
                    ),
                  ]),
            );
          } else {
            return Column(
              children: [
                CustomAppBar(
                  haveLogo: true,
                  haveBackArrow: true,
                ),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
