import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr_worker/common/quik_routes.dart';
import 'package:quikhyr_worker/common/routes/screens/page_not_found.dart';
import 'package:quikhyr_worker/features/auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:quikhyr_worker/features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:quikhyr_worker/features/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:quikhyr_worker/features/auth/presentation/screens/registration_screen.dart';
import 'package:quikhyr_worker/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:quikhyr_worker/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:quikhyr_worker/features/auth/presentation/screens/welcome_screen.dart';
import 'package:quikhyr_worker/features/booking/presentation/screens/booking_screen.dart';
import 'package:quikhyr_worker/features/chat/presentation/screens/chat_conversation_screen.dart';
import 'package:quikhyr_worker/features/chat/presentation/screens/chat_screen.dart';
import 'package:quikhyr_worker/features/feedback/presentation/screens/feedback_screen.dart';
import 'package:quikhyr_worker/features/home/presentation/screens/home/home_screen.dart';
import 'package:quikhyr_worker/features/home/presentation/screens/home_detail/home_detail_screen.dart';
import 'package:quikhyr_worker/features/settings/presentation/screens/settings_screen.dart';
import 'package:quikhyr_worker/main_wrapper.dart';
import 'package:quikhyr_worker/models/client_model.dart';

class AppRouter {
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
          builder: (context, state, navigationShell) {
            debugPrint("Going to Main Wrapper");
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, authState) {
              if (authState.status == AuthenticationStatus.registered) {
                debugPrint(navigationShell.shellRouteContext.route.toString());
                return MainWrapper(
                  navigationShell: navigationShell,
                );
              } else if (authState.status ==
                  AuthenticationStatus.unauthenticated) {
                return const WelcomeScreen();
              } else if (authState.status ==
                  AuthenticationStatus.authenticated) {
                return const RegistrationScreen();
              } else {
                return const WelcomeScreen();
              }
            });

            // redirect: (context, state) async {
            //           BlocListener<AuthenticationBloc, AuthenticationState>(
            //             listener: (context, authState) {
            //               if (authState.status ==
            //                   AuthenticationStatus.unknown) {
            //                 context.goNamed(QuikRoutes.welcomeName);
            //               }
            //               if (authState.status ==
            //                   AuthenticationStatus.registered) {
            //                 // User is registered, no redirect needed
            //                 return;
            //               } else if (authState.status ==
            //                   AuthenticationStatus.unauthenticated) {
            //                 // User is not authenticated, redirect to login
            //                 context.goNamed(QuikRoutes.signUpName);
            //               } else if (authState.status ==
            //                   AuthenticationStatus.authenticated) {
            //                 // User is authenticated but not registered, redirect to registration
            //                 context.goNamed(QuikRoutes.registrationName);
            //               }
            //             },
            //             child: Container(),
            //           );
            //           return null;
            //         },
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
                        path: QuikRoutes.chatConversationPath,
                        name: QuikRoutes.chatConversationName,
                        pageBuilder: (context, state) =>
                            CustomTransitionPage<void>(
                          // key: state.pageKey,
                          child: ChatConversationScreen(
                            client: state.extra as ClientModel,
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(
                                  -1, 0), // Modified: Start from left (-1, 0)
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        ),
                      ),
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
        path: QuikRoutes.registrationPath,
        name: QuikRoutes.registrationName,
        builder: (context, state) {
          return const RegistrationScreen();
        },
      ),
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
