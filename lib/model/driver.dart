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
        driver!.add(Driver.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (driver != null) {
      data['Users'] = driver!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Driver {
  Person? person;
  String? lisenceRenewalDate;
  String? phoneNumber;
  List<Car>? cars;

  Driver({this.lisenceRenewalDate, this.person, this.phoneNumber, this.cars});

  Driver.fromJson(Map<String, dynamic> json) {
    var name = json['name'];
    var email = json['email'];
    var password = json['password'];
    var role = json['role'];
    var gender = json['gender'];
    person = Person(
        name: name,
        email: email,
        password: password,
        role: role,
        gender: gender);
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cars != null) data['name'] = person!.name;
    if (person!.email != null) data['email'] = person!.email;
    if (person!.password != null) data['password'] = person!.password;
    if (lisenceRenewalDate != null) {
      data['lisenceRenewalDate'] = lisenceRenewalDate;
    }
    if (person!.role != null) data['role'] = person!.role;
    if (cars != null) data['phoneNumber'] = phoneNumber;
    if (phoneNumber != null) data['gender'] = person!.gender;
    if (person!.gender != null) {
      data['cars'] = cars!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toSignupJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = person!.name;
    data['email'] = person!.email;
    data['password'] = person!.password;
    data['lisenceRenewalDate'] = lisenceRenewalDate;
    data['role'] = person!.role;
    data['phoneNumber'] = phoneNumber;
    data['gender'] = person!.gender;
    if (cars != null) data['car'] = cars![0].toSignupJson();

    return data;
  }
}
