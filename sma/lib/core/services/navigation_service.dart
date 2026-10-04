import 'package:get/get.dart';

/// Navigation contract used by controllers. Swap the implementation
/// (go_router, Navigator 2.0, ...) without touching any screen.
abstract interface class NavigationService {
  Future<void> push(String route, {Object? arguments});
  Future<void> replaceAll(String route, {Object? arguments});
  void back();
  bool get canGoBack;
}

/// GetX-backed implementation. This is the ONLY place Get navigation is used.
class GetNavigationService implements NavigationService {
  const GetNavigationService();

  @override
  Future<void> push(String route, {Object? arguments}) async {
    await Get.toNamed<void>(route, arguments: arguments);
  }

  @override
  Future<void> replaceAll(String route, {Object? arguments}) async {
    await Get.offAllNamed<void>(route, arguments: arguments);
  }

  @override
  void back() => Get.back<void>();

  @override
  bool get canGoBack => Get.key.currentState?.canPop() ?? false;
}
