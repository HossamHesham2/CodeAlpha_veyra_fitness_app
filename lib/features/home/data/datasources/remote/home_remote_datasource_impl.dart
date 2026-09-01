import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:veyra/core/constants/app_constants.dart';
import 'package:veyra/core/exceptions/remote_exceptions.dart';
import 'package:veyra/features/add_activity/data/models/activity_model.dart';
import 'package:veyra/features/home/data/datasources/remote/home_remote_datasource.dart';

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  HomeRemoteDatasourceImpl({required this.firestore, required this.firebaseAuth});

  @override
  Future<List<ActivityModel>> getActivities() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }
      final snapshot = await firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid)
          .collection(AppConstants.activitiesCollection)
          .orderBy('date', descending: true)
          .get();
      return snapshot.docs.map((doc) => ActivityModel.fromJson(doc.data())).toList();
    } on FirebaseException catch (e) {
      throw RemoteException.fromFirebaseException(e);
    }
  }
}
