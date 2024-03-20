import 'package:flutter/material.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_colors.dart';
import 'package:quikhyr_worker/common/widgets/clickable_svg_icon.dart';

class QuikSearchBar extends StatefulWidget {
  final String hintText;
  final VoidCallback onMicPressed;
  final Function(String) onSearch;
  final TextEditingController controller;
  final Function(String)? onChanged;

  const QuikSearchBar({
    Key? key,
    required this.onChanged,
    required this.hintText,
    required this.onMicPressed,
    required this.onSearch,
    required this.controller,
  }) : super(key: key);

  @override
  State<QuikSearchBar> createState() => _QuikSearchBarState();
}

class _QuikSearchBarState extends State<QuikSearchBar> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);

    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Icon(
            Icons.search,
            color: textInputIconColor,
          ),
        ),
        suffixIcon: SizedBox(
          width: 66,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 24,
                child: VerticalDivider(color: textInputIconColor),
              ),
              ClickableSvgIcon(
                  svgAsset: QuikAssetConstants.searchMicSvg,
                  onTap: widget.onMicPressed)
            ],
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: primary),
        ),
        filled: true,
        fillColor: _focusNode.hasFocus
            ? textInputActiveBackgroundColor
            : textInputBackgroundColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      ),
      onChanged: widget.onChanged,
      onSubmitted: widget.onSearch,
    );
  }
}
