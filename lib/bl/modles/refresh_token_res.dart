class RefreshTokenRes {
  int success;
  int status;
  Message message;

  RefreshTokenRes({
    required this.success,
    required this.status,
    required this.message,
  });

  factory RefreshTokenRes.fromJson(Map<String, dynamic> json) => RefreshTokenRes(
    success: json["success"],
    status: json["status"],
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status": status,
    "message": message.toJson(),
  };
}

class Message {
  int success;
  String message;

  Message({
    required this.success,
    required this.message,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
