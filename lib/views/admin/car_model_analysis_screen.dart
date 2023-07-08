import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../bloc/admin_analysis_cubit/admin_analysis_cubit.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';

class CarModelAnalysisScreen extends StatefulWidget {
  const CarModelAnalysisScreen({super.key});

  @override
  State<CarModelAnalysisScreen> createState() => _CarModelAnalysisScreenState();
}

class _CarModelAnalysisScreenState extends State<CarModelAnalysisScreen> {
  void initState() {
    super.initState();
    final adminAnalysisCubit = context.read<AdminAnalysisCubit>();
    adminAnalysisCubit.getCarModelAnalysis();
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
          'This list shows the Most car models having problems according to Application users problems :',
          style: AppTextStyle.greyStyle(size: 20),
        ),
        const SizedBox(
          height: 60,
        ),
        BlocConsumer<AdminAnalysisCubit, AdminAnalysisState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetCarModelAnalysisSuccessState) {
              return Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.carModelAnalysisResponse.length,
                      itemBuilder: (context, index) {
                        return RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "${index + 1} - ",
                                  style: AppTextStyle.greyStyle()),
                              TextSpan(
                                  text:
                                      "${state.carModelAnalysisResponse[index].brand} , ${state.carModelAnalysisResponse[index].model}",
                                  style: AppTextStyle.mainStyle()),
                            ],
                          ),
                        );
                      }));
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
