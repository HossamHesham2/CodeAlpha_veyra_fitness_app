import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:veyra/core/constants/app_assets.dart';
import 'package:veyra/core/constants/app_constants.dart';
import 'package:veyra/core/helpers/prefs_helper.dart';
import 'package:veyra/core/router/route_names.dart';
import 'package:veyra/core/utils/app_spacing.dart';
import 'package:veyra/core/widgets/d_scaffold.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(seconds: 3);

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: _duration);

    _startSplash();
  }

  Future<void> _startSplash() async {
    await _controller.forward();

    if (!mounted) return;

    final prefs = PrefsHelper.instance;

    final isLoggedIn = prefs.getBool(AppConstants.isLoggedIn) ?? false;
    final isViewed = prefs.getBool(AppConstants.isViewed) ?? false;

    if (!isViewed) {
      context.go(RouteNames.onboarding);
      return;
    }

    if (isLoggedIn) {
      context.go(RouteNames.home);
      return;
    }

    context.go(RouteNames.auth);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return DScaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppImages.logo, width: 200.r),

                Text(
                  AppConstants.appName.toUpperCase(),
                  style: textTheme.headlineLarge?.copyWith(letterSpacing: 10),
                ),

                SizedBox(height: AppSpacing.gap12),

                Text(
                  'Your fitness. Your progress',
                  style: textTheme.titleSmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.gap48),
              child: SizedBox(
                width: 75.w,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      value: _controller.value,
                      color: colorScheme.onSurface,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
