import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/views/driver/diagnose_screen.dart';
import '../../bloc/diagnose_cubit/diagnose_cubit.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';

class ChoosePrblemCategoryScreen extends StatelessWidget {
  const ChoosePrblemCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var constraintsHight = MediaQuery.of(context).size.height;
    DiagnoseCubit diagnoseCubit = DiagnoseCubit.get(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 5,
              ),
              CustomAppBar(
                haveBackArrow: true,
              ),
              SizedBox(height: constraintsHight / 10 - 50),
              Center(child: Image.asset("assets/images/Logo(1).png")),
              SizedBox(height: constraintsHight / 60),

              //const SizedBox(height: 10),
              const Divider(
                thickness: 0,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              Center(
                  child: Text(
                "Which category best describes your car problem?",
                textAlign: TextAlign.center,
                style: AppTextStyle.mainStyle(size: 20),
              )),
              BlocBuilder<DiagnoseCubit, DiagnoseState>(
                  builder: (context, state) {
                if (state is GetCategoriesSuccessState) {
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: diagnoseCubit.catigories.length,
                      itemBuilder: (context, index) {
                        return card(
                            diagnoseCubit.catigories[index],
                            Icons.severe_cold,
                            DiagnoseScreen(
                                category: diagnoseCubit.catigories[index]),
                            context,
                            isArabic: false);
                      });
                } else {
                  return Center(
                      child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 3),
                      const CircularProgressIndicator(),
                    ],
                  ));
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget card(String data, IconData icon, Widget screen, context,
      {isArabic = true}) {
    List<Widget> rowElements = [
      Text(
        data,
        style: AppTextStyle.mainStyle(),
        textDirection: (isArabic) ? TextDirection.rtl : TextDirection.ltr,
      ),
      const SizedBox(width: 20),
      Icon(
        icon,
        color: mainColor,
      ),
    ];
    return GestureDetector(
      onTap: () {
        NavigationUtils.navigateTo(context: context, destinationScreen: screen);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
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
        child: Row(
            mainAxisAlignment:
                (isArabic) ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: (isArabic)
                ? rowElements
                : rowElements.reversed.map((e) => e).toList()),
      ),
    );
  }
}
