class LoginReq {
  String username;
  String password;

  LoginReq({
    required this.username,
    required this.password,
  });

 

  Map<String, dynamic> toJson() => {
    "Username": username,
    "Password": password,
  };
}
