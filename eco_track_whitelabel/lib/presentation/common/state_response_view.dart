import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:eco_track_whitelabel/presentation/common/empty_state/general_empty_state.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/generic_error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateResponseView<Loading, Error, Success>
    extends ConsumerWidget {
  StateResponseView({
    required this.state,
    required this.successWidgetBuilder,
    required this.onTryAgainTap,
    this.loadingWidgetBuilder,
    this.errorWidgetBuilder,
    super.key,
  })  : assert(Loading != dynamic),
        assert(Error != dynamic),
        assert(Success != dynamic);

  final dynamic state;
  final Widget Function(BuildContext context, Success success)
  successWidgetBuilder;
  final Widget Function(BuildContext context, Loading? loading)?
  loadingWidgetBuilder;
  final Widget Function(
      BuildContext context,
      Error? error,
      VoidCallback onTryAgain,
      )? errorWidgetBuilder;
  final VoidCallback onTryAgainTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (state == null || state is Loading) {
      if (loadingWidgetBuilder != null) {
        return loadingWidgetBuilder!(context, state as Loading?);
      }
      return Center(
        child: CircularProgressIndicator(
          color: ref.colors.primaryColor,
        ),
      );
    }

    if (state is Error) {
      if (errorWidgetBuilder != null) {
        return errorWidgetBuilder!(context, state, onTryAgainTap);
      }
      return GeneralEmptyState(
        onTryAgain: onTryAgainTap,
        errorType: state is GenericErrorView
            ? state.type
            : GenericErrorViewType.unexpected,
      );
    }

    if (state is Success) {
      return successWidgetBuilder(context, state);
    }
    throw UnknownStateTypeException();
  }
}

class UnknownStateTypeException implements Exception {}
