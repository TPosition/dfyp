import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import '/app/app.dart';
import 'package:transactions_repository/transactions_repository.dart';
import 'package:users_repository/users_repository.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  final usersRepository = FirebaseUsersRepository();
  final transactionsRepository = FirebaseTransactionsRepository();
  runApp(
    App(
      transactionsRepository: transactionsRepository,
      usersRepository: usersRepository,
      authenticationRepository: authenticationRepository,
    ),
  );
}
