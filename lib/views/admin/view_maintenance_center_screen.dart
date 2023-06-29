import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/name_address_card.dart';
import '../../bloc/get_all_cubit/get_all_cubit.dart';
import '../../core/components/add_button.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import 'add_maintenance_center_screen.dart';

class ViewMaitenanceCenterScreen extends StatefulWidget {
  const ViewMaitenanceCenterScreen({Key? key}) : super(key: key);

  @override
  State<ViewMaitenanceCenterScreen> createState() =>
      _ViewMaitenanceCenterScreenState();
}

class _ViewMaitenanceCenterScreenState
    extends State<ViewMaitenanceCenterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final getAllCubit = context.read<GetAllCubit>();
    getAllCubit.getAllMaintenanceCenter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: addButton(function: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddMaintenanceCenterScreen()));
      }),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomAppBar(
              haveBackArrow: true,
              title: Text(
                "Maintenance Center",
                style: AppTextStyle.mainStyle(size: 25),
              ),
            ),
            BlocBuilder<GetAllCubit, GetAllState>(
              builder: (context, state) {
                if(state is GetAllMCSuccessState){
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => nameAddressCard(
                        title: state.maintenanceCenters[index].name!.en!,
                        subtitle: state.maintenanceCenters[index].location!.description!.en!,
                        function: () {}),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                    itemCount: state.maintenanceCenters.length,
                  ),
                );
                }else {
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
