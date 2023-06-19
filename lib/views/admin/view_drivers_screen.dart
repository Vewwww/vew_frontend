import 'package:flutter/material.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/user_item.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';

class ViewDriversScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        CustomAppBar(haveBackArrow: true, title: Text('Application\' s Drivers', style: AppTextStyle.mainStyle(size: 25),),),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
                controller: searchController,
                decoration: const InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
              ),
        ),
         Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.separated(
                  itemBuilder: (contrxt, indx) => userItem(title: 'Zainab Ghanem', subtitle: 'Zainabmagh17@gmail.com', function: (){}),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
                  itemCount: 10,
                ),
              ),
            ),
      ]),
    );
  }
}