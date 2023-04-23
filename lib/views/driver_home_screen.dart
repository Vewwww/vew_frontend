import 'package:flutter/material.dart';
import 'package:vewww/views/driver_drawer.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              icon: Icon(Icons.menu),
              iconSize: 35,
              color: Color.fromRGBO(2, 113, 106, 1),
            );
          },
        ),
      ),
      drawer: DriverDrawer(),

    );
  }
}