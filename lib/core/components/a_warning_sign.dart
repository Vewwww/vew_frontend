import 'package:flutter/material.dart';

Widget aWarningSign({
  required String title,
  required String imageURL,
  required Function() function,
}) {
  return GestureDetector(
    onTap: function,
    child: Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(2, 2),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(5, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.network(
            imageURL,
            height: 60,
            width: 60,
          ),
          const SizedBox(
            width: 15,
          ),
          Flexible(
            child: Text(
              title,
              style: const TextStyle(fontSize: 17),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    ),
  );
}
