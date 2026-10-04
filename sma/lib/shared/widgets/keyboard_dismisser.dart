import 'package:flutter/widgets.dart';

/// Unfocuses the active field when the user taps anywhere outside it,
/// matching the iOS convention. Taps on buttons and fields still work.
///
/// Usage:
/// ```dart
/// KeyboardDismisser(child: Scaffold(...))
/// ```
class KeyboardDismisser extends StatelessWidget {
  const KeyboardDismisser({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
