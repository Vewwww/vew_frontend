import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vewww/bloc/warning_sign_cubit/warning_sign_cubit.dart';

import '../../core/components/a_warning_sign.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../common/single_warning_sign_screen.dart';

class DriverWarningSign extends StatelessWidget {
  const DriverWarningSign({super.key});
  @override
  Widget build(BuildContext context) {
    WarningSignCubit warningSignCubit =WarningSignCubit.get(context);
   return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomAppBar(
            title: Text(
              'Warning Signs',
              style: AppTextStyle.mainStyle(size: 25),
            ),
            haveBackArrow: true,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => aWarningSign(
                    title: warningSignCubit.signResponse!.name!.en![index],
                    imageURL:
                        warningSignCubit.signResponse!.image![index],
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  SingleWarningSignScreen())));
                    }),
                itemCount: warningSignCubit.signResponse!.sId!.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}