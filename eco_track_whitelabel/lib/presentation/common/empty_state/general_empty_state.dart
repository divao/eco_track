import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:eco_track_whitelabel/presentation/common/empty_state/empty_state.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/generic_error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeneralEmptyState extends ConsumerWidget {
  const GeneralEmptyState({
    required this.onTryAgain,
    required this.errorType,
    super.key,
  });

  final VoidCallback onTryAgain;
  final GenericErrorViewType errorType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (errorType) {
      GenericErrorViewType.noConnection =>
          EmptyState(
            errorText: ref.s.noInternetError,
            onTryAgainTap: onTryAgain,
          ),
      GenericErrorViewType.timeout =>
          EmptyState(
            errorText: ref.s.timeoutError,
            onTryAgainTap: onTryAgain,
          ),
      _ =>
          EmptyState(
            errorText: ref.s.genericError,
            onTryAgainTap: onTryAgain,
          ),
    };
  }
}