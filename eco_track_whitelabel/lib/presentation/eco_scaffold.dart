import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EcoScaffold extends ConsumerWidget {
  const EcoScaffold({
    required this.body,
    this.title,
    super.key,
  });

  final Widget body;
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: title != null
            ? AppBar(
                title: Text(
                  title!,
                  style: ref.textStyles.appBarTitle,
                ),
                backgroundColor: ref.colors.appBarBackgroundColor,
                iconTheme: IconThemeData(color: ref.colors.appBarContentColor),
              )
            : null,
        backgroundColor: ref.colors.surfaceColor,
        body: body,
      );
}
