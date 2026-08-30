import 'package:firebase_core/firebase_core.dart';

class RemoteException implements Exception {
  final String message;
  final String? code;

  const RemoteException({
    required this.message,
    this.code,
  });

  factory RemoteException.fromFirebaseException(
      FirebaseException exception,
      ) {
    return RemoteException(
      message: exception.message ?? 'Something went wrong',
      code: exception.code,
    );
  }

  @override
  String toString() {
    return 'RemoteException: $message${code != null ? ' ($code)' : ''}';
  }
}