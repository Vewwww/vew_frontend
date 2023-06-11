import 'package:flutter/material.dart';
import '../../core/components/backward_arrow.dart';
import '../../core/components/view_item.dart';
import 'add_maintenance_center_screen.dart';

class ViewMaitenanceCenterScreen extends StatelessWidget {
  const ViewMaitenanceCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackwardArrow(function: () {
          Navigator.pop(context);
        }),
        title: const Center(
          child: Text(
            'Maintenance Center',
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
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => viewItem(
                    name: 'Name of Maintenance Center',
                    address: 'Address of Maintenance Center'),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                itemCount: 20,
              ),
            ),
            Container(
              height: 90,
              width: 90,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(2, 113, 106, 1),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 60,
                ),
                alignment: Alignment.center,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddMaintenanceCenterScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
