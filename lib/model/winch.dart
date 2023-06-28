// class Winch {
//   String? name;
//   String? email;
//   String? password;
//   String? phoneNumber;
//   Location? location;
//   String? plateNumber;

//   Winch(
//       {this.name,
//       this.email,
//       this.password,
//       this.phoneNumber,
//       this.location,
//       this.plateNumber});

//   Winch.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     email = json['email'];
//     password = json['password'];
//     phoneNumber = json['phoneNumber'];
//     location = json['location'] != null
//         ? new Location.fromJson(json['location'])
//         : null;
//     plateNumber = json['plateNumber'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['phoneNumber'] = this.phoneNumber;
//     if (this.location != null) {
//       data['location'] = this.location!.toJson();
//     }
//     data['plateNumber'] = this.plateNumber;
//     //TODO::remome car
//     data['car'] = {
//       "carType": "643528431c01869f2d835be5",
//       "plateNumber": "123456",
//       "color": "6469f59993253d535309dc62"
//     };

//     return data;
//   }
// }

// class Location {
//   double? latitude;
//   double? longitude;

//   Location({this.latitude, this.longitude});

//   Location.fromJson(Map<String, dynamic> json) {
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     return data;
//   }
// }
