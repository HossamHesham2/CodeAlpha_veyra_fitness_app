import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:veyra/core/constants/app_assets.dart';
import 'package:veyra/core/router/route_names.dart';
import 'package:veyra/core/theme/app_colors.dart';
import 'package:veyra/core/widgets/d_scaffold.dart';

class MainLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainLayout({super.key, required this.navigationShell});

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return DScaffold(
      extendBody: true,
      floatingActionButton: _FitnessFab(cs: cs, onTap: () => context.push(RouteNames.addActivity)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: _FloatingNavBar(
        currentIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        cs: cs,
      ),
      body: navigationShell,
    );
  }
}

class _FitnessFab extends StatelessWidget {
  final ColorScheme cs;
  final VoidCallback onTap;

  const _FitnessFab({required this.cs, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [cs.primary, cs.inversePrimary, cs.primary],
          ),

          border: Border.all(color: AppColors.lightSurface.withValues(alpha: 0.25), width: 2),
        ),
        child: SvgPicture.asset(
          AppSvgs.add,
          width: 30,
          colorFilter: ColorFilter.mode(AppColors.lightSurface, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class _FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final ColorScheme cs;

  const _FloatingNavBar({
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.cs,
  });

  static const _items = [
    (icon: Icons.home_outlined, selectedIcon: Icons.home, label: 'Home'),
    (icon: Icons.history_outlined, selectedIcon: Icons.history, label: 'History'),
    (icon: Icons.analytics_outlined, selectedIcon: Icons.analytics, label: 'Stats'),
    (icon: Icons.person_outline, selectedIcon: Icons.person, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      child: Container(
        height: 65.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(28.r),
          boxShadow: [
            BoxShadow(
              color: cs.onSurface.withValues(alpha: 0.08),
              blurRadius: 34.r,
              offset: Offset(0, 8.h),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_items.length, (index) {
            final item = _items[index];

            final isSelected = currentIndex == index;

            return _NavItem(
              icon: item.icon,
              selectedIcon: item.selectedIcon,
              label: item.label,
              isSelected: isSelected,
              cs: cs,
              onTap: () => onDestinationSelected(index),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final ColorScheme cs;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.cs,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(horizontal: isSelected ? 14.w : 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? cs.primary.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              size: 22.r,
              color: isSelected ? cs.primary : cs.onSurface.withValues(alpha: 0.45),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              child: isSelected
                  ? Padding(
                      padding: EdgeInsets.only(left: 6.w),
                      child: Text(
                        label,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(fontWeight: FontWeight.w600, color: cs.primary),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
