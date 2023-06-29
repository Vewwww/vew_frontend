import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/get_all_cubit/get_all_cubit.dart';
import '../../core/components/add_button.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/name_address_card.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import 'add_gas_station_screen.dart';

class ViewGasStationScreen extends StatefulWidget {
  const ViewGasStationScreen({Key? key}) : super(key: key);

  @override
  State<ViewGasStationScreen> createState() => _ViewGasStationScreenState();
}

class _ViewGasStationScreenState extends State<ViewGasStationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final getAllCubit = context.read<GetAllCubit>();
    getAllCubit.getAllGasStation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: addButton(function: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddGasStationScreen()));
      }),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomAppBar(
              haveBackArrow: true,
              title: Text(
                "Gas Stations",
                style: AppTextStyle.mainStyle(size: 25),
              ),
            ),
            BlocBuilder<GetAllCubit, GetAllState>(
              builder: (context, state) {
                if(state is GetAllGasStationSuccessState){
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => nameAddressCard(
                        title: state.gasStations[index].name!.en!,
                        subtitle: state.gasStations[index].location!.description!.en!,
                        function: () {}),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                    itemCount: state.gasStations.length,
                  ),
                );}
                else{
                  return CircularProgressIndicator();
                }
              },
              
            ),
          ],
        ),
      ),
    );
  }
}
