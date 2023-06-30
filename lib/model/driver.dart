import 'package:vewww/model/car.dart';
import 'package:vewww/model/person.dart';
class DriverResponse {
  int? results;
  List<Driver>? driver;

  DriverResponse({this.results, this.driver});

  DriverResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['Users'] != null) {
      driver = <Driver>[];
      json['Users'].forEach((v) {
        driver!.add(new Driver.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    if (this.driver != null) {
      data['Users'] = this.driver!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Driver {
  Person? person;
  String? lisenceRenewalDate;
  String? phoneNumber;
  List<Car>? cars;

  Driver(
      {
      this.lisenceRenewalDate,
      this.person,
      this.phoneNumber,
      this.cars});

  Driver.fromJson(Map<String, dynamic> json) {
    var name = json['name'];
    var email = json['email'];
    var password = json['password'];
    var role = json['role'];
    var gender=json['gender'];
    print("Before");
    person = Person(name: name, email: email, password: password, role: role,gender: gender );
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
    data['lisenceRenewalDate'] = lisenceRenewalDate;
    data['role'] = person!.role;
    data['phoneNumber'] = phoneNumber;
    data['gender']=person!.gender;
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
  gender: "male",
  ),
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
