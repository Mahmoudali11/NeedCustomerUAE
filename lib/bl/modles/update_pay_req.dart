class UpdateStatusReq {
  String requestId;

  UpdateStatusReq({
    required this.requestId,
  });

  factory UpdateStatusReq.fromJson(Map<String, dynamic> json) => UpdateStatusReq(
    requestId: json["requestId"],
  );

  Map<String, dynamic> toJson() => {
    "requestId": requestId,
  };
}