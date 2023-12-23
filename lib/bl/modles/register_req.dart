class RegisterReq {
  String username;
  String password;
  String name;
  int userType;
  String email;

  RegisterReq({
    required this.username,
    required this.password,
    required this.name,
    required this.userType,
    required this.email,
  });

  factory RegisterReq.fromJson(Map<String, dynamic> json) => RegisterReq(
    username: json["Username"],
    password: json["Password"],
    name: json["Name"],
    userType: json["UserType"],
    email: json["Email"],
  );

  Map<String, dynamic> toJson() => {
    "Username": username,
    "Password": password,
    "Name": name,
    "UserType": userType,
    "Email": email,
  };
}