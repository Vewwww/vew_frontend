import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/verification_cubit/verification_cubit.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/components/pin_code.dart';

class PhonePINVerification extends StatelessWidget {
  const PhonePINVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VerificationCubit verificationCubit = VerificationCubit();
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
          Text(
            'Enter the 4-digit number that we send to ',
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            '01111517649',
            style: TextStyle(color: Colors.grey),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(17),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PINCode(function: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                    verificationCubit.append(value, 0);
                  }
                }),
                PINCode(function: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                    verificationCubit.append(value, 1);
                  }
                }),
                PINCode(function: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                    verificationCubit.append(value, 2);
                  }
                }),
                PINCode(function: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                    verificationCubit.append(value, 3);
                  }
                }),
              ],
            ),
          ),
          Container(
              alignment: Alignment.bottomRight,
              child: BlocConsumer<VerificationCubit, VerificationState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return defaultButton(
                      text: 'Next',
                      width: 130,
                      height: 50,
                      background: (verificationCubit.countDigits>=4)
                          ? const Color.fromRGBO(2, 113, 106, 1)
                          : Colors.grey.shade200);
                },
              )),
        ],
      ),
    );
  }
}
