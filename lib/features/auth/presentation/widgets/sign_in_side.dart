import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veyra/core/constants/app_constants.dart';
import 'package:veyra/core/constants/app_enums.dart';
import 'package:veyra/core/extensions/color_schema_extension.dart';
import 'package:veyra/core/helpers/prefs_helper.dart';
import 'package:veyra/core/router/route_names.dart';
import 'package:veyra/core/theme/app_colors.dart';
import 'package:veyra/core/theme/app_text_theme.dart';
import 'package:veyra/core/utils/app_spacing.dart';
import 'package:veyra/core/utils/validators.dart';
import 'package:veyra/core/widgets/custom_text_field.dart';
import 'package:veyra/core/widgets/primary_button.dart';
import 'package:veyra/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:veyra/features/auth/presentation/bloc/auth_event.dart';
import 'package:veyra/features/auth/presentation/bloc/auth_state.dart';
import 'package:veyra/features/auth/presentation/widgets/social_widget.dart';

class SignInSide extends StatefulWidget {
  final VoidCallback onSignUp;

  const SignInSide({super.key, required this.onSignUp});

  @override
  State<SignInSide> createState() => SignInSideState();
}

class SignInSideState extends State<SignInSide> {
  bool obscureText = true;
  bool isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final cs = theme.colorScheme;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state.signInRequest == AppRequests.loading) {
          setState(() {
            isLoading = true;
          });
        }
        if (state.signInRequest == AppRequests.error) {
          setState(() {
            isLoading = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.signInFailure?.errorMessage ?? 'Something went wrong.',
                style: text.labelLarge?.copyWith(color: cs.onError),
              ),
              backgroundColor: cs.error,
            ),
          );
        }
        if (state.signInRequest == AppRequests.success) {
          setState(() {
            isLoading = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Sign In Successfully ",
                style: text.labelLarge?.copyWith(color: cs.onSuccess),
              ),
              backgroundColor: cs.success,
            ),
          );
          await PrefsHelper.instance.setBool(AppConstants.isLoggedIn, true);
          if (!mounted) return;
          context.go(RouteNames.home);
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;

          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: keyboardHeight),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight - keyboardHeight),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome Back 👋", style: text.headlineSmall),
                      SizedBox(height: AppSpacing.gap4),
                      Text(
                        "Let's continue your fitness journey.",
                        style: text.titleMedium?.copyWith(color: cs.subtitleColor),
                      ),
                      SizedBox(height: AppSpacing.gap12),
                      CustomTextField(
                        label: "Email",
                        hintText: "example@mail.com",
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: AppValidators.email,
                      ),
                      SizedBox(height: AppSpacing.gap24),
                      CustomTextField(
                        label: "Password",
                        hintText: "********",
                        obscureText: obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        validator: AppValidators.password,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: Icon(
                            obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSpacing.gap8),
                      TextButton(onPressed: () {}, child: Text("Forget password ?")),
                      SizedBox(height: AppSpacing.gap8),
                      PrimaryButton(
                        text: "Sign in",
                        isLoading: isLoading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              SignInEvent(
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                              ),
                            );
                          }
                        },
                      ),
                      SocialWidget(),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: "Don't have an account ? ", style: text.bodyLarge),
                                TextSpan(
                                  text: "Sign Up",
                                  style: text.bodyLarge?.copyWith(
                                    color: cs.primary,
                                    fontWeight: FontWeight.bold,
                                  ),

                                  recognizer: TapGestureRecognizer()..onTap = widget.onSignUp,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
