import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:veyra/features/add_activity/data/datasources/remote/add_activity_remote_datasource.dart';
import 'package:veyra/features/add_activity/data/datasources/remote/add_activity_remote_datasource_impl.dart';
import 'package:veyra/features/add_activity/data/repositories/add_activity_repository_impl.dart';
import 'package:veyra/features/add_activity/domain/repositories/add_activity_repository.dart';
import 'package:veyra/features/add_activity/domain/usecases/add_activity_use_case.dart';
import 'package:veyra/features/add_activity/presentation/bloc/add_activity_bloc.dart';
import 'package:veyra/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:veyra/features/auth/data/datasources/remote/auth_remote_datasource_impl.dart';
import 'package:veyra/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:veyra/features/auth/domain/repositories/auth_repository.dart';
import 'package:veyra/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:veyra/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:veyra/features/auth/presentation/bloc/auth_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependency() async {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  // Data Sources
  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(
      firebaseAuth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
    ),
  );
  getIt.registerLazySingleton<AddActivityRemoteDatasource>(
    () => AddActivityRemoteDatasourceImpl(
      firebaseAuth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
    ),
  );
  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDatasource: getIt<AuthRemoteDatasource>()),
  );
  getIt.registerLazySingleton<AddActivityRepository>(
    () => AddActivityRepositoryImpl(activityRemoteDatasource: getIt<AddActivityRemoteDatasource>()),
  );
  // UseCases
  getIt.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<AddActivityUseCase>(
    () => AddActivityUseCase(addActivityRepository: getIt<AddActivityRepository>()),
  );
  // State Management
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(signInUseCase: getIt<SignInUseCase>(), signUpUseCase: getIt<SignUpUseCase>()),
  );
  getIt.registerFactory<AddActivityBloc>(
    () => AddActivityBloc(addActivityUseCase: getIt<AddActivityUseCase>()),
  );
}
