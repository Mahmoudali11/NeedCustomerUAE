class SaveEnquiryReq {
String name;
String mobile;
String city;
String service;
String address;
String details;
String userId;

SaveEnquiryReq({
  required this.name,
  required this.mobile,
  required this.city,
  required this.service,
  required this.address,
  required this.details,
  required this.userId,
});

factory SaveEnquiryReq.fromJson(Map<String, dynamic> json) => SaveEnquiryReq(
name: json["name"],
mobile: json["mobile"],
city: json["city"],
service: json["service"],
address: json["address"],
details: json["details"],
userId: json["userId"],
);

Map<String, dynamic> toJson() => {
"name": name,
"mobile": mobile,
"city": city,
"service": service,
"address": address,
"details": details,
"userId": userId,
};
}
