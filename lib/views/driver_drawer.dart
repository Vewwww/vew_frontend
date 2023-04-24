import 'package:flutter/material.dart';
import 'package:vewww/core/components/circular_icon.dart';
import 'package:vewww/core/components/horizontal_line.dart';

class DriverDrawer extends StatelessWidget {
  const DriverDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            //logo first
            Text('Logo'),
            HorizontalLine(),
            Row(
              children: [
                circularIcon(child:  Icon(Icons.person,size: 30,) ),
                SizedBox(width: 15,),
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            // Row(
            //   children: [
            //     circularIcon(child: Switch(value: value, onChanged: onChanged))
            //   ],
            // ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                circularIcon(child: Icon(Icons.lock)),
                SizedBox(width: 15,),
                Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                circularIcon(child: Icon(Icons.chat)),
                SizedBox(width: 15,),
                Text(
                  'Chat',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                circularIcon(child: Icon(Icons.logout)),
                SizedBox(width: 15,),
                Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  )
              ],
            ),
          ]),
      ),
    );
  }
}