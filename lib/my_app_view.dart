import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quikhyr_worker/common/quik_themes.dart';
import 'package:quikhyr_worker/common/routes/router.dart';
import 'package:quikhyr_worker/features/auth/blocs/authentication_bloc/authentication_bloc.dart';

import 'features/chat/notification_service.dart';

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {

    final notificationService = NotificationsService();

  @override
  void initState() {
   notificationService.firebaseNotification(context);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        AppRouter.router.refresh();
      },
      child: MaterialApp.router(
        routeInformationProvider: AppRouter.router.routeInformationProvider,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routerDelegate: AppRouter.router.routerDelegate,
        debugShowCheckedModeBanner: false,
        title: 'QuikHyr',
        theme: AppTheme.appTheme,
      ),
    );
  }
}
