import 'package:moor/moor.dart';

@DataClassName('ImageDownloadedEntry')
class ImageDownloadedEntity extends Table {
  String get tableName => 'cip_image_downloaded';

  TextColumn get linkDownload => text().nullable()();

  TextColumn get localPath => text().nullable()();
}
