import 'location.dart';
import 'report.dart';

class MechnaicShopResponse {
  int? results;
  List<MechanicShop>? mechanicShop;

  MechnaicShopResponse({this.results, this.mechanicShop});

  MechnaicShopResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      mechanicShop = <MechanicShop>[];
      json['data'].forEach((v) {
        mechanicShop!.add(MechanicShop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (mechanicShop != null) {
      data['data'] = mechanicShop!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// {
//     "hasDelivery": true,
//     "location": {
//         "description": {
//             "ar": "مجمع الفردوس بجوار نادي السكه خلف ورشة",
//             "en": " Al-Firdous Complex, next to Al-Sekka Club, behind Taqah workshop "
//         },
//         "latitude": 30.0496509,
//         "longitude": 31.27362904
//     },
//     "service": [
//         "64837b8cd4a3c95f4207e9e2",
//         "64837b87d4a3c95f4207e9df"
//     ]
// }
class MechanicShop {
  Report? report;
  Location? location;
  String? sId;
  String? ownerName;
  String? email;
  String? password;
  String? mechanicPhone;
  String? name;
  String? phoneNumber;
  bool? hasDelivery;
  List<String>? service;
  double? rate;
  int? numOfRates;
  bool? isSuspended;
  bool? emailConfirm;
  bool? logedIn;
  String? role;
  int? iV;

  MechanicShop(
      {this.report,
      this.location,
      this.sId,
      this.ownerName,
      this.email,
      this.password,
      this.mechanicPhone,
      this.name,
      this.phoneNumber,
      this.hasDelivery,
      this.service,
      this.rate,
      this.numOfRates,
      this.isSuspended,
      this.emailConfirm,
      this.logedIn,
      this.role,
      this.iV});

  MechanicShop.fromJson(Map<String, dynamic> json) {
    report = json['report'] != null ? Report.fromJson(json['report']) : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    ownerName = json['ownerName'];
    email = json['email'];
    password = json['password'];
    mechanicPhone = json['mechanicPhone'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    hasDelivery = json['hasDelivery'];
    service = json['service'].cast<String>();
    rate = json['rate'] * 1.0;
    numOfRates = json['numOfRates'];
    isSuspended = json['isSuspended'];
    emailConfirm = json['emailConfirm'];
    logedIn = json['logedIn'];
    role = json['role'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (report != null) {
      data['report'] = report!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (sId != null) data['_id'] = sId;
    if (ownerName != null) data['ownerName'] = ownerName;
    if (email != null) data['email'] = email;
    if (password != null) data['password'] = password;
    if (mechanicPhone != null) data['mechanicPhone'] = mechanicPhone;
    if (name != null) data['name'] = name;
    if (phoneNumber != null) data['phoneNumber'] = phoneNumber;
    if (hasDelivery != null) data['hasDelivery'] = hasDelivery;
    if (service != null) data['service'] = service;
    if (rate != null) data['rate'] = rate;
    if (numOfRates != null) data['numOfRates'] = numOfRates;
    if (isSuspended != null) data['isSuspended'] = isSuspended;
    if (emailConfirm != null) data['emailConfirm'] = emailConfirm;
    if (logedIn != null) data['logedIn'] = logedIn;
    if (role != null) data['role'] = role;
    if (iV != null) data['__v'] = iV;
    return data;
  }
}
