// lib/screens/auth/sign_up_screen.dart
import 'package:flutter/material.dart';
import 'package:lii_lab_assessment/services/auth_service.dart';
import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../utils/validators.dart';
import '../../constants/mock_data.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dobController = TextEditingController();

  String _selectedLanguage = mockLanguages.first;

  String _gender = 'Male';
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final authService = AuthService();
    final success = await authService.signUp(
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
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Select your date of birth',
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  // Header
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
                  const SizedBox(height: 32),
                  Text('Getting Started',
                      style: AppTextStyles.heading3
                          .copyWith(color: const Color(0xFF4E5D78))),
                  const SizedBox(height: 12),
                  Text(
                    'Create an account to continue and connect with the people.',
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: const Color(0xFF4e5d78), fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  // Social Login Buttons (you can link later)
                  Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () {},
                          icon:
                              Image.asset('assets/icons/Google.png', width: 16),
                          label: Text('Log in with Google',
                              style: AppTextStyles.bodyMedium
                                  .copyWith(fontSize: 12)),
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFf6f7f8),
                            padding: const EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () {},
                          icon:
                              Image.asset('assets/icons/Apple.png', width: 16),
                          label: Text('Log in with Apple',
                              style: AppTextStyles.bodyMedium
                                  .copyWith(fontSize: 12)),
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFf6f7f8),
                            padding: const EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: const [
                      Expanded(child: Divider(color: AppColors.border)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('OR',
                            style: TextStyle(color: Color(0xFF4E5D78))),
                      ),
                      Expanded(child: Divider(color: AppColors.border)),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Form Fields
                  CustomTextField(
                    hint: 'Your Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                    prefixIcon: const Icon(Icons.alternate_email,
                        color: Color.fromARGB(255, 156, 163, 175), size: 18),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hint: 'Your Name',
                    controller: _nameController,
                    prefixIcon: const Icon(Icons.person_outline,
                        color: AppColors.textHint, size: 18),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hint: 'Create Password',
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    validator: Validators.password,
                    prefixIcon: const Icon(Icons.lock_outline,
                        color: AppColors.textHint, size: 18),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.textHint,
                        size: 18,
                      ),
                      onPressed: () => setState(
                          () => _isPasswordVisible = !_isPasswordVisible),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: CustomTextField(
                        hint: 'Date of birth',
                        controller: _dobController,
                        prefixIcon: const Icon(Icons.calendar_today,
                            color: AppColors.textHint, size: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Gender Selection
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.male, color: AppColors.textHint),
                        const SizedBox(width: 10),
                        Radio<String>(
                          value: 'Male',
                          groupValue: _gender,
                          onChanged: (value) =>
                              setState(() => _gender = value!),
                        ),
                        const Text('Male'),
                        Radio<String>(
                          value: 'Female',
                          groupValue: _gender,
                          onChanged: (value) =>
                              setState(() => _gender = value!),
                        ),
                        const Text('Female'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleSignUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF377cfe),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white))
                          : Text('Sign Up',
                              style: AppTextStyles.buttonText
                                  .copyWith(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ",
                          style: AppTextStyles.bodyMedium),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Sign In',
                            style: AppTextStyles.link
                                .copyWith(decoration: TextDecoration.none)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
