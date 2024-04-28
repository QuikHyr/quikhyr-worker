import 'package:flutter/material.dart';

import '../../../../common/quik_colors.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final String? Function(String?)? onChanged;
  final String? initialValue;
  final bool isReadOnly; // Added isReadOnly property

  const MyTextField({
    this.initialValue,
    Key? key,
    this.controller,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    this.suffixIcon,
    this.onTap,
    this.prefixIcon,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
    this.isReadOnly = false, // Set default value for isReadOnly
  }) : super(key: key);

  @override
  MyTextFieldState createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyTextField> {
  Color backgroundColor = textInputBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!widget.isReadOnly) { // Only change color if not read-only
          setState(() {
            backgroundColor = hasFocus
                ? textInputActiveBackgroundColor
                : textInputActiveBackgroundColor;
          });
        }
      },
      child: Builder(
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: backgroundColor,
            ),
            child: TextFormField(
              initialValue: widget.initialValue,
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
              readOnly: widget.isReadOnly, // Use isReadOnly property
              decoration: InputDecoration(
                suffixIcon: widget.suffixIcon,
                prefixIcon: widget.prefixIcon,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  //borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                fillColor: textInputBackgroundColor,
                filled: true,
                // focusColor: textInputActiveBackgroundColor,
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
    );
  }
}
