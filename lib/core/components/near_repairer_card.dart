import 'package:flutter/material.dart';
import 'package:vewww/core/components/rating_bar.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/sp_helper/cache_helper.dart';
import 'package:vewww/model/car_type.dart';
import 'package:vewww/views/driver/gas_stattion_preview.dart';
import 'package:vewww/views/driver/which_car_screen.dart';
import '../../model/repairer.dart';
import '../../views/driver/maintenance_center_preview.dart';
import '../utils/navigation.dart';

class NearRepairerCard extends StatelessWidget {
  NearRepairerCard({required this.repairer, Key? key}) : super(key: key);
  Repairer repairer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (repairer is MaintenanceCenter) {
          NavigationUtils.navigateTo(
              context: context,
              destinationScreen: MaintenanceCenterPreview(
                maintenanceCenter: repairer as MaintenanceCenter,
              ));
        } else if (repairer is GasStation) {
          NavigationUtils.navigateTo(
              context: context,
              destinationScreen: GasStationPreview(
                gasStation: repairer as GasStation,
              ));
        } else if (repairer is Mechanic) {
          String id = SharedPreferencesHelper.getData(key: 'vewId');
          NavigationUtils.navigateTo(
              context: context,
              destinationScreen: WhichCarScreen(
                  id: id, isWinch: false, repairer: repairer as Mechanic));
        }
        if (repairer is Place) {
          Place r = repairer as Place;
          print(r.toJson());
          if (r.carType != null && r.isVerified != null) {
            print("is Mc");
            MaintenanceCenter maintenanceCenter =
                MaintenanceCenter.fromJson(r.toJson());
            NavigationUtils.navigateTo(
                context: context,
                destinationScreen: MaintenanceCenterPreview(
                  maintenanceCenter: maintenanceCenter,
                ));
          } else if (r.service != null || r.hasDelivery != null) {
            print("is Mechanic");
            String id = SharedPreferencesHelper.getData(key: 'vewId');
            print(r.toJson());
            Mechanic mechanic = Mechanic.fromJson(r.toJson());
            print("mech :${mechanic.toJson()}");
            NavigationUtils.navigateTo(
                context: context,
                destinationScreen: WhichCarScreen(
                    id: id, isWinch: false, repairer: mechanic as Mechanic));
          } else {
            print("is gas station\n${r.toJson()}");
            print(
                "is gas station\n${SharedPreferencesHelper.getData(key: 'vewToken')}");
            GasStation gasStation = GasStation.fromJson(r.toJson());
            NavigationUtils.navigateTo(
                context: context,
                destinationScreen: GasStationPreview(
                  gasStation: gasStation as GasStation,
                ));
          }
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
            )
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
                (repairer.rate != null)
                    ? AppRatingBar(repairer.rate!)
                    : Container(),
                const SizedBox(height: 15),
                (repairer.distance != null)
                    ? Text("${repairer.distance} Km away",
                        style: AppTextStyle.greyStyle(size: 15))
                    : Container(),
                (repairer.distance != null)
                    ? const SizedBox(height: 5)
                    : Container(),
                Text(
                    (repairer is MaintenanceCenter)
                        ? "Maintenance Center"
                        : (repairer is GasStation)
                            ? "Gas Station"
                            : (repairer is Mechanic)
                                ? "Mechanic"
                                : "Repairer",
                    style: AppTextStyle.greyStyle(size: 15)),
                const SizedBox(height: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Text(
                      (repairer is GasStation &&
                              repairer.location != null &&
                              repairer.location!.description != null)
                          ? repairer.location!.description!.en ?? ''
                          : "",
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.greyStyle(size: 15)),
                ),
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
