import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/app/constant/string_constant.dart';
import 'package:untitled/app/helper/extension_helper.dart';
import 'package:untitled/repository/utils/utils_repository.dart';

class UtilsRepositoryImpl extends UtilsRepository {
  final CollectionReference _utilsCollection =
      FirebaseFirestore.instance.collection(AppCollectionConstants.utils);

  @override
  Future<Map<String, dynamic>?> getUtilsData(String collectionName) async {
    try {
      final DocumentSnapshot snapshot =
          await _utilsCollection.doc(collectionName).get();
      if (snapshot.exists && snapshot.data() != null) {
        return snapshot.data()! as Map<String, dynamic>;
      }
    } on FirebaseException catch (e) {
      'Catch FirebaseException in getUtilsData --> ${e.message}'.errorLogs();
      e.message?.showError();
    }
    return null;
  }
}
