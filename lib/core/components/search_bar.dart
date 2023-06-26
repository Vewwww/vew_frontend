import 'package:flutter/material.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/views/driver/search_result_screen.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);
  TextEditingController _searchKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        border: Border.all(color: Color.fromRGBO(46, 180, 171, 1)),
        color: Color.fromRGBO(46, 180, 171, 0.16),
      ),
      child: TextField(
        controller: _searchKeyController,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          NavigationUtils.navigateAndClearStack(
              context: context,
              destinationScreen: SearchResultScreen(
                searchKey: _searchKeyController.text,
              ));
        },
        maxLines: 1,
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
          prefixIconColor: Color.fromRGBO(46, 180, 171, 1),
          hintText: (_searchKeyController.text.length > 0)
              ? '_searchKeyController.text'
              : 'Search',
          hintStyle: TextStyle(fontSize: 14),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        ),
      ),
    );
  }
}
