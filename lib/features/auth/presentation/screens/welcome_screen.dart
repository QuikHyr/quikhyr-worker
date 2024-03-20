import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';
import 'package:quikhyr_worker/common/widgets/longIconButton.dart';
import 'package:quikhyr_worker/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:quikhyr_worker/features/auth/presentation/screens/sign_up_screen.dart';
import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/sign_up_bloc/sign_up_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/welcome_background.png'),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      QuikAssetConstants.logoSvg,
                      width: 200,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LongIconButton(
                  text: "Let's get started",
                  svgPath: QuikAssetConstants.rightArrowSvg,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => SignUpBloc(
                              userRepository: context
                                  .read<AuthenticationBloc>()
                                  .userRepository),
                          child: const SignUpScreen(),
                        ),
                      ),
                    );
                  },
                ),
                QuikSpacing.vS12(),
                LongIconButton(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  text: "Already have an account",
                  svgPath: QuikAssetConstants.rightArrowSvg,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => SignInBloc(
                              userRepository: context
                                  .read<AuthenticationBloc>()
                                  .userRepository),
                          child: const SignInScreen(),
                        ),
                      ),
                    );
                  },
                ),
                QuikSpacing.vS24(),
                Text(
                  "By continuing, you give consent to QuikHyr's",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                QuikSpacing.vS4(),
                RichText(
                  text: TextSpan(
                    text: "Terms of Service",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                    children: [
                      TextSpan(
                        text: " and ",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextSpan(
                        text: "Privacy Policy",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                QuikSpacing.vS24(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
