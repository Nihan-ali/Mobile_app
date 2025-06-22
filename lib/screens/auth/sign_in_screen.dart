import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import '../../widgets/custom_text_field.dart';
import '../../utils/validators.dart';
import '../../constants/route_names.dart';
import 'forgot_password_screen.dart';
import '../../constants/mock_data.dart';
import '../../services/auth_service.dart';

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
  String _selectedLanguage = mockLanguages.first;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Simulated sign-in handler (mock API)
  Future<void> _handleSignIn() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() => _isLoading = true);

  final authService = AuthService();
  final success = await authService.login(
    _emailController.text,
    _passwordController.text,
  );

  setState(() => _isLoading = false);

  if (!mounted) return;

  if (success) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sign in successful!'),
        backgroundColor: AppColors.success,
      ),
    );
    Navigator.pushReplacementNamed(context, '/home');
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invalid email or password'),
        backgroundColor: AppColors.error,
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // App header
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/icons/Logo.png',
                          width: 16, height: 16),
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 226, 224, 224),
                          blurRadius: 2,
                          offset: Offset(0.2, 0.5),
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedLanguage,
                        icon: const Icon(Icons.keyboard_arrow_down,
                            size: 16, color: Color(0xFFB0B7C3)),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFB0B7C3),
                        ),
                        items: mockLanguages.map((lang) {
                          return DropdownMenuItem<String>(
                            value: lang,
                            child: Text(lang),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedLanguage = newValue!;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Form content
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    margin: const EdgeInsets.fromLTRB(30, 32, 30, 180),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            'Sign In',
                            style: AppTextStyles.heading3
                                .copyWith(color: const Color(0xFF4E5D78)),
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

                          // Social login
                          Row(
                            children: [
                              Expanded(
                                child: _buildSocialButton(
                                  'Log in with Google',
                                  'assets/icons/Google.png',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildSocialButton(
                                  'Log in with Apple',
                                  'assets/icons/Apple.png',
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),
                          _buildDivider(),

                          const SizedBox(height: 32),

                          // Email
                          CustomTextField(
                            hint: 'Your Email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.email,
                            prefixIcon: const Icon(Icons.alternate_email,
                                color: Color.fromARGB(255, 156, 163, 175),
                                size: 18),
                          ),
                          const SizedBox(height: 16),

                          // Password
                          CustomTextField(
                            // label: '',
                            hint: 'Password',
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
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.textHint,
                                size: 18,
                              ),
                              onPressed: () => setState(() =>
                                  _isPasswordVisible = !_isPasswordVisible),
                            ),
                          ),
                          const SizedBox(height: 24),
                          _buildRememberMeRow(),

                          const SizedBox(height: 18),

                          // Sign in button
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleSignIn,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
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
                                  : Text('Sign In',
                                      style: AppTextStyles.buttonText
                                          .copyWith(color: Colors.white)),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Sign up prompt
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "You haven't any account? ",
                                style: AppTextStyles.bodyMedium
                                    .copyWith(fontSize: 14),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, RouteNames.signUp),
                                child: Text('Sign Up',
                                    style: AppTextStyles.link.copyWith(
                                        decoration: TextDecoration.none)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 36),
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

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('OR',
              style: AppTextStyles.bodySmall
                  .copyWith(color: const Color(0xFF4E5D78))),
        ),
        const Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }

  Widget _buildSocialButton(String text, String assetPath) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFf6f7f8),
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextButton.icon(
        onPressed: () {}, // Later integrate OAuth if needed
        icon: Image.asset(assetPath, width: 16, height: 16),
        label: Text(
          text,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: const Color(0xFF959faf),
          ),
        ),
      ),
    );
  }

  Widget _buildRememberMeRow() {
    return Row(
      children: [
        Checkbox(
          value: _rememberMe,
          onChanged: (value) => setState(() => _rememberMe = value ?? false),
          activeColor: AppColors.primary,
        ),
        const SizedBox(width: 8),
        Text(
          'Remember me',
          style:
              AppTextStyles.bodyMedium.copyWith(color: const Color(0xFF7f8b9c)),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ForgotPasswordScreen()));
          },
          child: Text(
            'Forgot Password?',
            style: AppTextStyles.bodyMedium
                .copyWith(color: const Color(0xFF7f8b9c)),
          ),
        ),
      ],
    );
  }
}
