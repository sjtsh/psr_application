import 'package:hive/hive.dart';
import 'package:psr_application/apis/Entities/SKU.dart';


part 'SubGroup.g.dart';

@HiveType(typeId: 7)
class SubGroup extends HiveObject{
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String productName;
  @HiveField(2)
  final List<SKU> skus;
  SubGroup(this.name, this.productName, this.skus);
}