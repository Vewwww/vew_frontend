import 'package:flutter/material.dart';
import 'package:vewww/core/components/a_warning_sign.dart';
import 'package:vewww/core/components/backward_arrow.dart';
import 'package:vewww/views/common/single_warning_sign_screen.dart';

class WarningLightScreen extends StatelessWidget {
  const WarningLightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackwardArrow(function: () {
          Navigator.pop(context);
        }),
        title: Center(
          child: Text(
            'Warning Signs',
            style: TextStyle(
              color: Color.fromRGBO(2, 113, 106, 1),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => aWarningSign(
                title: 'Check Engine',
                imageURL:
                    'https://hips.hearstapps.com/hmg-prod/images/check-engine-light-icon-1616189100.jpg',
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => SingleWarningSignScreen())));
                }),
            itemCount: 15,
            separatorBuilder: (context, index) => SizedBox(
              height: 15,
            ),
          ),
        ),
      ),
    );
  }
}
