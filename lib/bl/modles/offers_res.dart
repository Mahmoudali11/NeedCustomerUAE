class OffersRes {
  int success;
  List<Offers> data;
  dynamic message;

  OffersRes({
    required this.success,
    required this.data,
    required this.message,
  });

  factory OffersRes.fromJson(Map<String, dynamic> json) => OffersRes(
    success: json["success"],
    data: List<Offers>.from( json["data"]?.map((x) => Offers.fromJson(x))??[]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class Offers {
  String name;
  String offerId;
  String description;
  String image;

  Offers({
    required this.name,
    required this.offerId,
    required this.description,
    required this.image,
  });

  factory Offers.fromJson(Map<String, dynamic> json) => Offers(
    name: json["Name"],
    offerId: json["OfferId"],
    description: json["Description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "OfferId": offerId,
    "Description": description,
    "image": image,
  };
}