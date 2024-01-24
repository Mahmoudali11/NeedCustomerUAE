class SaveEnquiryReq {
String name;
String mobile;
String city;
String service;
String address;
String details;
String userId;
String email;

SaveEnquiryReq({
  required this.name,
  required this.mobile,
  required this.city,
  required this.service,
  required this.address,
  required this.details,
  required this.userId,
  required this.email
});



Map<String, dynamic> toJson() => {
"name": name,
"mobile": mobile,
"city": city,
"service": service,
"address": address,
"details": details,
"userId": userId,
"email": email,
};
}
