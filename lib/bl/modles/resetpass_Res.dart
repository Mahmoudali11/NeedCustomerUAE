class ResetPasswordRes {
  int success;
  String? message;

  ResetPasswordRes({
    required this.success,
      this.message,
  });

  factory ResetPasswordRes.fromJson(Map<String, dynamic> json) => ResetPasswordRes(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}