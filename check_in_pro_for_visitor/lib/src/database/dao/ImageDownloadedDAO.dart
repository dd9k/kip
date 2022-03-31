import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/ImageDownloadedEntity.dart';
import 'package:check_in_pro_for_visitor/src/model/ImageDownloaded.dart';
import 'package:moor/moor.dart';

part 'ImageDownloadedDAO.g.dart';

@UseDao(tables: [ImageDownloadedEntity])
class ImageDownloadedDAO extends DatabaseAccessor<Database> with _$ImageDownloadedDAOMixin {
  Database db;

  ImageDownloadedDAO(this.db) : super(db);

  Future<ImageDownloaded> getByLink(String link) async {
    final query = select(imageDownloadedEntity)
      ..where((tbl) => tbl.linkDownload.equals(link));
    List<ImageDownloaded> list = await query.map((row) {
      final model = ImageDownloaded.copyWithEntry(row);
      return model;
    }).get();
    if (list.isEmpty) {
      return null;
    }
    return list.first;
  }

  Future<int> insert(ImageDownloaded imageDownloaded) async {
    final entityCompanion = createCompanion(imageDownloaded);
    return into(imageDownloadedEntity).insert(entityCompanion);
  }

  ImageDownloadedEntityCompanion createCompanion(ImageDownloaded imageDownloaded) {
    ImageDownloadedEntityCompanion companion = ImageDownloadedEntityCompanion(
        linkDownload: Value(imageDownloaded.linkDownload), localPath: Value(imageDownloaded.localPath));
    return companion;
  }
}
