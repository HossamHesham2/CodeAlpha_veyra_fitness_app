import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:veyra/core/constants/app_constants.dart';
import 'package:veyra/core/exceptions/remote_exceptions.dart';
import 'package:veyra/features/activity_details/data/datasources/remote/activity_details_remote_datasource.dart';

class ActivityDetailsRemoteDatasourceImpl extends ActivityDetailsRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  ActivityDetailsRemoteDatasourceImpl({required this.firebaseAuth, required this.firestore});

  @override
  Future<void> deleteActivity({required String id}) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }
      await firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid)
          .collection(AppConstants.activitiesCollection)
          .doc(id)
          .delete();
    } on FirebaseException catch (e) {
      throw RemoteException.fromFirebaseException(e);
    } catch (e) {
      throw RemoteException(message: e.toString());
    }
  }
}
