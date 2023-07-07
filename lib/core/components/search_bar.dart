import 'package:flutter/material.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/views/driver/search_result_screen.dart';

class SearchBar extends StatelessWidget {
  SearchBar({String? searchKey, Key? key}) : super(key: key){if(searchKey != null) _searchKeyController.text = searchKey;}
  final TextEditingController _searchKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        border: Border.all(color: const Color.fromRGBO(46, 180, 171, 1)),
        color: const Color.fromRGBO(46, 180, 171, 0.16),
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
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: const Color.fromRGBO(46, 180, 171, 1),
          hintText: (_searchKeyController.text.isNotEmpty)
              ? '_searchKeyController.text'
              : 'Search',
          hintStyle: const TextStyle(fontSize: 14),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        ),
      ),
    );
  }
}
