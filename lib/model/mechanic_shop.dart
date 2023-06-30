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
        mechanicShop!.add(new MechanicShop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    if (this.mechanicShop != null) {
      data['data'] = this.mechanicShop!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

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
    report =
        json['report'] != null ? new Report.fromJson(json['report']) : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    ownerName = json['ownerName'];
    email = json['email'];
    password = json['password'];
    mechanicPhone = json['mechanicPhone'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    hasDelivery = json['hasDelivery'];
    service = json['service'].cast<String>();
    rate = json['rate']*1.0;
    numOfRates = json['numOfRates'];
    isSuspended = json['isSuspended'];
    emailConfirm = json['emailConfirm'];
    logedIn = json['logedIn'];
    role = json['role'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.report != null) {
      data['report'] = this.report!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['ownerName'] = this.ownerName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['mechanicPhone'] = this.mechanicPhone;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['hasDelivery'] = this.hasDelivery;
    data['service'] = this.service;
    data['rate'] = this.rate;
    data['numOfRates'] = this.numOfRates;
    data['isSuspended'] = this.isSuspended;
    data['emailConfirm'] = this.emailConfirm;
    data['logedIn'] = this.logedIn;
    data['role'] = this.role;
    data['__v'] = this.iV;
    return data;
  }
}

