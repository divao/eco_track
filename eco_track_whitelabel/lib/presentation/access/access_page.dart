import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:eco_track_whitelabel/common/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccessPage extends ConsumerWidget {
  const AccessPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
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
            FilledButton(
              onPressed: () => ref.goRouter.goSignIn(),
              style: FilledButton.styleFrom(backgroundColor: ref.colors.primaryColor),
              child: Text(
                ref.s.accessPageSignInButton,
                style: ref.textStyles.filledButton,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => ref.goRouter.goSignUp(),
              child: Text(
                ref.s.accessPageSignUpButton,
                style: ref.textStyles.textButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
