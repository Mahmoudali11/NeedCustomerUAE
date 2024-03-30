class DeleteAccountRes {
  int success;
  dynamic data;
  dynamic message;

  DeleteAccountRes({
    required this.success,
      this.data,
      this.message,
  });

  factory DeleteAccountRes.fromJson(Map<String, dynamic> json) => DeleteAccountRes(
    success: json["success"],
    data:json["data"] ,
    message:  json["message"] ,
  );


}