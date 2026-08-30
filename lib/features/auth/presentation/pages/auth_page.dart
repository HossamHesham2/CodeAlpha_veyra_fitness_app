import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veyra/core/constants/app_assets.dart';
import 'package:veyra/core/di/injection.dart';
import 'package:veyra/core/theme/app_colors.dart';
import 'package:veyra/core/utils/app_spacing.dart';
import 'package:veyra/core/widgets/custom_text_field.dart';
import 'package:veyra/core/widgets/d_scaffold.dart';
import 'package:veyra/core/widgets/primary_button.dart';
import 'package:veyra/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:veyra/features/auth/presentation/widgets/sign_in_side.dart';
import 'package:veyra/features/auth/presentation/widgets/sign_up_side.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  void _showLogin() {
    setState(() {
      isLogin = true;
    });
  }

  void _showRegister() {
    setState(() {
      isLogin = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: DScaffold(
        resizeToAvoidBottomInset: false,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: isLogin
              ? SignInSide(key: const ValueKey('login'), onSignUp: _showRegister)
              : SignUpSide(key: const ValueKey('register'), onLogin: _showLogin),
        ),
      ),
    );
  }
}
