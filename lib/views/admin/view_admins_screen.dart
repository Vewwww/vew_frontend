import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/components/add_button.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';

import '../../bloc/get_all_cubit/get_all_cubit.dart';
import '../../core/components/backward_arrow.dart';
import '../../core/components/admin_item.dart';
import 'add_admin.screen.dart';

class ViewAdminsScreen extends StatefulWidget {
  const ViewAdminsScreen({Key? key}) : super(key: key);

  @override
  State<ViewAdminsScreen> createState() => _ViewAdminsScreenState();
}

class _ViewAdminsScreenState extends State<ViewAdminsScreen> {
  void initState() {
    super.initState();
    final getAllCubit = context.read<GetAllCubit>();
    getAllCubit.getAllAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: addButton(function: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddAdminScreen()));
      }),
      body: Column(
        children: [
          CustomAppBar(
            haveBackArrow: true,
            title: Text(
              "Admin",
              style: AppTextStyle.mainStyle(size: 25),
            ),
          ),
          BlocBuilder<GetAllCubit, GetAllState>(
            builder: (context, state) {

              if (state is GetAllAdminsSuccessState) {
                print(state);
                return Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) => adminItem(
                          name: state.admins[index].person!.name!,
                          email: state.admins[index].person!.email!,
                          icon: const Icon(
                            Icons.admin_panel_settings,
                            color: Colors.white,
                            size: 30,
                          )),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                      itemCount: state.admins.length),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
