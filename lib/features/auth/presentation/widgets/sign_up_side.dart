import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veyra/core/constants/app_enums.dart';
import 'package:veyra/core/utils/app_spacing.dart';
import 'package:veyra/core/utils/validators.dart';
import 'package:veyra/core/widgets/custom_text_field.dart';
import 'package:veyra/core/widgets/primary_button.dart';
import 'package:veyra/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:veyra/features/auth/presentation/bloc/auth_event.dart';
import 'package:veyra/features/auth/presentation/bloc/auth_state.dart';
import 'package:veyra/features/auth/presentation/widgets/social_widget.dart';
import 'package:veyra/core/extensions/color_schema_extension.dart';

class SignUpSide extends StatefulWidget {
  final VoidCallback onLogin;

  const SignUpSide({super.key, required this.onLogin});

  @override
  State<SignUpSide> createState() => SignUpSideState();
}

class SignUpSideState extends State<SignUpSide> {
  bool obscureText = true;
  bool isLoading = false;
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final cs = theme.colorScheme;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.signUpRequest == AppRequests.loading) {
          setState(() {
            isLoading = true;
          });
        }
        if (state.signUpRequest == AppRequests.error) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.signUpFailure?.errorMessage ?? 'Something went wrong.',
                style: text.labelLarge?.copyWith(color: cs.onError),
              ),
              backgroundColor: cs.error,
            ),
          );
        }
        if (state.signUpRequest == AppRequests.success) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Sign Up Successfully ",
                style: text.labelLarge?.copyWith(color: cs.onSuccess),
              ),
              backgroundColor: cs.success,
            ),
          );
          if (!mounted) return;
          widget.onLogin();
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
                      Text("Create Account", style: text.headlineSmall),
                      SizedBox(height: AppSpacing.gap4),
                      Text(
                        "Start your journey with Veyra.",
                        style: text.titleMedium?.copyWith(color: cs.subtitleColor),
                      ),
                      SizedBox(height: AppSpacing.gap12),
                      CustomTextField(
                        label: "Full Name",
                        hintText: "Hossam Hesham",
                        keyboardType: TextInputType.name,
                        validator: AppValidators.fullName,
                        controller: _fullNameController,
                      ),
                      SizedBox(height: AppSpacing.gap12),
                      CustomTextField(
                        label: "Email",
                        hintText: "example@mail.com",
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: AppValidators.email,
                      ),
                      SizedBox(height: AppSpacing.gap24),
                      CustomTextField(
                        label: "Password",
                        hintText: "********",
                        obscureText: obscureText,
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
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
                      SizedBox(height: AppSpacing.gap16),
                      PrimaryButton(
                        text: "Sign Up",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              SignUpEvent(
                                fullName: _fullNameController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                              ),
                            );
                          }
                        },
                        isLoading: isLoading,
                      ),
                      SocialWidget(),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: "Already have an account ? ", style: text.bodyLarge),
                                TextSpan(
                                  text: "Sign In",
                                  style: text.bodyLarge?.copyWith(
                                    color: cs.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()..onTap = widget.onLogin,
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
