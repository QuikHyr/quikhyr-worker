import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quikhyr_worker/common/bloc/worker_bloc.dart';
import 'package:quikhyr_worker/common/data/repositories/worker_repo.dart';
import 'package:quikhyr_worker/features/auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:quikhyr_worker/features/auth/blocs/bloc/service_and_subservice_list_bloc.dart';
import 'package:quikhyr_worker/features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:quikhyr_worker/features/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:quikhyr_worker/features/auth/data/data_provider/service_and_subservices_data_provider.dart';
import 'package:quikhyr_worker/features/auth/data/repository/firebase_user_repo.dart';
import 'package:quikhyr_worker/features/auth/data/repository/service_and_subservice_repo.dart';
import 'package:quikhyr_worker/features/chat/firebase_provider.dart';
import 'package:quikhyr_worker/features/notification/cubit/notification_cubit.dart';
import 'package:quikhyr_worker/features/notification/repository/notification_repo.dart';
import 'package:quikhyr_worker/my_app_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NotificationRepo>(
            create: (context) => NotificationRepo()),
        RepositoryProvider<FirebaseUserRepo>(
          create: (context) => FirebaseUserRepo(),
        ),
        RepositoryProvider<WorkerRepo>(create: (context) => WorkerRepo()),
        RepositoryProvider<ServiceAndSubserviceRepo>(
          create: (context) => ServiceAndSubserviceRepo(
              dataProvider: ServiceAndSubservicesDataProvider()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NotificationCubit>(
            create: (context) {
              return NotificationCubit(
                RepositoryProvider.of<NotificationRepo>(context),
              );
            },
          ),
          BlocProvider<AuthenticationBloc>(
              lazy: false,
              create: (context) {
                final userRepository = context.read<FirebaseUserRepo>();
                return AuthenticationBloc(
                    userRepository: userRepository,
                    workerRepository: context.read<WorkerRepo>());
              }),
          BlocProvider<SignInBloc>(create: (context) {
            final userRepository = context.read<FirebaseUserRepo>();

            return SignInBloc(
                userRepository: userRepository,
                authenticationBloc: context.read<AuthenticationBloc>());
          }),
          BlocProvider<SignUpBloc>(create: (context) {
            final userRepository = context.read<FirebaseUserRepo>();

            return SignUpBloc(
                userRepository: userRepository,
                authenticationBloc: context.read<AuthenticationBloc>());
          }),
          BlocProvider<WorkerBloc>(create: (context) {
            final workerRepo = context.read<WorkerRepo>();
            final firebaseUserRepo = context.read<FirebaseUserRepo>();
            return WorkerBloc(
                workerRepository: workerRepo,
                firebaseUserRepo: firebaseUserRepo);
          }),
          BlocProvider<ServiceAndSubserviceListBloc>(create: (context) {
            final serviceAndSubserviceRepo =
                context.read<ServiceAndSubserviceRepo>();
            return ServiceAndSubserviceListBloc(serviceAndSubserviceRepo);
          }),
        ],
        child: ChangeNotifierProvider(
            create: (_) => FirebaseProvider(), child: const MyAppView()),
        // child: MyAppView()),
      ),
    );
  }
}
