import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/diagnose_cunit/diagnose_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/views/mechanic/single_Problem_screen.dart';

class SelectProblemScreen extends StatefulWidget {
  const SelectProblemScreen({Key? key}) : super(key: key);

  @override
  State<SelectProblemScreen> createState() => _SelectProblemScreenState();
}

class _SelectProblemScreenState extends State<SelectProblemScreen> {
  @override
  void initState() {
    super.initState();
    var diagnoseCubilt = context.read<DiagnoseCubit>();

    diagnoseCubilt.getUnsolvedQuestion();
  }

  @override
  Widget build(BuildContext context) {
    DiagnoseCubit diagnoseCubit = DiagnoseCubit.get(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAppBar(
                haveLogo: true,
                haveBackArrow: true,
              ),
              SizedBox(height: 10),
              Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
              BlocBuilder<DiagnoseCubit, DiagnoseState>(
                  builder: (context, state) {
                if (state is GetUnsolvedSuccessState) {
                  print(diagnoseCubit.problemResponse!.data);
                  return ListView.builder(
                      shrinkWrap: true,
                      //primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: diagnoseCubit.problemResponse!.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            NavigationUtils.navigateTo(
                                context: context,
                                destinationScreen: SingleProblemScreen(
                                    problemData: diagnoseCubit
                                        .problemResponse!.data![index]));
                          },
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(2, 2),
                                ),
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(5, 0),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "المشكلة",
                                  textDirection: TextDirection.rtl,
                                  style: AppTextStyle.mainStyle(),
                                ),
                                Flexible(
                                    child: Text(
                                  diagnoseCubit.problemResponse!.data![index]
                                          .problem ??
                                      " ",
                                  style: AppTextStyle.greyStyle(),
                                  overflow: TextOverflow.ellipsis,
                                )),
                                RichText(
                                  textDirection: TextDirection.rtl,
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "الحالة:  ",
                                          style: AppTextStyle.darkGreyStyle()),
                                      TextSpan(
                                          text: "غير محلول",
                                          style: AppTextStyle.mainStyle()),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return Center(
                      child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 3),
                      CircularProgressIndicator(),
                    ],
                  ));
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
