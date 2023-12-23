class ResetPassword {
  String username;
  String newPassword;

  ResetPassword({
    required this.username,
    required this.newPassword,
  });

  factory ResetPassword.fromJson(Map<String, dynamic> json) => ResetPassword(
    username: json["Username"],
    newPassword: json["NewPassword"],
  );

  Map<String, dynamic> toJson() => {
    "Username": username,
    "NewPassword": newPassword,
  };
}