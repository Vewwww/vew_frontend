import 'package:flutter/material.dart';

import 'car.dart';

class Driver {
  String? name;
  String? phone;
  String? email;
  String? password;
  String? token;
  String? gender;
  String? licenseRenewalDate;
  List<Car>? cars;

  Driver(
      {this.email,
      this.cars,
      this.name,
      this.gender,
      this.password,
      this.phone,
      this.licenseRenewalDate = "00/00/0000",
      this.token});
}

Driver driver = Driver(
  email: "hello@email.com",
  gender: "male",
  phone: "0112111210",
  name: "wael mohamed",
  licenseRenewalDate: "05/09/2023",
  cars: [
    Car(
        carType: "Jeep",
        carModel: "M12 2019",
        color: Colors.black,
        averageMileperWeek: "200",
        currentMiles: "603",
        remindYouBefore: "week",
        licenseRenewalDate: "10/08/2023",
        lastPeriodicMaintenanceDate: "09/03/2023"),
  ],
);
