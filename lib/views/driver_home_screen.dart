import 'package:flutter/material.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/views/driver_drawer.dart';
import 'package:vewww/views/warning_light_screen.dart';

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
        actions: [
          IconButton(onPressed: (){}, 
          icon: Icon(
            Icons.search,
            color: Color.fromRGBO(2, 113, 106, 1),
            size: 30,
          )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            defaultButton(/*function: function,*/ text: 'Do Not Know Car Problem', width: 330, height: 75),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Request ',
                  style: TextStyle(
                    color:Colors.grey,
                    fontSize: 20,
                    fontWeight:FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                defaultButton(text: 'Mechanic',height: 75, width:150 ),
                defaultButton(text: 'Winch',height: 75, width:150),
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Find Nearest',
                  style: TextStyle(
                    color:Colors.grey,
                    fontSize: 20,
                    fontWeight:FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                defaultButton(text: 'Maintenance Center',height: 75, width:150),
                defaultButton(text: 'Gas Station',height: 75, width:150)
              ],
            ),
            SizedBox(height: 30,),
            defaultButton(text: 'Warning Light',
             height: 75, 
             width: 330,
             function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => WarningLightScreen())));
                    },
             ),
              
          ],
        ),
      ),
      drawer: DriverDrawer(),
      

    );
  }
}