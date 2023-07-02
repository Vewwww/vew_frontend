import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/nearest_repairer_cubit/nearest_repairer_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/views/driver/requests_screen.dart';

import '../../core/components/nearest_winch_card.dart';

class NearestWinchScreen extends StatefulWidget {
  const NearestWinchScreen({super.key});

  @override
  State<NearestWinchScreen> createState() => _NearestWinchScreenState();
}

class _NearestWinchScreenState extends State<NearestWinchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     final nearestRepairerCubit = context.read<NearestRepairerCubit>();
     nearestRepairerCubit.getNearestWinch();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        CustomAppBar(
          haveBackArrow: true,
          haveLogo: true,
        ),
        BlocBuilder<NearestRepairerCubit, NearestRepairerState>(
          builder: (context, state) {
            if(state is GettingNearestWinchSuccessState){
            return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: state.nearestWinch.length,
                    itemBuilder: (context, index) => nearestWinchCard(
                        name: state.nearestWinch[index].name!,
                        plateNumber: state.nearestWinch[index].plateNumber!,
                        rate: state.nearestWinch[index].rate!,
                        distance: state.nearestWinch[index].distance!,
                        function: (){
                             Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        RequestScreen())));
                        }),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                  ),
                );
            }else{
              return CircularProgressIndicator();
            }
          },
        ),
      ]),
    );
  }
}
