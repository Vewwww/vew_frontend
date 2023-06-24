import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/warning_sign_cubit/warning_sign_cubit.dart';

import '../../core/components/a_warning_sign.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../model/warning_sign.dart';
import '../common/single_warning_sign_screen.dart';

class DriverWarningSign extends StatefulWidget {
  const DriverWarningSign({super.key});

  @override
  State<DriverWarningSign> createState() => _DriverWarningSignState();
}

class _DriverWarningSignState extends State<DriverWarningSign> {
  @override
  void initState() {
    super.initState();
    print("inside init");
    // TODO: implement initState
    final warningSignCubit = context.read<WarningSignCubit>();
    warningSignCubit.getAllSigns();
  }
  @override
  Widget build(BuildContext context) {
    //WarningSignCubit warningSignCubit = WarningSignCubit.get(context);
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
            child: BlocBuilder<WarningSignCubit, WarningSignState>(
              builder: (context, state) {
                print(state);
                if (state is GetAllWarningSignSuccessState) {
                  
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => aWarningSign(
                          title:state.signs[index].name!.en!,
                          imageURL: state.signs[index].image!,
                          function: (){
                          //warningSignCubit.getSignWithId(warningSignCubit.signResponse!.signs![index].sId!);
                           //Signs sign = warningSignCubit.sign!;
                           String signId = state.signs[index].sId!;
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context)=>
                                        SingleWarningSignScreen(id:signId,))));
                           
                          }),
                      itemCount: state.signs.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 15,
                      ),
                    ),
                  );
                } else {
                  return
                  SizedBox(height:50,child: CircularProgressIndicator());
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
