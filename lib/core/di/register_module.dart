import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/models/photo_item_db.dart';

@module
abstract class RegisterModule {
  @preResolve
  @lazySingleton
  Future<Isar> get isar async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open([PhotoItemDbSchema], directory: dir.path);
    return isar;
  }
}
