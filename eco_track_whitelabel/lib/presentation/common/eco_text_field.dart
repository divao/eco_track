import 'package:common/presentation/common/app_theme/app_theme.dart';
import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EcoTextField extends ConsumerStatefulWidget {
  const EcoTextField({
    required this.labelText,
    this.textCapitalization = TextCapitalization.none,
    this.controller,
    this.focusNode,
    this.hintText,
    this.isPassword = false,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.height,
    this.onEditingComplete,
    this.textInputAction,
    this.errorText,
    this.inputFormatters,
    super.key,
  });

  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final String? hintText;
  final String labelText;
  final double? height;
  final bool isPassword;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onEditingComplete;
  final TextInputAction? textInputAction;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EqlTextFieldState();
}

class _EqlTextFieldState extends ConsumerState<EcoTextField> {
  var _isPasswordVisible = false;
  var _hasFocus = false;

  @override
  void initState() {
    super.initState();

    widget.focusNode?.addListener(() {
      if (mounted) {
        setState(() {
          _hasFocus = widget.focusNode!.hasFocus;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: widget.errorText != null
              ? ref.textStyles.textFieldErrorLabelStyle
              : _hasFocus
              ? ref.textStyles.textFieldFocusedLabelStyle
              : ref.textStyles.textFieldUnfocusedLabelStyle,
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 4,
        ),
        TextField(
          textCapitalization: widget.textCapitalization,
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: widget.isPassword && !_isPasswordVisible,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          onEditingComplete: widget.onEditingComplete,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          style: textStyles.textFieldInputTextStyle,
          decoration: InputDecoration(
            hintText: widget.hintText,
            errorText: widget.errorText,
            hintStyle: textStyles.textFieldHintTextStyle,
            alignLabelWithHint: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: ref.colors.textFieldUnfocusedBorderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: ref.colors.textFieldUnfocusedBorderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: ref.colors.textFieldFocusedBorderColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: ref.colors.textFieldErrorBorderColor,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: ref.colors.textFieldErrorBorderColor,
              ),
            ),
            isDense: true,
            suffixIconConstraints: BoxConstraints(
              minWidth: 40,
              minHeight: widget.height ?? 48,
            ),
            suffixIcon: widget.isPassword
                ? GestureDetector(
              onTap: () {
                if (mounted) {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                }
              },
              child: Icon(
                _isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: ref.colors.textFieldPasswordVisibilityIconColor,
                size: 24,
              ),
            )
                : Container(
              width: 1,
            ),
          ),
        ),
      ],
    );
  }
}
