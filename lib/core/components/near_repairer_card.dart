import 'package:flutter/material.dart';
import 'package:vewww/core/components/rating_bar.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/views/admin/view_gas_stations_screen.dart';
import 'package:vewww/views/driver/gas_stattion_preview.dart';
import '../../model/repairer.dart';
import '../../views/driver/maintenance_center_preview.dart';
import '../utils/navigation.dart';

class NearRepairerCard extends StatelessWidget {
  NearRepairerCard({required this.repairer, Key? key}) : super(key: key) {
    print(repairer.name!.ar);
  }
  Repairer repairer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //TODO::navigate to repairer profile
        if (repairer is MaintenanceCenter)
          NavigationUtils.navigateTo(
              context: context,
              destinationScreen: MaintenanceCenterPreview(
                maintenanceCenter: repairer as MaintenanceCenter,
              ));
        else if (repairer is GasStation){
           NavigationUtils.navigateTo(
              context: context,
              destinationScreen: ViewGasStationScreen(
                //gasStation: repairer as GasStation,
              )
                );

        }
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
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Text(
                    repairer.name!.en!,
                    style: AppTextStyle.mainStyle(size: 20),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
                const SizedBox(height: 5),
                RatingBar(repairer.rate!),
                const SizedBox(height: 15),
                Text(
                    (repairer is MaintenanceCenter)
                        ? "Maintenance Center"
                        : "Repairer",
                    style: AppTextStyle.greyStyle(size: 15)),
                const SizedBox(height: 5),
              ],
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
