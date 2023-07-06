import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/nearest_repairer_cubit/nearest_repairer_cubit.dart';
import 'package:vewww/bloc/select_choice_cubit/select_choice_cubit.dart';
import 'package:vewww/core/components/filter_card.dart';
import 'package:vewww/views/common/services_screen.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';
import 'package:vewww/views/driver/search_screen.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/near_repairer_card.dart';
import '../../core/components/search_bar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/style/app_colors.dart';
import '../../core/utils/navigation.dart';

class SearchResultScreen extends StatefulWidget {
  SearchResultScreen(
      {this.filter = "All", Key? key, this.serviceId, this.searchKey})
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
  _SearchResultScreenState(
      {this.filter = "All", this.serviceId, this.searchKey});

  @override
  void initState() {
    super.initState();
    print("saearch : $searchKey ,  $filter");
    final nearestRepairerCubit = context.read<NearestRepairerCubit>();
    final cubit = context.read<SelectChoiceCubit>();
    if (filter == "Maintenance Centers") {
      {
        print("here getNearestMC");
        if (cubit.carTypeResponse != null &&
            cubit.carTypeResponse!.carType != null)
          nearestRepairerCubit.getNearestMC(
              carTypeID:
                  cubit.carTypeResponse!.carType![cubit.carTypeChoice].sId);
        else
          nearestRepairerCubit.getNearestMC();
      }
    } else if (filter == "Gas Station") {
      nearestRepairerCubit.getNearestGasStation();
    } else if (filter == "Mechanist") {
      nearestRepairerCubit.getNearestMechanic(serviceId!);
    } else if (searchKey != null && searchKey!.length <= 0 && filter == "All") {
      print("in search4  *${searchKey}**");
      nearestRepairerCubit.getNearest();
    } else if (searchKey != null && filter == "All") {
      print("in search1  *${searchKey}*");
      nearestRepairerCubit.search(searchKey!);
    } else if (searchKey == null && filter == "All") {
      print("in search1  *${searchKey}**");
      nearestRepairerCubit.getNearest();
    } else if (searchKey != null && filter == null) {
      print("in search3  *${searchKey}**");
      nearestRepairerCubit.search(searchKey!);
    }
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
                    onPress: () {
                      NavigationUtils.navigateTo(
                          context: context,
                          destinationScreen: SearchResultScreen(
                            filter: "All",
                          ));
                    },
                    filter: "All",
                    enabled: (filter == "All"),
                  ),
                  FilterCard(
                      onPress: () {
                        NavigationUtils.navigateTo(
                            context: context,
                            destinationScreen: ServicesScreen());
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
                } else if (filter == "Gas Station") {
                  if (state is GettingNearestGasStationSuccessState) {
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: state.gasStations.length,
                        itemBuilder: (BuildContext context, int index) {
                          return NearRepairerCard(
                              repairer: state.gasStations[index]);
                        },
                      ),
                    );
                  } else {
                    return buildLoading(context);
                  }
                } else if (filter == "Mechanist") {
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
                } else if (filter == "All" &&
                    searchKey != null &&
                    searchKey!.length > 0) {
                  if (state is SearchSuccessState) {
                    if (state.places.length > 0) {
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(0),
                          itemCount: state.places.length,
                          itemBuilder: (BuildContext context, int index) {
                            return NearRepairerCard(
                                repairer: state.places[index]);
                          },
                        ),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/Empty.png",
                                width: 50,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "No Repairers were found",
                                textDirection: TextDirection.rtl,
                                style: AppTextStyle.lightGrayTextStyle(25),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  } else {
                    return buildLoading(context);
                  }
                } else if ((filter == null || filter == "All") &&
                    searchKey != null &&
                    searchKey!.length == 0) {
                  if (state is GettingNearestSuccessState) {
                    if (state.places.length > 0) {
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(0),
                          itemCount: state.places.length,
                          itemBuilder: (BuildContext context, int index) {
                            return NearRepairerCard(
                                repairer: state.places[index]);
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/Empty.png",
                                width: 200,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "No Repairers were found",
                                textDirection: TextDirection.rtl,
                                style: AppTextStyle.lightGrayTextStyle(25),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  } else {
                    return buildLoading(context);
                  }
                } else if (searchKey == null && filter == "All") {
                  if (state is GettingNearestSuccessState) {
                    if (state.places.length > 0) {
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(0),
                          itemCount: state.places.length,
                          itemBuilder: (BuildContext context, int index) {
                            return NearRepairerCard(
                                repairer: state.places[index]);
                          },
                        ),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/Empty.png",
                                width: 50,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "No Repairers were found",
                                textDirection: TextDirection.rtl,
                                style: AppTextStyle.lightGrayTextStyle(25),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
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
