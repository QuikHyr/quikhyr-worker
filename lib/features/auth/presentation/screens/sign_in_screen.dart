import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_routes.dart';
import 'package:quikhyr_worker/common/widgets/longIconButton.dart';
import 'package:quikhyr_worker/features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:quikhyr_worker/features/auth/presentation/components/my_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  String? _errorMsg;

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
              image: AssetImage(QuikAssetConstants.welcomeBackground),
              fit: BoxFit.cover),
        ),
        child: BlocListener<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignInSuccess) {
              signInRequired = false;
              context.goNamed(QuikRoutes.homeName);
            } else if (state is SignInProcess) {
              setState(() {
                signInRequired = true;
              });
            } else if (state is SignInFailure) {
              setState(() {
                signInRequired = false;
                _errorMsg = 'Invalid email or password';
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              QuikAssetConstants.logoSvg,
                              width: 200,
                            ),
                          ),
                          const SizedBox(height: 64),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Phone or Email",
                              style: TextStyle(
                                color: Color(
                                    0xFFE9EAEC), // Replace with the equivalent Flutter color
                                fontFamily:
                                    'Trap', // Ensure 'Trap' font is added to your pubspec.yaml
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: MyTextField(
                              controller: emailController,
                              hintText: 'Enter phone or email*',
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                              errorMsg: _errorMsg,
                              validator: (val) {
                                return null;
                                // if (val!.isEmpty) {
                                //   return 'Please fill in this field';
                                // } else if (!RegExp(
                                //         r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                                //     .hasMatch(val)) {
                                //   return 'Please enter a valid email';
                                // }
                                // return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Password",
                              style: TextStyle(
                                color: Color(
                                    0xFFE9EAEC), // Replace with the equivalent Flutter color
                                fontFamily:
                                    'Trap', // Ensure 'Trap' font is added to your pubspec.yaml
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: MyTextField(
                              controller: passwordController,
                              hintText: 'Enter password*',
                              obscureText: obscurePassword,
                              keyboardType: TextInputType.visiblePassword,
                              errorMsg: _errorMsg,
                              validator: (val) {
                                // if (val!.isEmpty) {
                                //   return 'Please fill in this field';
                                // } else if (!RegExp(
                                //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                                //     .hasMatch(val)) {
                                //   return 'Please enter a valid password';
                                // }
                                return null;
                              },
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                    if (obscurePassword) {
                                      iconPassword = CupertinoIcons.eye_fill;
                                    } else {
                                      iconPassword =
                                          CupertinoIcons.eye_slash_fill;
                                    }
                                  });
                                },
                                icon: Icon(
                                  iconPassword,
                                  color:
                                      const Color.fromRGBO(233, 234, 236, 0.50),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "*Required",
                              style: TextStyle(
                                color: Color.fromRGBO(233, 234, 236, 0.50),
                                fontFamily: 'Trap',
                                fontSize: 12,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(height: 20),
                        !signInRequired
                            ? LongIconButton(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                svgPath: QuikAssetConstants.rightArrowSvg,
                                text: 'Continue',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<SignInBloc>().add(
                                          SignInRequired(
                                            emailController.text,
                                            passwordController.text,
                                          ),
                                        );
                                  }
                                },
                              )
                            : const CircularProgressIndicator(),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            context.goNamed(QuikRoutes.signUpName);
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Not registered yet?",
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: [
                                TextSpan(
                                  text: " Sign up ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
