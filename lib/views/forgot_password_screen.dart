import 'package:flutter/material.dart';
import 'package:vewww/core/components/backward_arrow.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/components/forgot_pass_car.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/main.dart';
import 'package:vewww/views/create_new_pass_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackwardArrow(function: () {Navigator.pop(context);}),
        title: Center(
          child: Text(
            'Forgot Password',
            style: TextStyle(
              color: Color.fromRGBO(2, 113, 106, 1),
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Image.asset('assets/images/password.png',height: 250,width: 250,),
            SizedBox(height: 15,),
            Text('Select which contact details should we use to reset your password: ',
            style: AppTextStyle.boldStyle(size: 15) ,
            ),
            SizedBox(height: 15,),
            forgotPassCard(title: 'Via SMS', content: '01111517649',icon: Icons.sms,),
            SizedBox(height: 15,),
            forgotPassCard(title: 'Via Email', content: 'zainab@gmail.com',icon: Icons.email,),
            SizedBox(height: 150,),
            defaultButton(text: 'Continue', function: (){
              Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateNewPassScreen()),
                          );
            })
          ],
        ),
      ),
    );
  }
}
