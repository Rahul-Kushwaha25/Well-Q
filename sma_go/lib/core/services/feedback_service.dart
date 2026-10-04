import 'package:flutter/material.dart';

/// User feedback contract (snackbars today; toasts or banners tomorrow).
abstract interface class FeedbackService {
  void showError(String message);
  void showSuccess(String message);
  void showInfo(String message);
}

enum _FeedbackTone { error, success, info }

/// Shows floating SnackBars through the app's ScaffoldMessenger.
///
/// [navigatorKey] is the root navigator's key: its context sits below the
/// app Theme, so snackbars use the right colours.
class SnackBarFeedbackService implements FeedbackService {
  const SnackBarFeedbackService(this._navigatorKey);

  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  void showError(String message) => _show(message, _FeedbackTone.error);

  @override
  void showSuccess(String message) => _show(message, _FeedbackTone.success);

  @override
  void showInfo(String message) => _show(message, _FeedbackTone.info);

  void _show(String message, _FeedbackTone tone) {
    final context = _navigatorKey.currentContext;
    if (context == null) return;
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;

    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final (Color background, Color foreground) = switch (tone) {
      _FeedbackTone.error => (scheme.error, scheme.onError),
      _FeedbackTone.success => (scheme.secondary, scheme.onSecondary),
      _FeedbackTone.info => (scheme.inverseSurface, scheme.onInverseSurface),
    };

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: background,
          content: Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(color: foreground),
          ),
        ),
      );
  }
}
