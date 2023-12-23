class RegisterRes {
  int success;
  int status;
  String message;

  RegisterRes({
    required this.success,
    required this.status,
    required this.message,
  });

  factory RegisterRes.fromJson(Map<String, dynamic> json) => RegisterRes(
    success: json["success"],
    status: json["status"],
    message: json["message"],
  );


}