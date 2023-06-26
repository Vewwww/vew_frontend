import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/nearest_repairer_cubit/nearest_repairer_cubit.dart';
import 'package:vewww/core/components/filter_card.dart';
import 'package:vewww/views/common/services_screen.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';
import 'package:vewww/views/driver/search_screen.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/near_repairer_card.dart';
import '../../core/components/search_bar.dart';
import '../../core/style/app_colors.dart';
import '../../core/utils/navigation.dart';

class SearchResultScreen extends StatefulWidget {
  SearchResultScreen({this.filter, Key? key, this.serviceId, this.searchKey})
      : super(key: key);
  String? filter;
  String? serviceId;
  String? searchKey;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState(
      filter: filter, serviceId: serviceId, searchKey: searchKey);
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  String? filter;
  String? serviceId;
  String? searchKey;
  _SearchResultScreenState({this.filter, this.serviceId, this.searchKey});

  @override
  void initState() {
    super.initState();
    final nearestRepairerCubit = context.read<NearestRepairerCubit>();
    if (filter == "Maintenance Centers")
      nearestRepairerCubit.getNearestMC();
    else if (filter == "Gas Station")
      nearestRepairerCubit.getNearestGasStation();
    else if (filter == "Mechanist")
      nearestRepairerCubit.getNearestMechanic(serviceId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CustomAppBar(
              title: const Text(""),
              leading: IconButton(
                  onPressed: () {
                    NavigationUtils.navigateTo(
                        context: context,
                        destinationScreen: const DriverHomeScreen());
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: mainColor,
                  )),
            ),
            SearchBar(),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilterCard(
                    onPress: () {},
                    filter: "All",
                    enabled: (filter == null),
                  ),
                  FilterCard(
                      onPress: () {
                        NavigationUtils.navigateTo(
                            context: context,
                            destinationScreen: const ServicesScreen());
                      },
                      filter: "Mechanist",
                      enabled: (filter == "Mechanist")),
                  FilterCard(
                      onPress: () {
                        NavigationUtils.navigateTo(
                            context: context,
                            destinationScreen: SearchResultScreen(
                              filter: "Gas Station",
                              searchKey: searchKey,
                            ));
                      },
                      filter: "Gas Station",
                      enabled: (filter == "Gas Station")),
                  FilterCard(
                      onPress: () {
                        if(searchKey != null)
                        NavigationUtils.navigateTo(
                            context: context,
                            destinationScreen: SearchResultScreen(
                              filter: "Maintenance Centers",
                              searchKey: searchKey,
                            ));
                      },
                      filter: "Maintenance Centers",
                      enabled: (filter == "Maintenance Centers")),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            BlocBuilder<NearestRepairerCubit, NearestRepairerState>(
              builder: (context, state) {
                if (filter == "Maintenance Centers") {
                  if (state is GettingNearestMCSuccessState) {
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: state.maintenanceCenters.length,
                        itemBuilder: (BuildContext context, int index) {
                          return NearRepairerCard(
                              repairer: state.maintenanceCenters[index]);
                        },
                      ),
                    );
                  } else {
                    return buildLoading(context);
                  }
                }
                //TODO::solve and remove comment
                // else if (filter=="Gas Station"){
                //   if (state is GettingNearestGasStationSuccessState) {
                //   return Expanded(
                //     child: ListView.builder(
                //       padding: const EdgeInsets.all(0),
                //       itemCount: state.gasStations.length,
                //       itemBuilder: (BuildContext context, int index) {

                //         return NearRepairerCard(
                //             repairer: state.gasStations[index]);
                //       },
                //     ),
                //   );
                // }else {
                //   return buildLoading(context);
                // }
                // }

                else if (filter == "Mechanist") {
                  if (state is GettingNearestMechanicSuccessState) {
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: state.mechanics.length,
                        itemBuilder: (BuildContext context, int index) {
                          return NearRepairerCard(
                              repairer: state.mechanics[index]);
                        },
                      ),
                    );
                  } else {
                    return buildLoading(context);
                  }
                } else {
                  return buildLoading(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Center buildLoading(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 3),
        const CircularProgressIndicator(),
      ],
    ));
  }
}
