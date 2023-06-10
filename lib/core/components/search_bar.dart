import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

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
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {},
        maxLines: 1,
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
          prefixIconColor: Color.fromRGBO(46, 180, 171, 1),
          hintText: 'Search',
          hintStyle: TextStyle(fontSize: 14),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        ),
      ),
    );
  }
}
