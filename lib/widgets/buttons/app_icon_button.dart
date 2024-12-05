import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppIconButton extends ConsumerWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30),
        child: Ink(
          padding: const EdgeInsets.all(2),
          child: icon,
        ),
      ),
    );
  }
}
