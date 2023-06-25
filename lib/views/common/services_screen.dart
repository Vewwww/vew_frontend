import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/service_cubit/services_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/service_card.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  void initState() {
    super.initState();
    final servicesCubit = context.read<ServicesCubit>();
    servicesCubit.getAllServices();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        CustomAppBar(
          title: Text(
            "Services",
            style: AppTextStyle.mainStyle(size: 25),
          ),
          haveBackArrow: true,
        ),
        BlocBuilder<ServicesCubit, ServicesState>(
          builder: (context, state) {
            if(state is GetAllServicesSuccessState){
            return Expanded(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => serviceCard(
                      function: () {
                        String serviceId = state.services[index].sId!;
                        
                        //  Navigator.pushReplacement(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: ((context) =>
                        //                 SingleWarningSignScreen(id: signId))));
                      },
                      title: state.services[index].name!.en!),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 15,
                      ),
                  itemCount: state.services.length),
            );
            }
            else{
              return CircularProgressIndicator();
            }
          },
        ),
      ]),
    );
  }
}
