import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/nearest_repairer_cubit/nearest_repairer_cubit.dart';
import 'package:vewww/core/components/near_repairer_card.dart';
import 'package:vewww/core/components/search_bar.dart';
import 'package:vewww/views/driver/search_result_screen.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/style/app_colors.dart';
import '../../core/utils/navigation.dart';
import 'driver_home_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    var nearestCubit = context.read<NearestRepairerCubit>();
    nearestCubit.getNearest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Near Repairers", style: AppTextStyle.greyStyle()),
                InkWell(
                    onTap: () {
                      NavigationUtils.navigateTo(
                          context: context,
                          destinationScreen: SearchResultScreen());
                    },
                    child: Text("See All", style: AppTextStyle.mainStyle())),
              ],
            ),
            const Divider(
              thickness: 1,
            ),
            BlocBuilder<NearestRepairerCubit, NearestRepairerState>(
              builder: (context, state) {
                if (state is GettingNearestSuccessState) {
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return NearRepairerCard(repairer: state.places[index]);
                      },
                    ),
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
