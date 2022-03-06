class SKU {
  final int id;
  final String name;
  final double mrp;
  final double ptr;
  final String img;
  final String primaryUnit;
  final String secondaryUnit;
  final int cf;
  final bool isTrending;
  final bool isPromoted;
  final bool isNew;

  SKU(
      this.id,
      this.name,
      this.mrp,
      this.ptr,
      this.img,
      this.primaryUnit,
      this.secondaryUnit,
      this.cf,
      this.isTrending,
      this.isPromoted,
      this.isNew);

  factory SKU.fromJson(int id, Map<String, dynamic> json) {
    return SKU(
      id,
      json["name"],
      double.parse(json["mrp"]),
      double.parse(json["ptr"]),
      json["img"],
      json["primary_unit"],
      json["secondary_unit"],
      json["cf"],
      json["isTrending"].toString() == "1",
      json["isPromoted"].toString() == "1",
      json["isNew"].toString() == "1",
    );
  }
}
