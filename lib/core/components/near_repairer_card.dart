import 'package:flutter/material.dart';
import 'package:vewww/core/components/rating_bar.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/views/driver/driver_profile.dart';

class NearRepairerCard extends StatelessWidget {
//Repairer repairer;
//NearRepairerCard(this.repairer , {Key? key}) : super(key: key);
  const NearRepairerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //TODO::navigate to repairer profile
        // NavigationUtils.navigateTo(
        //     context: context, destinationScreen: RepairerProfile());
      },
      child: Container(
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
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundColor: mainColor.withOpacity(0.6),
              child: const Icon(
                Icons.car_repair_outlined,
                color: Colors.white,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ahmed Workshop",
                  style: AppTextStyle.mainStyle(size: 20),
                ),
                const SizedBox(height: 5),
                RatingBar(3.5),
                const SizedBox(height: 15),
                Text("Mechanic", style: AppTextStyle.greyStyle(size: 15)),
                const SizedBox(height: 5),
                // Text(repairer.name! , style: AppTextStyle.mainStyle(size: 20),),
                // RatingBar(repairer.rate),
                // Text(repairer.type , style: AppTextStyle.greyStyle(size: 15),),
              ],
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
