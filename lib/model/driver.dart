import 'package:vewww/model/car.dart';

class Driver {
  String? name;
  String? email;
  String? password;
  String? gender;
  String? lisenceRenewalDate;
  String? role;
  String? phoneNumber;
  List<Car>? cars;

  Driver(
      {this.name,
      this.email,
      this.password,
      this.gender,
      this.lisenceRenewalDate,
      this.role,
      this.phoneNumber,
      this.cars});

  Driver.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    gender = json['gender'];
    lisenceRenewalDate = json['lisenceRenewalDate'];
    role = json['role'];
    phoneNumber = json['phoneNumber'];
    if (json['cars'] != null) {
      cars = <Car>[];
      json['cars'].forEach((v) {
        cars!.add(Car.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['gender'] = gender;
    data['lisenceRenewalDate'] = lisenceRenewalDate;
    data['role'] = role;
    data['phoneNumber'] = phoneNumber;
    if (cars != null) {
      data['cars'] = cars!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




Driver driver = Driver(
  email: "hello@email.com",
  gender: "male",
  phoneNumber: "0112111210",
  name: "wael mohamed",
  lisenceRenewalDate: "05/09/2023",
  // cars: [
  //   Car(
  //       carType: "Jeep",
  //       carModel: "M12 2019",
  //       color: Colors.black,
  //       averageMileperWeek: "200",
  //       currentMiles: "603",
  //       remindYouBefore: "week",
  //       licenseRenewalDate: "10/08/2023",
  //       lastPeriodicMaintenanceDate: "09/03/2023"),
  // ],
);
