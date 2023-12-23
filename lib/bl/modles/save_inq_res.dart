class SaveInqRes {
  int success;
  int status;
  String? message;
  String? ref;

  SaveInqRes({
    required this.success,
    required this.status,
      this.message,
    this.ref
  });

  factory SaveInqRes.fromJson(Map<String, dynamic> json) => SaveInqRes(
    success: json["success"],
    status: json["status"],
    message: json["message"],
    ref: json["ref"],
  );


}