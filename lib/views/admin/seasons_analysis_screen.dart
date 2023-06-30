import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../bloc/admin_analysis_cubit/admin_analysis_cubit.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';

class SeasonAnalysisScreen extends StatefulWidget {
  const SeasonAnalysisScreen({super.key});

  @override
  State<SeasonAnalysisScreen> createState() => _SeasonAnalysisScreenState();
}

class _SeasonAnalysisScreenState extends State<SeasonAnalysisScreen> {
  List<Color> colors = [
    Color.fromRGBO(2, 113, 106, 1),
    Color.fromRGBO(15, 150, 156, 1),
    Color.fromARGB(255, 2, 87, 87),
    Color.fromARGB(255, 5, 97, 97),
  ];

   void initState() {
    super.initState();
    final adminAnalysisCubit = context.read<AdminAnalysisCubit>();
    adminAnalysisCubit.getSeasonAnalysis();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: BlocBuilder<AdminAnalysisCubit, AdminAnalysisState>(
        builder: (context, state) {  
          if (state is GetSeasonAnalysisSuccessState) {
            return Column(children: [
              CustomAppBar(
                haveLogo: true,
                haveBackArrow: true,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'This pie chart show the four seasons of years and number of car problems happened in each season.',
                style: AppTextStyle.boldStyle(size: 20),
              ),
              SizedBox(
                height: 10,
              ),
              PieChart(
                dataMap: {
                  // "Summer": state.seasonAnalysisResponse.season!.summer!,
                  // "Winter": state.seasonAnalysisResponse.season!.winter!,
                  // "Autumn":state.seasonAnalysisResponse.season!.autumn ,
                  // "Spring":state.seasonAnalysisResponse.season!.spring!,
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
            return Column(children: [
                CustomAppBar(
                haveLogo: true,
                haveBackArrow: true,
              ),
              Center(child: CircularProgressIndicator(),),
            ],);
            
          }
        },
      ),
    );
  }
}