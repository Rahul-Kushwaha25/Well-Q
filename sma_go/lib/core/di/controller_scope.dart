import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

/// Creates a screen's GetX controller when the screen enters the tree and
/// deletes it (calling `onClose`) when the screen leaves. This replaces
/// per-screen GetX Bindings now that go_router owns the routes.
///
/// Usage (inside a `*_page.dart`):
/// ```dart
/// ControllerScope<LoginController>(
///   create: () => LoginController(...),
///   child: const LoginScreen(),
/// )
/// ```
class ControllerScope<T extends GetxController> extends StatefulWidget {
  const ControllerScope({
    super.key,
    required this.create,
    required this.child,
  });

  final T Function() create;
  final Widget child;

  @override
  State<ControllerScope<T>> createState() => _ControllerScopeState<T>();
}

class _ControllerScopeState<T extends GetxController>
    extends State<ControllerScope<T>> {
  @override
  void initState() {
    super.initState();
    Get.put<T>(widget.create());
  }

  @override
  void dispose() {
    Get.delete<T>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
