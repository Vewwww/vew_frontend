import 'accepted_requests_response.dart';

class UpcomingRequestsResponse {
  bool? newRequests;
  List<MechanicRequestsData>? data;

  UpcomingRequestsResponse({this.newRequests, this.data});

  UpcomingRequestsResponse.fromJson(Map<String, dynamic> json) {
    newRequests = json['newRequests'];
    print("obj 1");
    if (json['data'] != null) {
      data = <MechanicRequestsData>[];
      json['data'].forEach((v) {
        data!.add(new MechanicRequestsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newRequests'] = this.newRequests;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
