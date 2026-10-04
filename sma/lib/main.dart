import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/bindings/app_bindings.dart';
import 'core/constants/app_strings.dart';
import 'core/routes/app_pages.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SchoolApp());
}

class SchoolApp extends StatelessWidget {
  const SchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialBinding: AppBindings(),
      initialRoute: AppPages.initial,
      getPages: AppPages.pages,
    );
  }
}
