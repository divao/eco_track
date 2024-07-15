import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:eco_track_whitelabel/presentation/common/eco_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DialogHandler {
  factory DialogHandler() => _instance;

  DialogHandler._();

  static final DialogHandler _instance = DialogHandler._();

  static DialogHandler get instance => _instance;

  Future<void> _showDialog(
    BuildContext context,
    WidgetRef ref, {
    Widget? title,
    TextStyle? titleTextStyle,
    Widget? content,
    TextStyle? contentTextStyle,
    Color? backgroundColor,
    List<Widget>? actions,
  }) {
    return showDialog<AlertDialog>(
      context: context,
      builder: (context) => AlertDialog(
        title: title,
        titleTextStyle: titleTextStyle ?? ref.textStyles.dialogTitleTextStyle,
        content: content,
        contentTextStyle:
            contentTextStyle ?? ref.textStyles.dialogContentTextStyle,
        backgroundColor: backgroundColor ?? ref.colors.surfaceColor,
        actions: actions,
      ),
    );
  }

  Future<void> showPermissionsInfoDialog(
    BuildContext context,
    WidgetRef ref, {
    VoidCallback? onConfirmPressed,
  }) async {
    await _showDialog(
      context,
      ref,
      title: Text(ref.s.permissionsInfoDialogTitle),
      content: Text(ref.s.permissionsInfoDialogContent),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: ref.colors.primaryColor,
            splashFactory: NoSplash.splashFactory,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
            onConfirmPressed?.call();
          },
          child: Text(
            ref.s.confirm,
            style: ref.textStyles.dialogButtonTextStyle,
          ),
        ),
      ],
    );
  }

  Future<void> showSignOutDialog(
    BuildContext context,
    WidgetRef ref, {
    VoidCallback? onConfirmPressed,
  }) async {
    await _showDialog(
      context,
      ref,
      title: Text(ref.s.signOutDialogTitle),
      content: Text(ref.s.signOutDialogContent),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: ref.colors.primaryColor,
            splashFactory: NoSplash.splashFactory,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child: Text(
            ref.s.no,
            style: ref.textStyles.dialogButtonTextStyle,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: ref.colors.primaryColor,
            splashFactory: NoSplash.splashFactory,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
            onConfirmPressed?.call();
          },
          child: Text(
            ref.s.yes,
            style: ref.textStyles.dialogButtonTextStyle,
          ),
        ),
      ],
    );
  }

  Future<void> showDeleteUserDialog(
    BuildContext context,
    WidgetRef ref, {
    required Function(String password) onConfirmPressed,
    required TextEditingController passwordController,
    required FocusNode passwordFocusNode,
  }) async {
    await _showDialog(
      context,
      ref,
      title: Text(ref.s.deleteUserDialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(ref.s.deleteUserDialogContent),
          const SizedBox(height: 16),
          EcoTextField(
            controller: passwordController,
            focusNode: passwordFocusNode,
            onEditingComplete: () => FocusScope.of(context).unfocus(),
            labelText: ref.s.signUpPasswordLabel,
            hintText: ref.s.signUpPasswordHintText,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.visiblePassword,
            isPassword: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: ref.colors.primaryColor,
            splashFactory: NoSplash.splashFactory,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child: Text(
            ref.s.no,
            style: ref.textStyles.dialogButtonTextStyle,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: ref.colors.primaryColor,
            splashFactory: NoSplash.splashFactory,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
            onConfirmPressed.call(passwordController.text);
          },
          child: Text(
            ref.s.yes,
            style: ref.textStyles.dialogButtonTextStyle,
          ),
        ),
      ],
    );
  }
}
