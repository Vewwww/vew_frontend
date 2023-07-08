import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/warning_sign_cubit/warning_sign_cubit.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/views/common/warning_light_screen.dart';
import '../../bloc/warning_sign_cubit/warning_sign_cubit.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';

class SingleWarningSignScreen extends StatefulWidget {
  SingleWarningSignScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  String id;

  @override
  State<SingleWarningSignScreen> createState() =>
      _SingleWarningSignScreenState(id);
}

class _SingleWarningSignScreenState extends State<SingleWarningSignScreen> {
  String id;
  _SingleWarningSignScreenState(this.id);

  @override
  void initState() {
    final warningSignCubit = context.read<WarningSignCubit>();
    warningSignCubit.getSignWithId(id);
  }

  @override
  Widget build(BuildContext context) {
    WarningSignCubit warningSignCubit = WarningSignCubit.get(context);
    //print(sign.name!.en!);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<WarningSignCubit, WarningSignState>(
              builder: (context, state) {
            if (state is GetSingleWarningSignSuccessState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomAppBar(
                    haveLogo: true,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: mainColor,
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WarningLightScreen()),
                            (route) => false);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Image.network(
                      state.sign.image!,
                      height: 150,
                      width: 150,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      state.sign.name!.en!,
                      style: AppTextStyle.mainStyle(size: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Description: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    state.sign.description!.en!,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Solution: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    state.sign.solution!.en!,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  )
                ],
              );
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
        ),
      ),
    );
  }
}
