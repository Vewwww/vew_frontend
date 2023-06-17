
class Admin {
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  Admin({this.name, this.email, this.password, this.phoneNumber});
    Admin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNumber=json['phoneNumber'];
   
  }
 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    return data;
  }

}
