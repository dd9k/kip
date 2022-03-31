import 'dart:convert';

import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/Configuration.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:moor/moor.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/ConfigurationEntity.dart';
import 'package:check_in_pro_for_visitor/src/database/Database.dart';

part 'ConfigurationDAO.g.dart';

@UseDao(tables: [ConfigurationEntity])
class ConfigurationDAO extends DatabaseAccessor<Database> with _$ConfigurationDAOMixin {
  final Database db;

  ConfigurationDAO(this.db) : super(db);

  Future<List<Configuration>> getAllConfigurations() {
    final query = select(configurationEntity);

    return query.map((row) {
      var lstValue = List<String>();
      if (row.value == null) {
        lstValue = null;
      } else {
        if (row.code == Constants.CONFIGURATION_IMAGES) {
          var length = int.tryParse(row.value) ?? 0;
          var i = 0;
          while (i < length) {
            lstValue.add(row.value);
            i++;
          }
        } else if (row.code == Constants.CONFIGURATION_BACKGROUND_COLOR) {
          Map<String, dynamic> map = jsonDecode(row.value);
          lstValue.addAll(List<String>.from(map['data']));
        } else {
          lstValue.add(row.value);
        }
      }
      final config = Configuration(0, row.code, lstValue);

      return config;
    }).get();
  }

  Future<void> deleteAll() async {
    await delete(configurationEntity).go();
  }

  Future<int> insert(Configuration dataEntry) async {
    String value;
    // Check value null and has data
    if (dataEntry.value != null && dataEntry.value.isNotEmpty && dataEntry.value[0].isNotEmpty) {
      if (dataEntry.code == Constants.CONFIGURATION_IMAGES) {
        value = dataEntry.value.length.toString();
      } else if (dataEntry.code == Constants.CONFIGURATION_BACKGROUND_COLOR) {
        Map<String, List<String>> map = {'data': dataEntry.value};
        value = jsonEncode(map);
      } else {
        value = dataEntry.value[0];
      }
    }
    String userName;
    var userInfor = await Utilities().getUserInfor();
    if (userInfor != null) {
      userName = userInfor.userName;
    }
    final entityCompanion = ConfigurationEntityCompanion(
      code: Value(dataEntry.code),
      value: Value(value),
      createdBy: Value(userName),
      createdDate: Value(DateTime.now().toUtc()),
      updatedBy: Value(userName),
      updatedDate: Value(DateTime.now().toUtc()),
    );

    return into(configurationEntity).insert(entityCompanion);
  }
}
