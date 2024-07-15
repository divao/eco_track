import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:eco_track_whitelabel/common/routing.dart';
import 'package:eco_track_whitelabel/presentation/common/eco_button.dart';
import 'package:eco_track_whitelabel/presentation/eco_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccessPage extends ConsumerWidget {
  const AccessPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: EcoScaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  ref.assets.logoImage,
                  height: 140,
                ),
                const SizedBox(height: 36),
                EcoButton(
                  onPressed: () => ref.goRouter.goSignIn(),
                  text: ref.s.accessPageSignInButton,
                ),
                const SizedBox(height: 8),
                EcoButton(
                  onPressed: () => ref.goRouter.goSignUp(),
                  buttonType: ButtonType.text,
                  text: ref.s.accessPageSignUpButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
