class ResetPasswordEmailReq {
  String email;
  String newPassword;

  ResetPasswordEmailReq({
    required this.email,
    required this.newPassword,
  });

  factory ResetPasswordEmailReq.fromJson(Map<String, dynamic> json) => ResetPasswordEmailReq(
    email: json["Email"],
    newPassword: json["NewPassword"],
  );

  Map<String, dynamic> toJson() => {
    "Email": email,
    "NewPassword": newPassword,
  };
}