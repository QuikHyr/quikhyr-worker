import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_routes.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';
import 'package:quikhyr_worker/common/widgets/longIconButton.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (GoRouter.of(context).canPop()) {
          context.pop();
          return false;
        } else {
          bool shouldClose = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Confirmation'),
              content: const Text('Are you sure you want to close the app?'),
              actions: [
                TextButton(
                  onPressed: () => context.pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => context.pop(true),
                  child: const Text('Yes'),
                ),
              ],
            ),
          );
          return shouldClose;
        }
      },
      child: Scaffold(
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
                      context.pushNamed(QuikRoutes.signUpName);
                    },
                  ),
                  QuikSpacing.vS12(),
                  LongIconButton(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                    text: "Already have an account",
                    svgPath: QuikAssetConstants.rightArrowSvg,
                    onPressed: () {
                       context.pushNamed(QuikRoutes.signInName);
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
      ),
    );
  }
}
