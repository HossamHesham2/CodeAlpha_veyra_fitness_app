import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:veyra/core/constants/app_assets.dart';
import 'package:veyra/core/di/injection.dart';
import 'package:veyra/core/router/route_names.dart';
import 'package:veyra/core/widgets/d_scaffold.dart';
import 'package:veyra/features/home/presentation/bloc/home_bloc.dart';
import 'package:veyra/features/home/presentation/bloc/home_event.dart';

class MainLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainLayout({super.key, required this.navigationShell});

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (context) => getIt<HomeBloc>()..add(GetActivitiesEvent()),
      child: Builder(
        builder: (context) {
          return DScaffold(
            bottomNavigationBar: _BottomNavBar(
              currentIndex: navigationShell.currentIndex,
              onDestinationSelected: _onDestinationSelected,
              cs: cs,
              onFabTap: () async {
                final result = await context.push<bool>(RouteNames.addActivity);

                if (result == true && context.mounted) {
                  context.read<HomeBloc>().add(GetActivitiesEvent());
                }
              },
            ),
            body: navigationShell,
          );
        },
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final ColorScheme cs;
  final VoidCallback onFabTap;

  const _BottomNavBar({
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.cs,
    required this.onFabTap,
  });

  static const _items = [
    (icon: Icons.home_rounded, label: 'Home'),
    (icon: Icons.history_rounded, label: 'History'),
    (icon: Icons.analytics_rounded, label: 'Stats'),
    (icon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      child: Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: cs.onSurface.withValues(alpha: 0.08),
              blurRadius: 20.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _NavItem(
                icon: _items[0].icon,
                label: _items[0].label,
                isSelected: currentIndex == 0,
                cs: cs,
                onTap: () => onDestinationSelected(0),
              ),
            ),

            Expanded(
              child: _NavItem(
                icon: _items[1].icon,
                label: _items[1].label,
                isSelected: currentIndex == 1,
                cs: cs,
                onTap: () => onDestinationSelected(1),
              ),
            ),

            Expanded(
              child: _CenterFab(cs: cs, onTap: onFabTap),
            ),

            Expanded(
              child: _NavItem(
                icon: _items[2].icon,
                label: _items[2].label,
                isSelected: currentIndex == 2,
                cs: cs,
                onTap: () => onDestinationSelected(2),
              ),
            ),

            Expanded(
              child: _NavItem(
                icon: _items[3].icon,
                label: _items[3].label,
                isSelected: currentIndex == 3,
                cs: cs,
                onTap: () => onDestinationSelected(3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CenterFab extends StatelessWidget {
  final ColorScheme cs;
  final VoidCallback onTap;

  const _CenterFab({required this.cs, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 48.r,
          height: 48.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [cs.primary, cs.inversePrimary],
            ),
            boxShadow: [
              BoxShadow(
                color: cs.primary.withValues(alpha: 0.25),
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              AppSvgs.add,
              width: 22.r,
              height: 22.r,
              colorFilter: ColorFilter.mode(cs.onPrimary, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final ColorScheme cs;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.cs,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? cs.primary : cs.onSurface.withValues(alpha: 0.45);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 23.r, color: color),
          SizedBox(height: 3.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
