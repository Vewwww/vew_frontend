import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/nearest_repairer_cubit/nearest_repairer_cubit.dart';
import 'package:vewww/bloc/service_cubit/services_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/service_card.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';

import '../driver/search_result_screen.dart';

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
            style: AppTextStyle.darkGreyStyle(size: 25),
          ),
          haveBackArrow: true,
        ),
        BlocBuilder<ServicesCubit, ServicesState>(
          builder: (context, state) {
            if (state is GetAllServicesSuccessState) {
              return Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String title = state.services[index].name!.en ??
                        state.services[index].name!.ar!;
                    return serviceCard(
                        function: () async {
                          String serviceId = state.services[index].sId!;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => SearchResultScreen(
                                      filter: "Mechanist",
                                      serviceId: serviceId))));
                        },
                        title: title);
                  },
                  // separatorBuilder: (context, index) => const SizedBox(
                  //       height: 15,
                  //     ),
                  itemCount: state.services.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? 2
                          : 3),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ]),
    );
  }
}
