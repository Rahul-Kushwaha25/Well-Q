import 'package:go_router/go_router.dart';

/// Navigation contract used by controllers. Controllers never import a
/// router package, so the implementation can change without touching screens.
abstract interface class NavigationService {
  Future<void> push(String route, {Object? arguments});
  Future<void> replaceAll(String route, {Object? arguments});
  void back();
  bool get canGoBack;
}

/// go_router implementation. [arguments] travel as the route's `extra`.
class GoRouterNavigationService implements NavigationService {
  const GoRouterNavigationService(this._router);

  final GoRouter _router;

  @override
  Future<void> push(String route, {Object? arguments}) async {
    await _router.push<void>(route, extra: arguments);
  }

  @override
  Future<void> replaceAll(String route, {Object? arguments}) async {
    _router.go(route, extra: arguments);
  }

  @override
  void back() {
    if (_router.canPop()) _router.pop();
  }

  @override
  bool get canGoBack => _router.canPop();
}
