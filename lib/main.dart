import 'package:flutter/material.dart';
import 'constants/colors.dart';
import 'constants/text_styles.dart';
import 'constants/route_names.dart';
import 'screens/auth/sign_in_screen.dart';
import 'screens/auth/sign_up_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/feed/home_page.dart'; // If needed
import 'screens/feed/feed_screen.dart'; // If needed

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lii Lab Assessment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.textPrimary),
          titleTextStyle: AppTextStyles.appBarTitle,
        ),
      ),
      initialRoute: RouteNames.signIn,
      routes: {
        RouteNames.signIn: (context) => const SignInScreen(),
        RouteNames.signUp: (context) => const SignUpScreen(),
        //forgot password screen
        RouteNames.forgotPass: (context) => const ForgotPasswordScreen(),
        RouteNames.home: (context) =>  HomePage(),
        // RouteNames.feed: (context) => const FeedScreen(), // Optional example
      },
    );
  }
}
