import 'package:flutter/material.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/views/admin/admin_profile.dart';

import '../../model/admin.dart';

Admin admin=Admin(name: 'Ali', email: 'ali@gmail.com', password: 'ali123', phoneNumber: '01111548');

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const Image(
            image: AssetImage('assets/images/Logo(1).png'),
            height: 100,
            width: 100,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: Container(
              height: 2.0,
              width: 330.0,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                      Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  AdminProfile(admin: admin,)));
                    },
                  child: Container( 
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(2, 113, 106, 1),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                    alignment: Alignment.center,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'Profile',
                  style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(2, 113, 106, 1),
                  ),
                  child: const Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 30,
                  ),
                  alignment: Alignment.center,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
