import 'package:flutter/material.dart';
import 'package:vewww/core/components/default_button.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(
          Icons.keyboard_arrow_left,
          color: Color.fromRGBO(2, 113, 106, 1),
        ),
        title: Stack(
          children: [
            Image(
              image: AssetImage(
                'assets/images/Logo.png',
              ),
              width: 150,
            ),
            Text(
              'Vewww',
            style: TextStyle(
              color: Color.fromRGBO(2, 113, 106, 1),
              fontFamily: 'Shrikhand',
            ),
            ),
            
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Email Verification',
            style: TextStyle(
              fontSize: 25,
              color: Color.fromRGBO(2, 113, 106, 1),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Send an email to ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              Text('example@gmail.com',
                  style: TextStyle(
                    fontSize: 20,
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              defaultButton(text: 'Edit Email', height: 50, width: 150),
              defaultButton(text: 'Next', height: 50, width: 150),
            ],
          ),
        ],
      ),
    );
  }
}
