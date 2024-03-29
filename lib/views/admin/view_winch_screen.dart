import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/components/user_item.dart';
import 'package:vewww/views/admin/other_users_screen.dart';
import '../../bloc/get_all_cubit/get_all_cubit.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';

class ViewWinchScreen extends StatefulWidget {
  @override
  State<ViewWinchScreen> createState() => _ViewWinchScreenState();
}

class _ViewWinchScreenState extends State<ViewWinchScreen> {
  var searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final getAllCubit = context.read<GetAllCubit>();
    getAllCubit.getAllWinchDrivers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        CustomAppBar(
          haveBackArrow: true,
          title: Text(
            'Application\' s Winch',
            style: AppTextStyle.mainStyle(size: 25),
          ),
        ),
        BlocBuilder<GetAllCubit, GetAllState>(
          builder: (context, state){
            if(state is GetAllWinchDriversSuccessState){
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.separated(
                  itemBuilder: (contrxt, index) => userItem(
                      icon:Icons.car_repair,
                      title: state.winchDriver[index].name!,
                      subtitle: state.winchDriver[index].email!,
                      function: (){
                        String winchId = state.winchDriver[index].sId!;
                        String role = state.winchDriver[index].role!;
                        Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        OtherUsersScreen(id: winchId,role:role))));
                      },
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
                  itemCount: state.winchDriver.length,
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
