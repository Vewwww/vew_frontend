import 'package:flutter/material.dart';

import '../../core/components/backward_arrow.dart';
import '../../core/components/user_item.dart';



class ViewAppUsersScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override

  

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackwardArrow(function: (){ Navigator.pop(context);}),
        title: const Center(
          child: Text(
            'Application \' s Users',
            style: TextStyle(
              color: Color.fromRGBO(2, 113, 106, 1),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
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
            const SizedBox(height: 15),
            const Text(
              'Driver:',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(2, 113, 106, 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
              child: Container(
                height: 2.0,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (contrxt, indx) => userItem(
                  name: 'Zainab Mamoud',
                  email: 'zainab@gmail.com',
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                itemCount: 10,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Winch Driver:',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(2, 113, 106, 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
              child: Container(
                height: 2.0,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (contrxt, indx) => userItem(
                  name: 'Hatem Hatem',
                  email: 'hatem@gmail.com',
                  icon: const Icon(
                    Icons.car_repair,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                itemCount: 10,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Mechanists:',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(2, 113, 106, 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
              child: Container(
                height: 2.0,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (contrxt, indx) => userItem(
                  name: 'Omar Ahmed',
                  email: 'omar@gmail.com',
                  icon: const Icon(
                    Icons.hail,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
