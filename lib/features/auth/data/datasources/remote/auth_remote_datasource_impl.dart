import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:veyra/core/exceptions/auth_exceptions.dart';
import 'package:veyra/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:veyra/features/auth/data/models/user_model.dart';

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDatasourceImpl({required this.firebaseAuth, required this.firestore});

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email.trim(), password: password);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } catch (_) {
      throw const AuthUnknownException();
    }
  }

  @override
  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw const AuthUnknownException();
      }
      await user.updateDisplayName(fullName);
      await user.reload();
      final userModel = UserModel(fullName: fullName.trim(), email: email.trim());

      await firestore.collection('users').doc(user.uid).set(userModel.toJson());
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } on FirebaseException catch (_) {
      throw const AuthUnknownException();
    } catch (_) {
      throw const AuthUnknownException();
    }
  }

  AuthException _mapFirebaseAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-credential':
      case 'wrong-password':
        return const InvalidCredentialsException();

      case 'user-not-found':
        return const UserNotFoundException();

      case 'user-disabled':
        return const UserDisabledException();

      case 'email-already-in-use':
        return const EmailAlreadyInUseException();

      case 'weak-password':
        return const WeakPasswordException();

      case 'invalid-email':
        return const InvalidEmailException();

      case 'too-many-requests':
        return const TooManyRequestsException();

      default:
        return const AuthUnknownException();
    }
  }
}
