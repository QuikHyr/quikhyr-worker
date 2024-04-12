// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr_worker/common/quik_routes.dart';
import 'package:quikhyr_worker/common/routes/screens/page_not_found.dart';
import 'package:quikhyr_worker/common/routes/screens/splash_screen.dart';
import 'package:quikhyr_worker/features/auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:quikhyr_worker/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:quikhyr_worker/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:quikhyr_worker/features/auth/presentation/screens/welcome_screen.dart';
import 'package:quikhyr_worker/features/booking/presentation/screens/booking_screen.dart';
import 'package:quikhyr_worker/features/chat/presentation/screens/chat_conversation_screen.dart';
import 'package:quikhyr_worker/features/chat/presentation/screens/chat_screen.dart';
import 'package:quikhyr_worker/features/feedback/presentation/screens/feedback_screen.dart';
import 'package:quikhyr_worker/features/home/presentation/screens/home/home_screen.dart';
import 'package:quikhyr_worker/features/home/presentation/screens/home_detail/home_detail_screen.dart';
import 'package:quikhyr_worker/features/notification/presentation/notification_screen.dart';
import 'package:quikhyr_worker/features/settings/presentation/screens/settings_screen.dart';
import 'package:quikhyr_worker/main_wrapper.dart';
import 'package:quikhyr_worker/models/chat_list_model.dart';
import 'package:quikhyr_worker/models/client_model.dart';

abstract class AppRouter {
  final AuthenticationBloc authBloc;
  AppRouter({
    required this.authBloc,
  });
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHomeKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorChatKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellChat');
  static final _shellNavigatorBookKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellBook');
  static final _shellNavigatorFeedbackKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellFeedback');
  static final _shellNavigatorSettingsKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellSettings');
  static final GoRouter _router = GoRouter(
    initialLocation: QuikRoutes.homePath,
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      final status = context.read<AuthenticationBloc>().state.status;
      if (state.matchedLocation == QuikRoutes.signUpPath ||
          state.matchedLocation == QuikRoutes.signInPath ||
          state.matchedLocation == QuikRoutes.welcomePath ||
          state.matchedLocation == QuikRoutes.splashPath) {
        if (status == AuthenticationStatus.registered) {
          return QuikRoutes.homePath;
        }
        return null;
      }
      if (status == AuthenticationStatus.unknown ||
          status == AuthenticationStatus.unauthenticated) {
        return QuikRoutes.welcomePath;
      }
      // if (status == AuthenticationStatus.registered) {
      //   return QuikRoutes.homePath;
      // }
      // if (state.matchedLocation == QuikRoutes.homePath) {
      //   if (status == AuthenticationStatus.registered) {
      //     return null;
      //   } else {
      //     return QuikRoutes.welcomePath;
      //   }
      // }

      return null;
      // String? returnPath = QuikRoutes.homePath;
      // BlocListener<AuthenticationBloc, AuthenticationState>(
      //   listener: (context, authState) {
      //     if (authState.status == AuthenticationStatus.unknown) {
      //       returnPath = QuikRoutes.welcomePath;
      //     }
      //     if (authState.status == AuthenticationStatus.registered) {
      //       returnPath = QuikRoutes.homePath;
      //       return;
      //     } else if (authState.status == AuthenticationStatus.unauthenticated) {
      //       // User is not authenticated, redirect to login
      //       returnPath = QuikRoutes.signInPath;
      //     } else if (authState.status == AuthenticationStatus.authenticated) {
      //       // User is authenticated but not registered, redirect to registration
      //       returnPath = QuikRoutes.signUpPath;
      //     }
      //   },
      //   child: Container(),
      // );
      // return returnPath;
    },
    navigatorKey: _rootNavigatorKey,
    routes: [
// BlocBuilder<AuthenticationBloc, AuthenticationState>(
//         builder: (context, authState) {
//           if (authState.status == AuthenticationStatus.authenticated) {
//             return BlocProvider(
//               create: (context) => NavigationCubit(),
//               child: MainScreen(screen: child),
//             );
//           }
//           return const WelcomeScreen();
//         },
//       );

      StatefulShellRoute.indexedStack(
          //?UNCOMMENT IF NOT WORKING
          builder: (context, state, navigationShell) {
            debugPrint("Going to Main Wrapper");
            return MainWrapper(
              navigationShell: navigationShell,
            );
          },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
                navigatorKey: _shellNavigatorHomeKey,
                routes: <RouteBase>[
                  GoRoute(
                    // redirect: (context, state) async {
                    //   BlocListener<AuthenticationBloc, AuthenticationState>(
                    //     listener: (context, authState) {
                    //       if (authState.status ==
                    //           AuthenticationStatus.unknown) {
                    //         context.goNamed(QuikRoutes.welcomeName);
                    //       }
                    //       if (authState.status ==
                    //           AuthenticationStatus.registered) {
                    //         // User is registered, no redirect needed
                    //         return;
                    //       } else if (authState.status ==
                    //           AuthenticationStatus.unauthenticated) {
                    //         // User is not authenticated, redirect to login
                    //         context.goNamed(QuikRoutes.signUpName);
                    //       } else if (authState.status ==
                    //           AuthenticationStatus.authenticated) {
                    //         // User is authenticated but not registered, redirect to registration
                    //         context.goNamed(QuikRoutes.registrationName);
                    //       }
                    //     },
                    //     child: Container(),
                    //   );
                    //   return null;
                    // },
                    path: QuikRoutes.homePath,
                    name: QuikRoutes.homeName,
                    pageBuilder: (context, state) {
                      return NoTransitionPage(
                          child: HomeScreen(
                        key: state.pageKey,
                      ));
                    },
                    routes: [
                      GoRoute(
                        path: QuikRoutes.homeDetailsPath,
                        name: QuikRoutes.homeDetailsName,
                        pageBuilder: (context, state) {
                          return CustomTransitionPage<void>(
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(-1, 0);
                                const end = Offset.zero;
                                const curve = Curves.ease;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                              child: HomeDetailScreen(
                                // serviceModel: serviceModel,
                                key: state.pageKey,
                              ));
                        },
                      ),
                    ],
                  ),
                ]),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorChatKey,
              routes: <RouteBase>[
                GoRoute(
                    path: QuikRoutes.chatPath,
                    name: QuikRoutes.chatName,
                    pageBuilder: (context, state) => NoTransitionPage(
                          child: ChatScreen(key: state.pageKey),
                        ),
                    routes: [
                      GoRoute(
                          parentNavigatorKey: _rootNavigatorKey,
                          path: '${QuikRoutes.chatConversationPath}:clientId',
                          name: QuikRoutes.chatConversationName,
                          pageBuilder: (context, state) {
                            return CustomTransitionPage<void>(
                              // key: state.pageKey,
                              child: ChatConversationScreen(
                                clientId:
                                    state.pathParameters['clientId'] ?? '-99',
                              ),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(-1,
                                      0), // Modified: Start from left (-1, 0)
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              ),
                            );
                          }),
                    ]),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorBookKey,
              routes: <RouteBase>[
                GoRoute(
                  path: QuikRoutes.bookingPath,
                  name: QuikRoutes.bookingName,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: BookingScreen(key: state.pageKey),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorFeedbackKey,
              routes: <RouteBase>[
                GoRoute(
                  path: QuikRoutes.feedbackPath,
                  name: QuikRoutes.feedbackName,
                  pageBuilder: (context, state) => NoTransitionPage(
                    //ADD FILTERCHIP PROVIDER TO TRY OUT NOT PUTTING ALL BLOCS IN MAIN FILE
                    child: FeedbackScreen(
                      key: state.pageKey,
                    ),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorSettingsKey,
              routes: <RouteBase>[
                GoRoute(
                  path: QuikRoutes.settingsPath,
                  name: QuikRoutes.settingsName,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: SettingsScreen(key: state.pageKey),
                  ),
                ),
              ],
            ),
          ]),
      GoRoute(
          path: QuikRoutes.notificationPath,
          name: QuikRoutes.notificationName,
          pageBuilder: (context, state) => const NoTransitionPage(
                child: NotificationScreen(),
              )),

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: QuikRoutes.signUpPath,
        name: QuikRoutes.signUpName,
        builder: (context, state) {
          return const SignUpScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: QuikRoutes.signInPath,
        name: QuikRoutes.signInName,
        builder: (context, state) {
          return const SignInScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: QuikRoutes.welcomePath,
        name: QuikRoutes.welcomeName,
        builder: (context, state) {
          return const WelcomeScreen();
        },
      ),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: QuikRoutes.splashPath,
          name: QuikRoutes.splashName,
          builder: (context, state) => const SplashScreen()),
      //It is not necessary to provide a navigatorKey if it isn't also
      //needed elsewhere. If not provided, a default key will be used.
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );

  static GoRouter get router => _router;
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:quikhyr/common/constants/app_routes.dart';
// import 'package:quikhyr/common/cubits/navigation_cubit/navigation_cubit.dart';
// import 'package:quikhyr/features/auth/blocs/authentication_bloc/authentication_bloc.dart';
// import 'package:quikhyr/features/auth/presentation/screens/welcome_screen.dart';
// import 'package:quikhyr/features/home/presentation/screens/home/home_screen.dart';
// import 'package:quikhyr/main_screen.dart';

// class AppNavigation {
//   AppNavigation._();

//   static final _rootNavigatorKey = GlobalKey<NavigatorState>();
//   static final _rootNavigatorHomeKey =
//       GlobalKey<NavigatorState>(debugLabel: 'shellHome');
//   static final _shellNavigatorExploreKey =
//       GlobalKey<NavigatorState>(debugLabel: 'shellExplore');
//   static final _shellNavigatorChatKey =
//       GlobalKey<NavigatorState>(debugLabel: 'shellChat');
//   static final _shellNavigatorBookKey =
//       GlobalKey<NavigatorState>(debugLabel: 'shellBook');
//   static final _shellNavigatorProfileKey =
//       GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
//   static final GoRouter router = GoRouter(
//       initialLocation: QuikRoutes.homeNamedPage,
//       navigatorKey: _rootNavigatorKey,
//       routes: <RouteBase>[
//         StatefulShellRoute.indexedStack(
//             builder: (context, state, child) {
//               return BlocBuilder<AuthenticationBloc, AuthenticationState>(
//                 builder: (context, authState) {
//                   if (authState.status == AuthenticationStatus.authenticated) {
//                     return BlocProvider(
//                       create: (context) => NavigationCubit(),
//                       child: MainScreen(screen: child),
//                     );
//                   }
//                   return const WelcomeScreen();
//                 },
//               );
//             },
//             branches: <StatefulShellBranch>[
//               StatefulShellBranch(navigatorKey: _rootNavigatorHomeKey, routes: [
//                 GoRoute(
//                   path: QuikRoutes.homeNamedPage,
//                   name: 'Home',
//                   builder: (context, state) {
//                     return NoTransitionPage(child: HomeScreen());
//                   },
//                 )
//               ])
//             ])
//       ]);
// }
