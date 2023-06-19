import 'package:flutter/material.dart';
import 'package:vewww/core/components/add_button.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';

import '../../core/components/backward_arrow.dart';
import '../../core/components/admin_item.dart';
import 'add_admin.screen.dart';

class ViewAdminsScreen extends StatelessWidget {
  const ViewAdminsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackwardArrow(function: () {
          Navigator.pop(context);
        }),
        title: const Center(
          child: Text(
            'Admins',
            style: TextStyle(
              color: Color.fromRGBO(2, 113, 106, 1),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),*/
      floatingActionButton:addButton(function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddAdminScreen()));
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
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => adminItem(
                      name: 'Mohammed Kamel',
                      email: 'emai_example@gmail.com',
                      icon: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      )),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 15,
                      ),
                  itemCount: 15),
            ),
          ],
        ),
    );
  }
}
