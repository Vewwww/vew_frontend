import 'package:vewww/model/car.dart';
import 'package:vewww/model/person.dart';

class Driver {
  Person? person;
  String? gender;
  String? lisenceRenewalDate;
  String? phoneNumber;
  List<Car>? cars;

  Driver(
      {this.gender,
      this.lisenceRenewalDate,
      this.person,
      this.phoneNumber,
      this.cars});

  Driver.fromJson(Map<String, dynamic> json) {
    var name = json['name'];
    var email = json['email'];
    var password = json['password'];
    var role = json['role'];
    person = Person(name: name, email: email, password: password, role: role);
    gender = json['gender'];
    lisenceRenewalDate = json['lisenceRenewalDate'];
    phoneNumber = json['phoneNumber'];
    if (json['cars'] != null) {
      cars = <Car>[];
      json['cars'].forEach((v) {
        cars!.add(Car.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = person!.name;
    data['email'] = person!.email;
    data['password'] = person!.password;
    data['gender'] = gender;
    data['lisenceRenewalDate'] = lisenceRenewalDate;
    data['role'] = person!.role;
    data['phoneNumber'] = phoneNumber;
    if (cars != null) {
      data['cars'] = cars!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

Driver driver = Driver(
  person: Person(
    email: "hello@email.com",
  name: "wael mohamed",
  ),
  gender: "male",
  phoneNumber: "0112111210",
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
