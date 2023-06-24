import 'package:vewww/model/person.dart';

class Admin {
  Person? person;
  String? phoneNumber;
  Admin({this.person, this.phoneNumber});
  Admin.fromJson(Map<String, dynamic> json) {
    var name = json['name'];
    var email = json['email'];
    var role = json['role'];
    var token = json['token'];
    var password = json['password'];
    person = Person(
        email: email, password: password, name: name, role: role, token: token);
    phoneNumber = json['phoneNumber'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = person!.name;
    data['email'] = person!.email;
    data['password'] = person!.password;
    data['role'] = person!.role;
    data['token'] = person!.token;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
