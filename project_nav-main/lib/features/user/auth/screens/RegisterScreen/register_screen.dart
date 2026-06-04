// features/user/auth/screens/RegisterScreen/register_screen.dart

import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/widgets/buttons/primary_button.dart';
import '../../../../../core/navigation/user_tab_navigation.dart';
import '../../widgets/auth_banner.dart';
import '../../widgets/auth_divider.dart';
import '../../widgets/auth_footer.dart';
import '../../widgets/auth_header.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/password_text_field.dart';
import '../../widgets/social_login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

final TextEditingController emailController = TextEditingController();

final TextEditingController passwordController = TextEditingController();

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthBanner(
                imageUrl:
                    'https://images.unsplash.com/photo-1529139574466-a303027c1d8b',
              ),
              const SizedBox(height: AppSpacing.xl),
              const AuthHeader(
                title: 'Create Account',
                subtitle: 'Tạo tài khoản mới để bắt đầu',
              ),
              const SizedBox(height: AppSpacing.xl),
              AuthTextField(
                controller: emailController,
                hintText: 'Email',
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: AppSpacing.lg),

              const SizedBox(height: AppSpacing.lg),
              const AuthTextField(
                hintText: 'Số điện thoại',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: AppSpacing.lg),
              PasswordTextField(controller: passwordController),
              const SizedBox(height: AppSpacing.lg),

              const SizedBox(height: AppSpacing.xl),
              // Tạo tài khoản → UserTabNavigation
              PrimaryButton(
                tieuDe: 'Tạo tài khoản',
                onPressed: () async {
                  if (emailController.text.trim().isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Vui lòng nhập đầy đủ thông tin'),
                      ),
                    );

                    return;
                  }

                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đăng ký thành công')),
                    );

                    Navigator.pop(context);
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.message ?? 'Lỗi đăng ký')),
                    );
                  }
                },
              ),
              const SizedBox(height: AppSpacing.xl),
              const AuthDivider(),
              const SizedBox(height: AppSpacing.xl),
              SocialLoginButton(
                title: 'Đăng ký với Google',
                imagePath: 'assets/icons/google.png',
                onPressed: () {},
              ),
              const SizedBox(height: AppSpacing.lg),
              SocialLoginButton(
                title: 'Đăng ký với Facebook',
                imagePath: 'assets/icons/facebook.png',
                onPressed: () {},
              ),
              const SizedBox(height: AppSpacing.xl),
              // Footer → back to Login
              AuthFooter(
                text: 'Đã có tài khoản? ',
                actionText: 'Đăng nhập',
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
