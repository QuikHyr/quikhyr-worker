import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';
import 'package:quikhyr_worker/common/widgets/longIconButton.dart';
import 'package:quikhyr_worker/features/auth/presentation/components/my_text_field.dart';
import '../../blocs/sign_up_bloc/sign_up_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final PageController pageController = PageController();
  int _curr = 0;
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          buildSignUp(),
          buildSetPassword(),
          buildProfileInfo(),
        ],
        onPageChanged: (num) {
          setState(() {
            _curr = num;
          });
        },
      ),
    );
  }

  Pages buildProfileInfo() {
    return Pages(
      pageController: pageController, // Added pageController here
      onButtonPressed: () {},
      color: Colors.grey,
      buttonText: "Continue",
      children: [
        const SizedBox(
          height: 64.0,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: const Text(
            "Profile Information",
            style: TextStyle(
              color: Color(0xFFE9EAEC),
              fontFamily: 'Trap',
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        // MyTextField(controller: TextEditingController(),
        //   hintText: "Select Role*", obscureText: false, keyboardType: TextInputType.text ,),
        //   const SizedBox(height: 12.0,),
        MyTextField(
          controller: TextEditingController(),
          hintText: "Select Gender",
          obscureText: false,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(
          height: 12.0,
        ),
        MyTextField(
          controller: TextEditingController(),
          hintText: "Enter date of birth*",
          obscureText: false,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(
          height: 12.0,
        ),
        MyTextField(
          controller: TextEditingController(),
          hintText: "Enter address*",
          obscureText: false,
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }

  Pages buildSetPassword() {
    return Pages(
      pageController: pageController, // Added pageController here
      onButtonPressed: () => pageController.animateToPage(2,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn),
      color: Colors.red.shade100,
      buttonText: "Profile Info",
      children: [
        const SizedBox(
          height: 64.0,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: const Text(
            "Set Password",
            style: TextStyle(
              color: Color(0xFFE9EAEC),
              fontFamily: 'Trap',
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        MyTextField(
          controller: _passwordController,
          hintText: "Enter password*",
          obscureText: false,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(
          height: 12.0,
        ),
        MyTextField(
          controller: TextEditingController(),
          hintText: "Re-enter password*",
          obscureText: false,
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }

  Pages buildSignUp() {
    return Pages(
      pageController: pageController, // Added pageController here
      onButtonPressed: () {
        // context.read<SignUpBloc>().add(SignUpRequired(
        //       user: UserModel(userId: '', email: "email", name: "name"),
        //       password: "password",
        //     ));
        pageController.animateToPage(1,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      },
      color: Colors.teal,
      buttonText: "Set Password",
      children: [
        const SizedBox(
          height: 32.0,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: const Text(
            "Name",
            style: TextStyle(
              color: Color(0xFFE9EAEC),
              fontFamily: 'Trap',
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        MyTextField(
          controller: TextEditingController(),
          hintText: "Enter name*",
          obscureText: false,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(
          height: 24.0,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: const Text(
            "Phone and Email",
            style: TextStyle(
              color: Color(0xFFE9EAEC),
              fontFamily: 'Trap',
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        MyTextField(
          controller: TextEditingController(),
          hintText: "Enter phone*",
          obscureText: false,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(
          height: 12.0,
        ),
        MyTextField(
          controller: TextEditingController(),
          hintText: "Enter email*",
          obscureText: false,
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }
}

class Pages extends StatelessWidget {
  final Color color;
  final String buttonText;
  final List<Widget> children;
  final PageController pageController;
  final VoidCallback onButtonPressed;

  Pages({
    required this.color,
    required this.buttonText,
    required this.children,
    required this.pageController,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(QuikAssetConstants.welcomeBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      QuikAssetConstants.logoSvg,
                      width: 200,
                    ),
                    ...children,
                    SizedBox(
                      height: 5.0,
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
                children: [
                  LongIconButton(
                    text: buttonText,
                    onPressed: onButtonPressed,
                    svgPath: QuikAssetConstants.rightArrowSvg,
                  ),
                  QuikSpacing.vS20(),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account?",
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: " Log in ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final PageController pageController = PageController();
final List<Widget> _list = <Widget>[];
