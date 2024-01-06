class ResetPasswordEmailRes {
  int success;
  int status;
  String message;

  ResetPasswordEmailRes({
    required this.success,
    required this.status,
    required this.message,
  });

  factory ResetPasswordEmailRes.fromJson(Map<String, dynamic> json) =>
      ResetPasswordEmailRes(
        success: json["success"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
      };
}
