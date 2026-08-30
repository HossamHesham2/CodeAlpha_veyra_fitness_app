import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:veyra/core/exceptions/remote_exceptions.dart';
import 'package:veyra/features/add_activity/data/datasources/remote/add_activity_remote_datasource.dart';
import 'package:veyra/features/add_activity/data/models/activity_model.dart';

class AddActivityRemoteDatasourceImpl extends AddActivityRemoteDatasource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  AddActivityRemoteDatasourceImpl({required this.firestore, required this.firebaseAuth});

  @override
  Future<void> addActivity({required ActivityModel activityModel}) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw const RemoteException(message: 'User is not authenticated');
      }
      await firestore
          .collection('users')
          .doc(user.uid)
          .collection("activities")
          .add(activityModel.toJson());
    } on FirebaseException catch (e) {
      throw RemoteException.fromFirebaseException(e);
    } on RemoteException {
      rethrow;
    } catch (e) {
      throw RemoteException(message: e.toString());
    }
  }
}
