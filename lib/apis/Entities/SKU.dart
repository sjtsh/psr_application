class SKU {
  int id;
  String name;
  String subGroup;
  String productGroup;
  double mrp;
  double ptr;
  String img;
  String primaryUnit;
  String secondaryUnit;
  int cf;
  bool deactivated;

  SKU(
      this.id,
      this.name,
      this.subGroup,
      this.productGroup,
      this.mrp,
      this.ptr,
      this.img,
      this.primaryUnit,
      this.secondaryUnit,
      this.cf,
      this.deactivated);
}
