import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quikhyr_worker/common/bloc/worker_bloc.dart';
import 'package:quikhyr_worker/common/data/repositories/worker_repo.dart';
import 'package:quikhyr_worker/features/auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:quikhyr_worker/features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:quikhyr_worker/features/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:quikhyr_worker/features/auth/data/repository/firebase_user_repo.dart';
import 'package:quikhyr_worker/my_app_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseUserRepo>(
          create: (context) => FirebaseUserRepo(),
        ),
        RepositoryProvider<WorkerRepo>(create: (context) => WorkerRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(create: (context) {
            final userRepository = context.read<FirebaseUserRepo>();
            return AuthenticationBloc(userRepository: userRepository);
          }),
          BlocProvider<SignInBloc>(create: (context) {
            final userRepository = context.read<FirebaseUserRepo>();

            return SignInBloc(userRepository: userRepository);
          }),
          BlocProvider<SignUpBloc>(create: (context) {
            final userRepository = context.read<FirebaseUserRepo>();

            return SignUpBloc(userRepository: userRepository);
          }),
          BlocProvider<WorkerBloc>(create: (context) {
            final workerRepo = context.read<WorkerRepo>();
            final firebaseUserRepo = context.read<FirebaseUserRepo>();
            return WorkerBloc(workerRepository: workerRepo, firebaseUserRepo: firebaseUserRepo)..add(FetchWorker());
          }),
        ],
        child: const MyAppView(),
      ),
    );
  }
}
