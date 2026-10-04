import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_spacing.dart';
import 'app_backdrop.dart';
import 'keyboard_dismisser.dart';

/// Scaffold with the shared wave background. Use it for any screen that
/// should look like the login screen.
///
/// - Background is fixed: it never resizes or moves when the keyboard opens.
/// - Content scrolls, and the focused field is brought above the keyboard.
/// - Tapping outside a field, or dragging the content, dismisses the keyboard.
/// - [header] sits on the light area, [body] on the blue wave. [topBar] floats
///   above the header, at the top.
///
/// Usage:
/// ```dart
/// BackdropScaffold(
///   topBar: AuthTopBar(onBack: controller.onBackTapped),
///   header: SchoolBrandHeader(school: school),
///   body: LoginForm(controller: controller),
/// )
/// ```
class BackdropScaffold extends StatelessWidget {
  const BackdropScaffold({
    super.key,
    required this.body,
    this.header,
    this.topBar,
  });

  final Widget body;
  final Widget? header;
  final Widget? topBar;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      child: KeyboardDismisser(
        child: Scaffold(
          // The background must stay put; we pad the scroll view ourselves.
          resizeToAvoidBottomInset: false,
          body: Stack(
            fit: StackFit.expand,
            children: [
              const AppBackdrop(),
              LayoutBuilder(
                builder: (context, constraints) => _BackdropContent(
                  screenHeight: constraints.maxHeight,
                  header: header,
                  topBar: topBar,
                  body: body,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackdropContent extends StatelessWidget {
  const _BackdropContent({
    required this.screenHeight,
    required this.body,
    this.header,
    this.topBar,
  });

  final double screenHeight;
  final Widget body;
  final Widget? header;
  final Widget? topBar;

  @override
  Widget build(BuildContext context) {
    // Only this widget depends on the keyboard; the painted background above
    // it is untouched while the keyboard animates.
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;
    final safe = MediaQuery.viewPaddingOf(context);
    final headerHeight = screenHeight * AppSizes.backdropWaveTop;

    return Padding(
      padding: EdgeInsets.only(bottom: keyboard),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: screenHeight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: headerHeight,
                child: Stack(
                  children: [
                    if (header != null)
                      Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.only(top: safe.top).add(
                            AppSpacing.screenPadding,
                          ),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: AppSizes.contentMaxWidth,
                                ),
                                child: header,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (topBar != null)
                      Positioned(
                        top: safe.top,
                        left: 0,
                        right: 0,
                        child: topBar!,
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: AppSpacing.xl,
                  bottom: safe.bottom + AppSpacing.lg,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: AppSizes.contentMaxWidth,
                    ),
                    child: Padding(
                      padding: AppSpacing.screenPadding,
                      child: body,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
