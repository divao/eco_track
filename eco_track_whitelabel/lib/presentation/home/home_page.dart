import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
  });

  static Widget create() => Consumer(
        builder: (context, ref, child) {
          return const HomePage();
        },
      );

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: ref.colors.primaryColor,
      ),
      body: Center(
        child: Text(
          ref.s.appTitle,
          style: ref.textStyles.profileInfo,
        ),
      ),
    );
  }
}
