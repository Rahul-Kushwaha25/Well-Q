import 'package:flutter/foundation.dart';

@immutable
class SchoolInfo {
  const SchoolInfo({
    required this.name,
    required this.city,
    this.logoUrl = '',
  });

  final String name;
  final String city;

  /// Empty means "no logo": the header shows a neutral fallback icon.
  final String logoUrl;

  /// Demo data matching the reference screenshot. Replace with the school
  /// the user picked on the school-selection screen.
  static const SchoolInfo demo =
      SchoolInfo(name: 'Entab Learning Lab', city: 'New Delhi');

  /// Demo data matching the splash screenshot.
  static const SchoolInfo splashDemo =
      SchoolInfo(name: 'Entab International School Entabdemo', city: '');
}
