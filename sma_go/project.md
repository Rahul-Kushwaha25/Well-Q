# Project Brief for AI Agents

Read this file fully before writing or changing any code in this repository.

## 1. What this project is

A Flutter rebuild of an existing **school management mobile app**. The original app's source code and API documentation are **not available**. The only reference is a set of **screenshots**.

- Roles (separate logins): **Staff, Student, Principal**
- The app is heavily API-dependent and uses notifications, maps, video playback and resource downloads (these are not built yet).
- Goal: the same or better UI than the screenshots, with code that is **changeable, scalable and reusable across screens**.

### Ground rules about the source of truth
- Screenshots are the only UI reference. If a detail is unclear, **state your assumption** in your reply. Do not invent features, fields, or API behavior.
- No API contract exists. Do not guess endpoints or response shapes. Work against the repository interfaces in `features/<feature>/data/` and keep the fake implementations clearly marked as stand-ins.

## 2. Tech constraints (non-negotiable)

| Area | Rule |
|---|---|
| Framework | Flutter (stable), Dart 3, null safety, Material 3 |
| State management | **GetX for state only**: `GetxController`, `Obx`, `GetBuilder`, `.obs`, and `Get.put/find` for dependency lookup. No `GetMaterialApp`, `GetPage` or GetX Bindings |
| Routing | **go_router** (`MaterialApp.router`). Routes are defined in `core/routes/app_router.dart` |
| Navigation and feedback | **Never** call `context.go/push`, `GoRouter`, `Navigator`, `ScaffoldMessenger` or any `Get.to/snackbar/dialog` inside widgets or controllers. Use `NavigationService` and `FeedbackService`. Router and messenger calls exist only inside the service implementations |
| Structure | Screen-based MVC: each screen has a screen file, a controller, and a page (route entry that creates the controller) |
| Styling | No hardcoded colors, font sizes, paddings, radii, sizes, or user-facing strings inside widgets. Use the tokens (section 4) |
| Widgets | Small, stateless where possible, `const` constructors |
| Dependencies | Keep minimal. Currently `get` (state) and `go_router` (routing) |

## 3. Folder structure

```
lib/
  main.dart                      MaterialApp.router, theme, dependency init
  core/
    di/                          app_dependencies.dart (app-wide singletons), controller_scope.dart (per-screen controller lifecycle)
    constants/app_strings.dart   ALL user-facing text
    routes/                      app_routes.dart (paths), app_router.dart (go_router config)
    services/                    navigation_service.dart, feedback_service.dart
    theme/                       design tokens + ThemeData (section 4)
    utils/validators.dart        Form validators + input formatters
  shared/widgets/                Generic, reusable, screen-agnostic widgets
  features/
    splash/                      splash_screen, controller, page, widgets/ (painted sky + hill)
    auth/
      data/                      Models + repository interfaces (+ fake impls)
      widgets/                   Widgets used only by auth screens
      login/                     login_screen, login_controller, login_page, login_form
      otp/                       otp_screen, otp_controller, otp_page, otp_form
```

New features follow `features/<feature>/{data,widgets,<screen>/}`. A widget used by two or more features moves to `shared/widgets/`.

## 4. Design system

All values live in `core/theme/`. **To re-skin per school or brand, edit only these token files.**

| File | Contains |
|---|---|
| `app_colors.dart` | `AppPalette` (all colors for one brightness) and the two instances `AppColors.light` / `AppColors.dark` |
| `app_backdrop_theme.dart` | `ThemeExtension` with the colors of the wave background and of text placed on it (`onCircle`, `onWave`). Read it with `AppBackdropTheme.of(context)` |
| `app_text_styles.dart` | Type scale; `fontFamily` is set here |
| `app_spacing.dart` | `xxs, xs, sm, md, lg, xl, xxl` (2 to 48), `screenHorizontal`, `screenPadding` |
| `app_radius.dart` | `sm, md, lg, xl, pill` plus ready `BorderRadius` constants (`smAll`, `pillAll`, ...) |
| `app_sizes.dart` | Touch target (48), button height, icon sizes, logo, max content width, border widths, `backdropWaveTop` |
| `app_theme.dart` | Builds light and dark `ThemeData` from the palette (`ColorScheme`, input decoration, snackbar theme) |
| `app_splash_colors.dart` | Colors of the splash illustration (light/dark). Read with `AppSplashColors.of(context)` |
| `app_motion.dart` | Animation durations, intervals and end values (splash timing, exit zoom scale) |

### How to style in a widget
- Colors: `Theme.of(context).colorScheme.*` or `AppBackdropTheme.of(context)`. Never `Color(0xFF...)` or `Colors.red`. (`Colors.transparent` is acceptable.)
- Text: `Theme.of(context).textTheme.*`, with `copyWith(color: ...)` taking its color from the theme.
- Spacing, radius, sizes: `AppSpacing`, `AppRadius`, `AppSizes`.
- Strings: `AppStrings`. Add new constants there.
- Every interactive element is at least 48x48 dp.
- Support text scaling (avoid fixed heights around text) and add `Semantics`/`tooltip` where the visual is not self-describing.
- Light and dark mode must both work. Do not use a color in a widget that exists only in one palette.

## 5. Shared widgets (`shared/widgets/`)

Each file has a usage example in its doc comment. Prefer extending these over creating screen-specific copies. A widget with more than about 6 parameters should group options into a small config class (see `AppTextFieldConfig`).

| Widget | Purpose |
|---|---|
| `AppBackdrop` | Painted wave background (green corner circles, blue wave). Theme-driven, scales to any screen |
| `BackdropScaffold` | Scaffold with the backdrop, keyboard-safe scrolling, tap-outside dismissal. Slots: `topBar`, `header` (light area), `body` (on the blue wave) |
| `KeyboardDismisser` | Unfocuses the active field on any outside tap |
| `AppButton` | Variants `primary, secondary, text, destructive`; loading state; optional leading or trailing icon |
| `AppTextField` | Filled field with prefix icon/label, password toggle, validator, error color override |
| `AppOtpField` | OTP digit boxes backed by one invisible text field (paste, backspace and SMS autofill work). Caller owns controller and focus node |
| `SchoolLogo` | School logo from a URL with a fallback icon |

### Not built yet (planned from the original brief)
`AppCard`, `AppListTile`, `AppAppBar`, `AppBottomNav` (items passed as data per role), `AppChip`/`FilterChips`, `AppTabBar`, `SectionHeader`, `StatCard`, `InfoRow`, `AppAvatar`, `StatusBadge`, `AppBottomSheet`, `AppDialog`. Success, warning and info color tokens will be added together with `StatusBadge`.

Build these only when a screenshot needs them, and do not invent features beyond what the screenshots show.

## 6. Key behaviors to preserve

### Backdrop and keyboard (login and any screen using `BackdropScaffold`)
- `Scaffold(resizeToAvoidBottomInset: false)`, so the background never resizes or shifts.
- The painted background is a separate `const AppBackdrop()` that does not depend on `MediaQuery`, so it does not rebuild or repaint while the keyboard animates.
- Only the content layer reads `MediaQuery.viewInsetsOf` and pads the scroll view by the keyboard height. The focused field scrolls into view automatically.
- Header height is `screenHeight * AppSizes.backdropWaveTop`, which matches the wave position in `AppBackdrop`. If you change the wave geometry, keep both in sync through that token.
- `KeyboardDismisser` (outside tap) and `ScrollViewKeyboardDismissBehavior.onDrag` provide the iOS-style dismissal. Do not add per-field `onTapOutside` handlers.

### Services (swappable by design)
- `NavigationService`: `push`, `replaceAll`, `back`, `canGoBack`. Default impl `GoRouterNavigationService` is the only place go_router navigation is called. `arguments` are passed as the route's `extra`, which is lost on web reload and deep links, so read it defensively in `app_router.dart`.
- `FeedbackService`: `showError`, `showSuccess`, `showInfo`. Default impl shows floating SnackBars through `ScaffoldMessenger`.
- Both are registered in `AppDependencies.init()` (called in `main`) and injected into controllers by each screen's `*Page`.
- `ControllerScope<T>` creates the controller with `Get.put` when the screen enters the tree and `Get.delete` when it leaves, so `onClose` runs and controllers are disposed safely after the exit transition.

## 7. How to add a new screen (checklist)

1. Create `features/<feature>/<screen>/` with `<screen>_screen.dart`, `<screen>_controller.dart`, `<screen>_page.dart`.
2. Controller: extends `GetxController`; takes dependencies through the constructor (repositories, `NavigationService`, `FeedbackService`); exposes state as `.obs`; owns and disposes `TextEditingController`/`FocusNode` in `onClose`; contains **no** `BuildContext`, no widgets, no direct Get navigation or snackbars.
3. Page: a `StatelessWidget` that returns `ControllerScope<Controller>(create: () => Controller(...Get.find<...>()), child: const Screen())`. It may take route arguments as constructor parameters.
4. Screen: `GetView<Controller>`; build UI from shared widgets and tokens; wrap only the parts that change in `Obx`.
5. Add the path to `AppRoutes` and a `GoRoute` that builds the page to `AppRouter.router`. Read `state.extra` defensively.
6. Add every new string to `AppStrings`.
7. Use `BackdropScaffold` for screens that share the login look; otherwise use a normal `Scaffold` plus the shared widgets.
8. Verify in light and dark mode, with large text scale, and (for forms) with the keyboard open.

## 8. Current status

Done:
- Design tokens and light/dark theme
- `AppBackdrop`, `BackdropScaffold`, `KeyboardDismisser`, `AppButton`, `AppTextField`
- Login screen (logo, school name and city, mobile + password, forgot password, login button, need help, change school, back)
- OTP screen: reuses the login `BackdropScaffold`, `AuthTopBar` and `SchoolBrandHeader`. Assumes a 6-digit code and a 30 s resend countdown (`OtpController.otpLength`, `resendSeconds`). Verifies automatically on the last digit. Open it with `navigation.push(AppRoutes.otp, arguments: OtpArguments(school: ..., mobile: ...))`. Nothing navigates to it yet because the screenshots do not show the login flow reaching it
- Splash screen: sky and hill are `CustomPainter` approximations of the screenshot artwork (not image assets). One `AnimationController` drives a hill slide-up and a logo fade-in, then a logo zoom-out + fade before continuing to login. Only transform/opacity animations are used and each painting sits in a `RepaintBoundary`, so it is painted once. Timing lives in `AppMotion`

Stand-ins that need real implementations:
- `FakeAuthRepository` (waits 1.2 s, always succeeds). Replace when the API is known.
- `SchoolInfo.demo` (login) and `SchoolInfo.splashDemo` (splash) are demo data from two different screenshots. Replace with the school chosen on the school-selection screen. `SchoolInfo.logoUrl` is empty, so a fallback icon shows.
- The splash always continues to login. Session and selected-school checks belong in `SplashController._run()`.
- After a successful login the controller only shows a success snackbar. Role-based home navigation is added when the home screens exist.
- Routes `forgotPassword`, `changeSchool`, `help` are declared but have **no screens yet**.

Not started: all other screens, notifications, maps, video playback, downloads, networking layer, local storage.

## 9. Assumptions made from the screenshots (verify when more screenshots arrive)

- Colors are best estimates (blue about `#0070C9`, green about `#6CD58B`).
- Login ID is a 10-digit mobile number, optionally followed by `#<number>` (the screenshot shows `7878787878#1`). Validation lives in `core/utils/validators.dart`.
- Country code `+91` is fixed text.
- The wave and circle shapes are approximated in `app_backdrop.dart` and may need tuning.
- Improvements over the original (intentional): dark text on light-green surfaces for contrast, 48 dp touch targets, a password visibility toggle, white error text on the blue area.

## 10. Rules for AI agents working here

Do:
- Match existing patterns and naming before adding new ones.
- Output complete, compilable files with their path. No "rest of code" placeholders.
- State assumptions and list any new `pubspec.yaml` dependency with a reason.
- Ask for a screenshot when a screen's layout is needed but not provided.

Don't:
- Hardcode colors, sizes, spacing, radii or strings in widgets.
- Call go_router, `Navigator`, `ScaffoldMessenger` or any `Get.to/snackbar/dialog/back` outside the service implementations.
- Put business logic or `BuildContext` in controllers, or UI code in repositories.
- Create a screen-specific widget when a generic parameterized one can serve.
- Invent API endpoints, response fields, roles' permissions or features that are not visible in the screenshots.
- Add packages without need.

## 11. Verification

I could not compile this project in the environment that generated it. After any change run:

```
flutter pub get
flutter analyze
flutter test   # when tests exist
```

and fix reported issues before reporting the task as done.
