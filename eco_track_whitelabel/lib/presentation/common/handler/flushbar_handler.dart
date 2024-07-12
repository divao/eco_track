import 'package:another_flushbar/flushbar.dart';
import 'package:common/presentation/common/app_theme/app_theme.dart';
import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlushbarHandler {
  factory FlushbarHandler() {
    return _instance;
  }

  FlushbarHandler._();

  static final FlushbarHandler _instance = FlushbarHandler._();

  static FlushbarHandler get instance {
    return _instance;
  }

  bool _isShowingFlush = false;

  void _displayFlushBar({
    required WidgetRef ref,
    required BuildContext context,
    required Text message,
    required Color leftBarIndicatorColor,
    required Duration duration,
    required Color backgroundColor,
    FlushbarPosition flushbarPosition = FlushbarPosition.TOP,
    Widget? icon,
    void Function()? whenComplete,
    double? maxWidth,
    BorderRadius? borderRadius,
    Duration? animationDuration,
    Widget? mainButton,
    Color? borderColor,
    double? borderWidth,
  }) {
    final colors = AppColors.of(ref);
    if (!_isShowingFlush) {
      _isShowingFlush = true;
      late final Flushbar<void> flushBar;
      flushBar = Flushbar(
        animationDuration:
        animationDuration ?? const Duration(milliseconds: 500),
        flushbarPosition: flushbarPosition,
        messageText: message,
        backgroundColor: backgroundColor,
        maxWidth: maxWidth ?? 343,
        borderRadius:
        borderRadius ?? const BorderRadius.all(Radius.circular(12)),
        icon: icon,
        leftBarIndicatorColor: leftBarIndicatorColor,
        mainButton: mainButton ??
            IconButton(
              icon: Icon(
                Icons.close,
                color: colors.flushbarIconColor,
              ),
              // ignore: unnecessary_lambdas
              onPressed: () => flushBar.dismiss(),
              iconSize: 24,
            ),
        shouldIconPulse: false,
        duration: duration,
        margin: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        borderColor: borderColor,
        borderWidth: borderWidth ?? 0,
      )..show(context).whenComplete(
        whenComplete ?? () => null,
      );
    }
    _isShowingFlush = false;
  }

  Future<void> serverErrorFlushbar(
      BuildContext context, {
        required WidgetRef ref,
      }) async {
    final colors = AppColors.of(ref);
    final textStyles = AppTextStyles.of(ref);
    _displayFlushBar(
      ref: ref,
      context: context,
      message: Text(
        ref.s.flushbarServerErrorMessage,
        style: textStyles.flushBarError,
      ),
      leftBarIndicatorColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      backgroundColor: colors.flushbarBackgroundColor,
      flushbarPosition: FlushbarPosition.BOTTOM,
      borderWidth: 1,
    );
  }

  Future<void> emailAlreadyUsedErrorFlushbar(
      BuildContext context, {
        required WidgetRef ref,
      }) async {
    final colors = AppColors.of(ref);
    final textStyles = AppTextStyles.of(ref);
    _displayFlushBar(
      ref: ref,
      context: context,
      message: Text(
        ref.s.flushbarEmailErrorMessage,
        style: textStyles.flushBarError,
      ),
      leftBarIndicatorColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      backgroundColor: colors.flushbarBackgroundColor,
      flushbarPosition: FlushbarPosition.BOTTOM,
      borderWidth: 1,
    );
  }
}
