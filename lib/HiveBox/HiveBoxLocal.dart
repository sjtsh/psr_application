import 'package:hive/hive.dart';
import 'package:psr_application/apis/LocalToInsert/OutletClosedEntity.dart';
import 'package:psr_application/apis/LocalToInsert/OutletOrderEntity.dart';
import 'package:psr_application/apis/LocalToInsert/UploadFileEntity.dart';

part 'HiveBoxLocal.g.dart';

@HiveType(typeId: 12)
class HiveBoxLocal extends HiveObject{
  @HiveField(0)
  List<OutletClosedEntity> outletCloseds;
  @HiveField(1)
  List<OutletOrderEntity> outletOrders;
  @HiveField(2)
  List<UploadFileEntity> uploadFiles;
  HiveBoxLocal({required this.outletOrders, required this.outletCloseds, required this.uploadFiles});
}