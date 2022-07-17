import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:complaints_repository/complaint_repository.dart';
import 'package:compounds_repository/compounds_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:licenses_repository/licenses_repository.dart';
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
  final licensesRepository = FirebaseLicensesRepository();
  final complaintsRepository = FirebaseComplaintsRepository();
  final compoundsRepository = FirebaseCompoundsRepository();
  runApp(
    App(
      transactionsRepository: transactionsRepository,
      usersRepository: usersRepository,
      authenticationRepository: authenticationRepository,
      licensesRepository: licensesRepository,
      complaintsRepository: complaintsRepository,
      compoundsRepository: compoundsRepository,
    ),
  );
}
