import 'package:flutter/material.dart';

import '../../core/components/default_button.dart';


class PhoneVerificationScreen extends StatelessWidget {
  const PhoneVerificationScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Phone Verification',
          style: TextStyle(color: Color.fromRGBO(2, 113, 106, 1),fontSize: 23,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Send Message to ', style: TextStyle(color: Colors.grey),),
              Text('01111517649' )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              defaultButton(text: 'Edit Phone', height: 50, width: 150),
              defaultButton(text: 'Next', height: 50, width: 150),
            ],
          ),
        ],
      ),
    );
  }
}