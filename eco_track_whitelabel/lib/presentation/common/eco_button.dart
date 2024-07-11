import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ButtonType { outlined, text, filledGreen }

class EcoButton extends ConsumerWidget {
  const EcoButton({
    required this.text,
    this.isLoading = false,
    this.buttonType = ButtonType.filledGreen,
    this.height,
    this.width,
    this.padding,
    this.onPressed,
    this.textAlign = TextAlign.center,
    super.key,
  });

  final String text;
  final ButtonType buttonType;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: height,
      width: width,
      constraints: const BoxConstraints(
        minHeight: 48,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: switch (buttonType) {
            ButtonType.outlined => Colors.transparent,
            ButtonType.text => Colors.transparent,
            ButtonType.filledGreen => ref.colors.filledGreenButtonColor,
          },
          foregroundColor: switch (buttonType) {
            ButtonType.outlined => Colors.transparent,
            ButtonType.text => Colors.transparent,
            ButtonType.filledGreen => ref.colors.filledGreenButtonColor,
          },
          disabledBackgroundColor: switch (buttonType) {
            ButtonType.outlined => Colors.transparent,
            ButtonType.text => Colors.transparent,
            ButtonType.filledGreen => ref.colors.filledGreenButtonColor,
          },
          disabledForegroundColor: switch (buttonType) {
            ButtonType.outlined => Colors.transparent,
            ButtonType.text => Colors.transparent,
            ButtonType.filledGreen => ref.colors.filledGreenButtonColor,
          },
          padding: padding,
          shape: buttonType == ButtonType.outlined
              ? RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            side: BorderSide(
              color: ref.colors.buttonBorderColor,
            ),
          )
              : const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
        ),
        onPressed: onPressed,
        child: isLoading
            ? SizedBox(
          height: 20,
          width: 20,
          child: Center(
            child: CircularProgressIndicator(
              color: buttonType == ButtonType.filledGreen
                  ? ref.colors.buttonFilledGreenLoadingIndicatorColor
                  : ref.colors.buttonLoadingIndicatorColor,
            ),
          ),
        )
            : Opacity(
          opacity: onPressed != null ? 1 : 0.3,
          child: Text(
            text,
            textAlign: textAlign,
            style: switch (buttonType) {
              ButtonType.outlined => ref.textStyles.outlinedButtonTextStyle,
              ButtonType.text =>
              ref.textStyles.textButtonTextStyle,
              ButtonType.filledGreen =>
              ref.textStyles.filledGreenButtonTextStyle,
            },
          ),
        ),
      ),
    );
  }
}
