class SaveEnquiryReq {
  String name;
  String mobile;
  String service;
  String city;
  String address;
  String details;

  SaveEnquiryReq({
    required this.name,
    required this.mobile,
    required this.service,
    required this.city,
    required this.address,
    required this.details,
  });

  factory SaveEnquiryReq.fromJson(Map<String, dynamic> json) => SaveEnquiryReq(
    name: json["name"],
    mobile: json["mobile"],
    service: json["service"],
    city: json["city"],
    address: json["address"],
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile": mobile,
    "service": service,
    "city": city,
    "address": address,
    "details": details,
  };
}
