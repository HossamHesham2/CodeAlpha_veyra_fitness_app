import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:veyra/core/constants/app_assets.dart';
import 'package:veyra/core/constants/app_constants.dart';
import 'package:veyra/core/helpers/prefs_helper.dart';
import 'package:veyra/core/router/route_names.dart';
import 'package:veyra/core/utils/app_spacing.dart';
import 'package:veyra/core/widgets/d_scaffold.dart';
import 'package:veyra/core/widgets/primary_button.dart';
import 'package:veyra/features/onboarding/data/models/onboarding_model.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  int _currentIndex = 0;

  final List<OnboardingModel> lists = [
    OnboardingModel(
      lottiePath: AppLottie.weightlifting,
      title: "Welcome to ${AppConstants.appName}",
      subtitle:
          "Track your fitness, build healthy habits, and become the best version of yourself.",
    ),
    OnboardingModel(
      lottiePath: AppLottie.running,
      title: "Track Everything",
      subtitle: "Steps, workouts, calories and more. All in one place.",
    ),
    OnboardingModel(
      lottiePath: AppLottie.graph,
      title: "Analyze & Improve",
      subtitle: "Get insights, monitor your progress, and achieve your goals.",
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() async {
    if (_currentIndex < lists.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.go(RouteNames.auth);
      await PrefsHelper.instance.setBool(AppConstants.isViewed, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: lists.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = lists[index];

                  return _buildOnBoardScreen(
                    title: item.title,
                    subtitle: item.subtitle,
                    lottiePath: item.lottiePath,
                    context: context,
                  );
                },
              ),
            ),

            // Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                lists.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? colorScheme.primary
                        : colorScheme.onSurface.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),

            SizedBox(height: AppSpacing.gap20),

            PrimaryButton(
              onPressed: _nextPage,
              text: _currentIndex == lists.length - 1 ? 'Get Started' : 'Next',
            ),

            SizedBox(height: AppSpacing.gap12),
          ],
        ),
      ),
    );
  }

  Widget _buildOnBoardScreen({
    required String title,
    required String subtitle,
    required String lottiePath,
    required BuildContext context,
  }) {
    final text = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: text.headlineSmall, textAlign: TextAlign.center),

        SizedBox(height: AppSpacing.gap12),

        Text(subtitle, style: text.bodyLarge, textAlign: TextAlign.center),

        SizedBox(height: AppSpacing.gap24),

        Lottie.asset(lottiePath, fit: BoxFit.contain, width: 350.w, height: 350.h),
      ],
    );
  }
}
