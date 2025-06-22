import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../utils/validators.dart';
import '../../constants/route_names.dart';
import 'forgot_password_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2)); // Mock delay

    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign in successful!'),
          backgroundColor: AppColors.success,
        ),
      );

      // Navigate to Home Page
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.all(32), // Increased horizontal padding here
              child: Row(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/Logo.png',
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Meetmax',
                        style: AppTextStyles.appBarTitle.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: const Color(0xFF4E5D78),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 226, 224, 224),
                          blurRadius: 2,
                          offset: Offset(.2, .5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'English (UK)',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFB0B7C3),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                          color: Color(0xFFB0B7C3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 600),
                    margin: const EdgeInsets.fromLTRB(
                        30, 32, 30, 180), // Wider side margins
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 32),
                          Text(
                            'Sign In',
                            style: AppTextStyles.heading3.copyWith(
                              color: const Color(0xFF4E5D78),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Welcome back, you\'ve been missed!',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: const Color(0xFF4e5d78),
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),

                          /// Social Login Buttons
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFf6f7f8),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: TextButton.icon(
                                    onPressed: () {},
                                    icon: Image.asset(
                                      'assets/icons/Google.png',
                                      width: 16,
                                      height: 16,
                                    ),
                                    label: Text(
                                      'Log in with Google',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: const Color(0xFF959faf),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Container(
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFf6f7f8),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: TextButton.icon(
                                    onPressed: () {},
                                    icon: Image.asset(
                                      'assets/icons/Apple.png',
                                      width: 16,
                                      height: 16,
                                    ),
                                    label: Text(
                                      'Log in with Apple',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: const Color(0xFF959faf),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(child: Divider(color: AppColors.border)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'OR',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF4E5D78),
                                  ),
                                ),
                              ),
                              Expanded(child: Divider(color: AppColors.border)),
                            ],
                          ),
                          const SizedBox(height: 32),

                          /// Email Field
                          CustomTextField(
                            label: '',
                            hint: 'Your Email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.email,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10), // Wider internal padding
                            prefixIcon: const Icon(
                              Icons.alternate_email,
                              color: AppColors.textHint,
                              size: 18,
                            ),
                          ),
                          const SizedBox(height: 16),

                          /// Password Field
                          CustomTextField(
                            label: '',
                            hint: 'Create Password',
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            validator: Validators.password,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: AppColors.textHint,
                              size: 20,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.textHint,
                                size: 18,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value ?? false;
                                    });
                                  },
                                  activeColor: AppColors.primary,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Remember me',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: const Color(0xFF7f8b9c),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPasswordScreen()),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Forgot Password?',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: const Color(0xFF7f8b9c),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          /// Sign In Button
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleSignIn,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF377cfe),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : Text(
                                      'Sign In',
                                      style: AppTextStyles.buttonText
                                          .copyWith(color: Colors.white),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "You haven't any account? ",
                                style: AppTextStyles.bodyMedium.copyWith(
                                  // color: const Color(0xFF7f8b9c),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RouteNames.signUp);
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                ),
                                child: Text(
                                  'Sign Up',
                                  style: AppTextStyles.link.copyWith(
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
