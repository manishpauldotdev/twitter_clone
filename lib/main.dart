import 'package:flutter/material.dart';
import 'package:twitter_clone/features/auth/views/signup_view.dart';
import 'package:twitter_clone/theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: const Scaffold(
        body: Center(
          child: SignupView(),
        ),
      ),
    );
  }
}
