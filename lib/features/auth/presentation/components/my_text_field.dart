import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Color? enabledBorderColor;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final String? Function(String?)? onChanged;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    this.enabledBorderColor,
    this.suffixIcon,
    this.onTap,
    this.prefixIcon,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  Color backgroundColor = const Color(0xFF313131);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            backgroundColor =
                hasFocus ? Colors.transparent : const Color(0xFF313131);
          });
        },
        child: Builder(
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: backgroundColor,
              ),
              child: TextFormField(
                validator: widget.validator,
                controller: widget.controller,
                obscureText: widget.obscureText,
                keyboardType: widget.keyboardType,
                focusNode: widget.focusNode,
                onTap: () {
                  widget.onTap?.call();
                },
                onFieldSubmitted: (value) {
                  // You can add any additional logic here if needed
                },
                textInputAction: TextInputAction.next,
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                  suffixIcon: widget.suffixIcon,
                  prefixIcon: widget.prefixIcon,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: widget.enabledBorderColor ??
                          Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  fillColor: Colors.transparent,
                  filled: true,
                  focusColor: Colors.transparent,
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(233, 234, 236, 0.50),
                    fontFamily: 'Trap',
                    fontSize: 13,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                  labelStyle: const TextStyle(
                    color: Color.fromRGBO(233, 234, 236, 0.50),
                    fontFamily: 'Trap',
                    fontSize: 13,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                  errorText: widget.errorMsg,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
