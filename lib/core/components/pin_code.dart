import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget PINCode({required Function(String) function}) {
  return SizedBox(
    height: 68,
    width: 64,
    child: TextFormField(
      onSaved: (vaule) {
        print(vaule);
      },
      onChanged: function,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(width: 3, color: Color.fromRGBO(2, 113, 106, 1))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.grey)),
      ),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
    ),
  );
}
