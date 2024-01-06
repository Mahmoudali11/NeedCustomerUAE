class SaveEnquiryReq {
  String name;
  String mobile;
  String service;
  String city;
  String address;
  String details;
  String userId;

  SaveEnquiryReq({
    required this.name,
    required this.mobile,
    required this.service,
    required this.city,
    required this.address,
    required this.details,
    required this.userId
  });



  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile": mobile,
    "service": service,
    "city": city,
    "address": address,
    "details": details,
    "userId":userId
  };
}
