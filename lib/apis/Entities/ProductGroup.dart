import 'package:hive/hive.dart';

import 'SubGroup.dart';

class ProductGroup extends HiveObject{
  final String id;
  final String name;
  final List<String> images;
  final List<SubGroup> subgroup;
  ProductGroup(this.id, this.name, this.images, this.subgroup);

}