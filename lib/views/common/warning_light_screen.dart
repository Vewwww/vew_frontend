import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/components/a_warning_sign.dart';
import 'package:vewww/core/components/backward_arrow.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/views/admin/add_warning_sign_screen.dart';
import 'package:vewww/views/common/single_warning_sign_screen.dart';

import '../../bloc/warning_sign_cubit/warning_sign_cubit.dart';
import '../../core/components/add_button.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';

class WarningLightScreen extends StatefulWidget {
  const WarningLightScreen({Key? key}) : super(key: key);

  @override
  State<WarningLightScreen> createState() => _WarningLightScreenState();
}

class _WarningLightScreenState extends State<WarningLightScreen> {
  void initState() {
    super.initState();
    print("inside init");
    // TODO: implement initState
    final warningSignCubit = context.read<WarningSignCubit>();
    warningSignCubit.getAllSigns();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      floatingActionButton: addButton(function: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddWarningSignScreen()));
      }),
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
