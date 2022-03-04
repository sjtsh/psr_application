import 'package:psr_application/apis/Entities/SKU.dart';

class SubGroup{
  final String name;
  final String productName;
  final List<SKU> skus;
  SubGroup(this.name, this.productName, this.skus);
}