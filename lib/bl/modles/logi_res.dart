class LoginRes {
  int success;
  String message;
  String? token;
  UserDetails? userDetails;

  LoginRes({
    required this.success,
    required this.message,
    required this.token,
      this.userDetails,
  });

  factory LoginRes.fromJson(Map<String, dynamic> json) => LoginRes(
    success: json["success"],
    message: json["message"],
    token: json["token"],
    userDetails: json["userDetails"]!=null? UserDetails.fromJson(json["userDetails"]):null,
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "token": token,
    "userDetails": userDetails?.toJson(),
  };
}

class UserDetails {
  String userId;
  String userName;
  String name;
  String userType;
  String? createdDate;
  String? email;
  String? contactNumber;

  UserDetails({
    required this.userId,
    required this.userName,
    required this.name,
    required this.userType,
      this.createdDate,
      this.email,
      this.contactNumber,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    userId: json["UserId"],
    userName: json["UserName"],
    name: json["Name"],
    userType: json["UserType"],
    createdDate: json["CreatedDate"],
    email: json["Email"],
    contactNumber: json["ContactNumber"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "UserName": userName,
    "Name": name,
    "UserType": userType,
    "CreatedDate": createdDate,
    "Email": email,
    "ContactNumber": contactNumber,
  };
}
