class UpdateStatusRes {
  int success;
 dynamic data;
  dynamic message;

  UpdateStatusRes({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UpdateStatusRes.fromJson(Map<String, dynamic> json) => UpdateStatusRes(
    success: json["success"],
    data:  json["data"],
    message: json["message"],
  );


}