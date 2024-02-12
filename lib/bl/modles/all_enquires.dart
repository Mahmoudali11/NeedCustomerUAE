
class AllUserEnquiries {
  int success;
  List<Data>? data;
  dynamic message;

  AllUserEnquiries({
    required this.success,
      this.data,
    required this.message,
  });

  factory AllUserEnquiries.fromJson(Map<String, dynamic> json) => AllUserEnquiries(
    success: json["success"],
    data:json["data"]!=null? List<Data>.from(json["data"].map((x) => Data.fromJson(x))):null,
    message: json["message"],
  );


}

class Data {
  String id;
  String contactName;
  String category;
  String address;
  String cellphnumber;
  dynamic email;
  String notes;
  DateTime creationDate;
  String status;
  String source;
  String refno;
  String city;
  String userId;
  String requestStatus;

  Data({
    required this.id,
    required this.contactName,
    required this.category,
    required this.address,
    required this.cellphnumber,
    required this.email,
    required this.notes,
    required this.creationDate,
    required this.status,
    required this.source,
    required this.refno,
    required this.city,
    required this.userId,
    required this.requestStatus
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["ID"],
    contactName: json["ContactName"],
    category: json["Category"],
    address: json["Address"],
    cellphnumber: json["Cellphnumber"],
    email: json["Email"],
    notes: json["Notes"],
    creationDate: DateTime.tryParse(json["CreationDate"])??DateTime.now(),
    status: json["status"],
    source: json["source"],
    refno: json["refno"],
    city: json["city"],
    userId: json["userId"],
    requestStatus:json["RequestStatus"]
  );


}