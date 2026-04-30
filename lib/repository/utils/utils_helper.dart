import 'package:untitled/app/helper/extension_helper.dart';
import 'package:untitled/repository/utils/utils_repository.dart';

class UtilsRepositoryImpl extends UtilsRepository {
  static const Map<String, dynamic> _localUtilsData = {};

  @override
  Future<Map<String, dynamic>?> getUtilsData(String collectionName) async {
    final dynamic result = _localUtilsData[collectionName];
    if (result is Map<String, dynamic>) {
      return result;
    }
    'No local utils data found for: $collectionName'.warningLogs();
    return null;
  }
}
