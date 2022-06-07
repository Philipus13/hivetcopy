import 'package:hive/hive.dart';

part 'album_model.g.dart';

@HiveType(typeId: 1)
class AlbumHiveModel extends HiveObject {
  @HiveField(0)
  int albumId;
  @HiveField(1)
  int id;
  @HiveField(2)
  String title;
  @HiveField(3)
  String url;
  @HiveField(4)
  String thumbnailUrl;

  AlbumHiveModel(
      this.albumId, this.id, this.title, this.url, this.thumbnailUrl);
}
