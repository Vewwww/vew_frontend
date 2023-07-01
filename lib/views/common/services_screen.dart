import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/nearest_repairer_cubit/nearest_repairer_cubit.dart';
import 'package:vewww/bloc/service_cubit/services_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/service_card.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/views/mechanic/mechanic_edit_profile_screen.dart';
import 'package:vewww/views/mechanic/mechanic_signup.dart';

import '../../core/utils/navigation.dart';
import '../../model/mechanic_shop.dart';
import '../../model/services.dart';
import '../driver/search_result_screen.dart';

class ServicesScreen extends StatefulWidget {
  bool multiSelect;
  MechanicShop? mechanicShop;
  ServicesScreen({this.multiSelect = false, this.mechanicShop, super.key}) {
    if (mechanicShop != null) print(mechanicShop!.toJson());
  }

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  //List<Service> services = [];
  @override
  void initState() {
    super.initState();
    final servicesCubit = context.read<ServicesCubit>();
    servicesCubit.getAllServices();
    print("selected services from init : ${servicesCubit.selectedServices}");
    servicesCubit.selectedServices =
        (widget.mechanicShop != null) ? widget.mechanicShop!.service ?? [] : [];
  }

  @override
  Widget build(BuildContext context) {
    ServicesCubit servicesCubit = ServicesCubit.get(context);

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
            if (state is GetAllServicesSuccessState ||
                state is ServiceAddedState) {
              return Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String title = servicesCubit.services![index].name!.en ??
                        servicesCubit.services![index].name!.ar!;
                    bool isSelected = false;
                    for (Service s in servicesCubit.selectedServices) {
                      if (s.sId == servicesCubit.services![index].sId) {
                        isSelected = true;
                        print(
                            "1-${s.toJson()} ,\n2- ${servicesCubit.services![index].toJson()}");
                      }
                    }
                    return serviceCard(
                        isSelected: isSelected,
                        function: () async {
                          servicesCubit
                              .addService(servicesCubit.services![index]);
                          print(
                              "now selected services is :${servicesCubit.selectedServices.length}");

                          String serviceId =
                              servicesCubit.services![index].sId!;
                          if (!widget.multiSelect) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => SearchResultScreen(
                                        filter: "Mechanist",
                                        serviceId: serviceId))));
                          }
                        },
                        title: title);
                  },
                  itemCount: servicesCubit.services!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? 2
                          : 3),
                ),
              );
            } else if (state is GetAllServicesLoadingState) {
              return CircularProgressIndicator();
            } else {
              return Container();
            }
          },
        ),
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                NavigationUtils.navigateTo(
                    context: context,
                    destinationScreen: (widget.mechanicShop != null &&
                            widget.mechanicShop!.sId != null)
                        ? MechanicEditProfile(widget.mechanicShop!)
                        : MechanicSignup(
                            mechanicShop: widget.mechanicShop,
                            services:
                                ServicesCubit.get(context).selectedServices));
              },
              child: const Text("تم"),
            ))
      ]),
    );
  }
}
