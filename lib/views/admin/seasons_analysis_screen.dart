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
    const Color.fromRGBO(2, 113, 106, 1),
    const Color.fromRGBO(15, 150, 156, 1),
    const Color.fromARGB(255, 2, 87, 87),
    const Color.fromARGB(255, 5, 97, 97),
  ];

  void initState() {
    super.initState();
    final adminAnalysisCubit = context.read<AdminAnalysisCubit>();
    adminAnalysisCubit.getSeasonAnalysis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(children: [
        CustomAppBar(
          haveLogo: true,
          haveBackArrow: true,
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          'This pie chart show the four seasons of years and number of car problems happened in each season.',
          style: AppTextStyle.greyStyle(size: 20),
        ),
        const SizedBox(
          height: 60,
        ),
        BlocConsumer<AdminAnalysisCubit, AdminAnalysisState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetSeasonAnalysisSuccessState) {
              return PieChart(
                dataMap: {
                  "Summer": state.seasonAnalysisResponse.season!.summer!,
                  "Winter": state.seasonAnalysisResponse.season!.winter!,
                  "Autumn": state.seasonAnalysisResponse.season!.autumn!,
                  "Spring": state.seasonAnalysisResponse.season!.spring!,
                },
                animationDuration: const Duration(milliseconds: 800),
                chartRadius: MediaQuery.of(context).size.width / 2,
                colorList: colors,
                chartType: ChartType.disc,
                ringStrokeWidth: 32,
                legendOptions: const LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: true,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                  decimalPlaces: 1,
                ),
              );
            } else {
              return Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                      child: Container()),
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                      child: Container()),
                ],
              );
            }
          },
        )
      ]),
    ));
  }
}
