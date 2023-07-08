import 'package:flutter/material.dart';
import 'package:vewww/core/components/default_button.dart';

class EmailVerifiedScreen extends StatelessWidget {
  const EmailVerifiedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              height: 200,
              width: 200,
              image: AssetImage(
                'assets/images/done.png',
              ),
            ),
            const Text(
              'Email Sent Successfully',
              style: TextStyle(
                fontSize: 23,
                color: Color.fromRGBO(2, 113, 106, 1),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:const [
                Text(
                  'An email sent to ',
                  style: TextStyle(color: Colors.grey),
                ),
                Text('example@gmail.com'),
              ],
            ),
            const Text(
              'Please check your inbox to verify the mail',
              style: TextStyle(color: Colors.grey),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: defaultButton(text: 'Next', width: 130, height: 50)
              ),
          ],
        ),
      ),
    );
  }
}
