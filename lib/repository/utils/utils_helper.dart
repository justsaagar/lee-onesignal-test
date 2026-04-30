import 'package:untitled/app/constant/app_asset.dart';
import 'package:untitled/app/helper/extension_helper.dart';
import 'package:untitled/repository/utils/utils_repository.dart';

class UtilsRepositoryImpl extends UtilsRepository {
  static const Map<String, dynamic> _localUtilsData = {
    'onboarding': {
      'onSliders': [
        {
          'image': AppAsset.appBackground,
          'headerLine': 'Welcome to the app',
          'subHeaderLine': 'Use this template to quickly bootstrap your flow',
          'isShow': true,
        },
        {
          'image': AppAsset.appBackground,
          'headerLine': 'Clean architecture',
          'subHeaderLine': 'GetX + dependency injection + repository pattern',
          'isShow': true,
        },
        {
          'image': AppAsset.appBackground,
          'headerLine': 'Ready for customization',
          'subHeaderLine': 'Replace placeholder content with your own product data',
          'isShow': true,
        },
      ],
    },
  };

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
