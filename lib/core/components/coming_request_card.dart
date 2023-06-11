import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_colors.dart';
import '../style/app_text_style/app_text_style.dart';

class ComingRequestCard extends StatelessWidget {
  const ComingRequestCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "احمد كمال",
                  style: AppTextStyle.titleTextStyle(20),
                ),
                SizedBox(
                    height: 30,
                    width: 70,
                    child: Image.asset("assets/images/rating.png")),
                Text(
                  "Jeep : السيارة",
                  style: AppTextStyle.darkGreyStyle(size:13),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        onPressed: () {},
                        child: const Text(
                          "رفض",
                          style: TextStyle(color: Colors.white),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                        ),
                        onPressed: () {},
                        child: const Text(
                          "قبول",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 140,
            height: 140,
            margin: const EdgeInsets.fromLTRB(16, 7, 0, 3),
            decoration: BoxDecoration(
                color: mainColor,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: const Icon(
              Icons.car_repair,
              size: 50,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
