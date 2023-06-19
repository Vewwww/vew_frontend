import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget adminItem({
  required String name,
  required String email,
  required Icon icon,
}) =>
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10),
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
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(2, 113, 106, 1),
            ),
            child: icon,
            alignment: Alignment.center,
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                email,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
