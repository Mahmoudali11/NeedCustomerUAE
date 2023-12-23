class RefreshTokenReq {
  String username;

  RefreshTokenReq({
    required this.username,
  });

  factory RefreshTokenReq.fromJson(Map<String, dynamic> json) => RefreshTokenReq(
    username: json["Username"],
  );

  Map<String, dynamic> toJson() => {
    "Username": username,
  };
}