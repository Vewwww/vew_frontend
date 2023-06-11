import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/style/app_colors.dart';

import '../../bloc/selected page index/cubit/selected_page_index_cubit.dart';
import '../../views/winch/upcoming_requests_screen.dart';
import '../../views/winch/winch_home_page.dart';


class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Function> actions = [
      () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => WinchHomePage()),
            (route) => false);
      },
      () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpcomingRequestsScreen(),
            ));
      },
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
            Icon(
              Icons.satellite_alt_outlined,
              color: (selectedIndexCubit.selectedIndex == 1)
                  ? Colors.white
                  : Colors.grey,
            ),
          ],
          onTap: (index) {
            selectedIndexCubit.changeIndex(index);
            actions[index]();
          },
        );
      },
    );
  }
}
