
import 'package:hive/hive.dart';

part 'UploadFileEntity.g.dart';

@HiveType(typeId: 10)
class UploadFileEntity extends HiveObject{
  @HiveField(0)
  String filePath;
  @HiveField(1)
  String name;
  @HiveField(2)
  String userID;
  UploadFileEntity(this.filePath, this.name, this.userID);

}