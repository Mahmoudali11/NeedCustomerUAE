import 'package:need/bl/modles/refresh_token_res.dart';

class ServiceCategoryM {
  int success;
  List<Datum> data;
  dynamic message;

  ServiceCategoryM({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ServiceCategoryM.fromJson(Map<String, dynamic> json) => ServiceCategoryM(
    success: json["success"],
    data:json["data"]!=null? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))):<Datum>[],
    message:  json["message"] is bool ?json["message"]:  Message.fromJson(json["message"]),
  );


}

class Datum {
  String serviceName;
  String id;

  Datum({
    required this.serviceName,
    required this.id,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    serviceName: json["ServiceName"],
    id: json["ID"],
  );


}
