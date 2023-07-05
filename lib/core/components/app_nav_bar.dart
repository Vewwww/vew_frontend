import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/style/app_colors.dart';

import '../../bloc/new_request_cubit/new_request_cubit.dart';
import '../../bloc/selected page index/cubit/selected_page_index_cubit.dart';
import '../../views/winch/winch_upcoming_requests_screen.dart';
import '../../views/winch/winch_home_page.dart';

class AppNavigationBar extends StatelessWidget {
  AppNavigationBar(
      {required this.homeFunction, required this.upComingReqFunction, Key? key})
      : super(key: key);
  Function homeFunction;
  Function upComingReqFunction;
  @override
  Widget build(BuildContext context) {
    List<Function> actions = [
      homeFunction,
      upComingReqFunction,
    ];
    SelectedPageIndexCubit selectedIndexCubit =
        SelectedPageIndexCubit.get(context);
    return BlocConsumer<SelectedPageIndexCubit, SelectedPageIndexState>(
      listener: (context, state) {},
      builder: (context, state) {
        return CurvedNavigationBar(
          index: selectedIndexCubit.selectedIndex!,
          height: 60,
          backgroundColor: Color.fromARGB(0, 209, 209, 209),
          buttonBackgroundColor: mainColor,
          color: Color.fromARGB(255, 243, 242, 242),
          items: [
            Icon(
              Icons.home_filled,
              color: (selectedIndexCubit.selectedIndex == 0)
                  ? Colors.white
                  : Colors.grey,
            ),
            BlocBuilder<NewRequestCubit, NewRequestState>(
              builder: (context, state) {
                if (state is HasNewState)
                  return Stack(
                    children: [
                      Icon(
                        Icons.satellite_alt_outlined,
                        color: (selectedIndexCubit.selectedIndex == 1)
                            ? Colors.white
                            : Colors.grey,
                      ),
                      CircleAvatar(
                        radius: 3,
                        backgroundColor: Colors.red,
                      )
                    ],
                  );
                else
                  return Icon(
                    Icons.satellite_alt_outlined,
                    color: (selectedIndexCubit.selectedIndex == 1)
                        ? Colors.white
                        : Colors.grey,
                  );
              },
            ),
          ],
          onTap: (index) {
            print(index);
            selectedIndexCubit.changeIndex(index);
            actions[index]();
          },
        );
      },
    );
  }
}
