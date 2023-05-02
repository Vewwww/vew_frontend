import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/components/pin_code.dart';

class PhonePINVerification extends StatelessWidget {
  const PhonePINVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            height: 200,
            width: 200,
            image: AssetImage(
              'assets/images/phone_verification.jpg',
            ),
          ),
          Text(
            'Enter the Verification Code',
            style: TextStyle(
              fontSize: 23,
              color: Color.fromRGBO(2, 113, 106, 1),
            ),
          ),
          Text('Enter the 4-digit number that we send to ',style: TextStyle(color: Colors.grey),),
          Text('01111517649',style: TextStyle(color: Colors.grey),),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(17),
              ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PINCode(function: (value){
                  if(value.length==1){
                        FocusScope.of(context).nextFocus();
                  }
                }),
                 PINCode(function: (value){
                  if(value.length==1){
                        FocusScope.of(context).nextFocus();
                  }
                }),
                 PINCode(function: (value){
                  if(value.length==1){
                        FocusScope.of(context).nextFocus();
                  }
                }),
                 PINCode(function: (value){
                  if(value.length==1){
                        FocusScope.of(context).nextFocus();
                  }
                }),

              ],
            ),
          ),
          Container(
              alignment: Alignment.bottomRight,
              child: defaultButton(text: 'Next', width: 130, height: 50)
              ),
        ],
      ),
    );
  }
}
