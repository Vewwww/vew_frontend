import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/user_item.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/views/admin/a_driver_screen.dart';


import '../../bloc/get_all_cubit/get_all_cubit.dart';

class ViewDriversScreen extends StatefulWidget {
  @override
  State<ViewDriversScreen> createState() => _ViewDriversScreenState();
}

class _ViewDriversScreenState extends State<ViewDriversScreen> {
  var searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final getAllCubit = context.read<GetAllCubit>();
    getAllCubit.getAllDrivers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        CustomAppBar(
          haveBackArrow: true,
          title: Text(
            'Application\' s Drivers',
            style: AppTextStyle.mainStyle(size: 25),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 15),
        //   child: TextFormField(
        //     controller: searchController,
        //     decoration: const InputDecoration(
        //       labelText: 'Search',
        //       prefixIcon: Icon(
        //         Icons.search,
        //       ),
        //       border: OutlineInputBorder(
        //           borderRadius: BorderRadius.all(Radius.circular(30))),
        //     ),
        //   ),
        // ),
        BlocBuilder<GetAllCubit, GetAllState>(
          builder: (context, state) {
            if(state is GetAllDriversSuccessState){
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.separated(
                  itemBuilder: (contrxt, index) => userItem(
                      icon: Icons.person,
                      title: state.drivers[index].person!.name!,
                      subtitle: state.drivers[index].person!.email!,
                      function: (){
                        String driverId= state.drivers[index].person!.sId!;
                        String role = state.drivers[index].person!.role!;
                        Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        ADriverScreen(id: driverId,role:role))));
                      }
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
                  itemCount: state.drivers.length,
                ),
              ),
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
